#!/usr/bin/env Rscript
# =============================================================================
# aggregate_flyway_tables.R
# =============================================================================
# Stack every species subtable (tableN.csv) from the four Flyway Data Books /
# HIP Books into ONE annotated long-format CSV.
#
# Why long format?
#   The 498 source CSVs have ~68 different column layouts (state-wide harvest
#   matrices, abundance estimates with SEs, hunter-activity tables keyed by
#   species code, ...). A long format (one row = one number) is the only shape
#   that can hold all of them in a single data.frame without losing anything.
#
# How the annotation works
#   The CSVs themselves carry no species names. Each one is matched to its
#   "Data Table N: <label>" heading and "Table N. <caption>" in the companion
#   HTML book (same flyway, same book type), and that metadata is attached to
#   every row. Where the numbering disagrees (a few Mississippi tables) the
#   script falls back on the unit/region code inside the CSV, or the species
#   code (`spp`) inside the CSV, and records how it decided in
#   `annotation_source` and `qc_flag`.
#
# Output columns (aggregated CSV)
#   flyway, book, book_section, table_id, table_label, caption, data_source
#   species, species_group, population, qualifier, season_type, measure_tag
#   data_category
#   period, period_type                  (year, or HIP season start year)
#   unit, state, region, spp_code, aou, species_in_table, model
#                                        (categorical keys present in the table)
#   variable, entity, entity_type, stat  (what the number is)
#   value, value_text                    (numeric value; text if non-numeric)
#   annotation_source, qc_flag, source_file, source_row
#
# Usage (command line)
#   Rscript aggregate_flyway_tables.R
#   Rscript aggregate_flyway_tables.R --root "US-Flyway-Data/Flyway Data Books" \
#           --out flyway_species_long.csv --catalog flyway_table_catalog.csv
#   Rscript aggregate_flyway_tables.R --keep-na      # keep NA cells too
#   Rscript aggregate_flyway_tables.R --slim --out flyway_species_long.csv.gz
#       # full output is ~240 MB (over GitHub's 100 MB limit); --slim and/or a
#       # .gz name make it repo-friendly. Caption/source text then lives in the
#       # catalog CSV (join on flyway + book + table_id).
#
# Usage (RStudio / interactive)
#   source("aggregate_flyway_tables.R")
#   res <- aggregate_flyway_tables()             # finds the data automatically
#   res <- aggregate_flyway_tables(slim = TRUE, out = "flyway_species_long.csv.gz")
#   res$data      # the aggregated data.frame
#   res$catalog   # one row per source CSV (annotation + QC summary)
#
# Requires: R >= 4.1 and the packages readr, dplyr, tidyr, stringr, xml2
#           (all installed with the tidyverse).
# =============================================================================

for (pkg in c("readr", "dplyr", "tidyr", "stringr", "xml2")) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    stop("Package '", pkg, "' is required: install.packages(\"", pkg, "\")", call. = FALSE)
  }
}
suppressPackageStartupMessages({
  library(readr)
  library(dplyr)
  library(tidyr)
  library(stringr)
})

# -----------------------------------------------------------------------------
# Constants
# -----------------------------------------------------------------------------
POP_CODES <- c("MP", "EP", "RMP", "CMU", "EMU", "WMU", "CMR", "EMR", "WAP", "WIP",
               "PP", "IP", "PFP", "AK", "LCRVP", "WP")
POP_RE    <- paste(POP_CODES, collapse = "|")

# trailing tags on a label that describe *what was measured*, not the species
LABEL_TAGS <- c(
  "\\s+WBPHS$"                  = "WBPHS survey",
  "\\s+State Surveys$"          = "State surveys",
  "\\s+Hunter Seasonal Bag$"    = "Hunter seasonal bag",
  "\\s+Hunter Seasonal Harvest$" = "Hunter seasonal harvest",
  "\\s+Seasonal Harvest$"       = "Hunter seasonal harvest",
  "\\s+Hunter Days$"            = "Hunter days",
  "\\s+Hunters$"                = "Hunters",
  "\\s+Age Ratios by Sex$"      = "Age ratios by sex",
  "\\s+Sex Ratios by Age$"      = "Sex ratios by age",
  "\\s+Age Ratios$"             = "Age ratios",
  "\\s+Sex Ratios$"             = "Sex ratios"
)
# "Teal, Blue-winged" style labels -> "Blue-winged Teal"
INVERT_HEADS <- c("Teal", "Scaup", "Goldeneye", "Merganser", "Dove", "Scoter",
                  "Whistling Duck")
ALIASES <- c(  # keyed by lower-case, hyphens -> spaces
  "red breasted merganser" = "Red-breasted Merganser",
  "snipe"                  = "Wilson's Snipe",
  "duck"                   = "Duck (all species)",
  "goose"                  = "Goose (all species)",
  "swan"                   = "Swan (all species)",
  "snow and blue geese"    = "Snow and Blue Goose",
  "harlequin"              = "Harlequin Duck"
)
SPECIES_GROUPS <- c(  # first match wins
  "swan"                                   = "Swans",
  "crane"                                  = "Cranes",
  "dove|pigeon"                            = "Doves & pigeons",
  "goose|geese|brant"                      = "Geese & brant",
  "duck|mallard|teal|pintail|gadwall|wigeon|shoveler|canvasback|redhead|scaup|goldeneye|bufflehead|merganser|eider|scoter|harlequin|ruddy|whistling" = "Ducks",
  "woodcock|snipe|rail|coot|gallinule|sora" = "Rails, coots, snipe & woodcock"
)
DIM_PERIOD <- c("year", "season")
DIM_CATEGORICAL <- c(  # csv column -> output column
  unit = "unit", state = "state", region = "region", spp = "spp_code",
  aou = "aou", species = "species_in_table", model = "model"
)
TABLE_STATS <- c("estimate", "se", "mean", "median", "sd", "lower", "upper", "l95ci",
                 "u95ci", "l70ci", "u70ci", "m3yr", "m3yr_se", "index", "trend",
                 "routes", "year1", "year2")
US_STATES <- strsplit(paste(
  "al ak az ar ca co ct de fl ga hi id il in ia ks ky la me md ma mi mn",
  "ms mo mt ne nv nh nj nm ny nc nd oh ok or pa ri sc sd tn tx ut vt va",
  "wa wv wi wy"), " ")[[1]]
ENTITY_TYPES <- c(
  setNames(rep("state", length(US_STATES)), US_STATES),
  pf = "flyway", cf = "flyway", mf = "flyway", af = "flyway",
  us = "country", can = "country", on = "province", bc = "province"
)
DATA_CATEGORY <- c(  # ordered regexes over "caption label tag"
  "age ratio"                        = "Age ratio",
  "sex ratio"                        = "Sex ratio",
  "compliance"                       = "Hunter compliance",
  "hunter days|days afield|\\bdays\\b" = "Hunter days",
  "seasonal (bag|harvest)|per hunter" = "Seasonal harvest per hunter",
  "\\bhunters\\b"                    = "Hunters",
  "harvest|crippling"                = "Harvest",
  "abundance|breeding pairs|population|index|survey|count" = "Abundance / index",
  "trend"                            = "Trend",
  "ponds"                            = "Ponds"
)
MGMT_UNITS <- c("CMU", "EMU", "WMU", "CMR", "EMR")  # not AK/MP/...: AK is also a state code

# -----------------------------------------------------------------------------
# Small helpers
# -----------------------------------------------------------------------------
na_chr <- NA_character_

# Python-style list repr, e.g. ['CMU', 'EMU'] -- used inside qc_flag text
py_list <- function(x) {
  x <- sort(unique(x), method = "radix")
  if (length(x) == 0) "[]" else paste0("['", paste(x, collapse = "', '"), "']")
}

# first non-empty value, else NA
first_or_na <- function(x) if (length(x) > 0) x[[1]] else na_chr

html_unescape <- function(x) {
  vapply(x, function(s) {
    if (is.na(s) || !grepl("&", s, fixed = TRUE)) return(s)
    xml2::xml_text(xml2::read_html(paste0("<body>", s, "</body>")))
  }, character(1), USE.NAMES = FALSE)
}

clean_html <- function(x) {
  x <- str_replace_all(x, "<[^>]+>", " ")
  x <- html_unescape(x)
  x <- str_replace_all(x, "\u2019", "'")
  str_squish(x)
}

# -----------------------------------------------------------------------------
# HTML catalog: one row per "Data Table N: label" heading in any flyway HTML book
# -----------------------------------------------------------------------------
build_catalog <- function(root) {
  rel <- list.files(root, pattern = "\\.html$", recursive = TRUE)
  rel <- rel[str_count(rel, "/") == 1]                       # */*.html
  rel <- rel[order(dirname(rel), basename(rel), method = "radix")]
  rows <- list()

  for (r in rel) {
    flyway <- str_replace(dirname(r), " Flyway", "")
    book   <- if (grepl("HIP", basename(r), fixed = TRUE)) "HIP Book" else "Data Book"
    text   <- read_file(file.path(root, r))
    pos    <- str_locate(text, fixed("<main"))[1, "start"]
    if (!is.na(pos)) text <- str_sub(text, pos)

    m      <- gregexpr("(?s)<h[23][^>]*>.*?</h[23]>", text, perl = TRUE)
    heads  <- regmatches(text, m)[[1]]
    bodies <- regmatches(text, m, invert = TRUE)[[1]][-1]   # body i follows heading i
    section <- na_chr

    for (i in seq_along(heads)) {
      title <- clean_html(heads[i])
      if (startsWith(heads[i], "<h2")) { section <- title; next }
      mt <- str_match(title, "^Data Table (\\w+):\\s*(.*)$")
      if (is.na(mt[1, 1])) next
      body <- bodies[i]

      caps <- str_match_all(body, regex("<caption>(.*?)</caption>", dotall = TRUE))[[1]][, 2]
      caps <- if (length(caps)) clean_html(caps) else character(0)
      caption <- first_or_na(caps[str_detect(caps, "^Table \\w+\\.")])

      paras <- str_match_all(body, regex("<p>(.*?)</p>", dotall = TRUE))[[1]][, 2]
      p0    <- str_squish(str_replace_all(paras, "<[^>]+>", " "))
      src   <- first_or_na(paras[str_detect(str_to_lower(p0), "^original data source")])
      source <- if (is.na(src)) na_chr else clean_html(src)

      rows[[length(rows) + 1]] <- data.frame(
        flyway = flyway, book = book, book_section = section, table_id = mt[1, 2],
        table_label = mt[1, 3],
        caption = if (is.na(caption)) na_chr else str_replace(caption, "^Table \\w+\\.\\s*", ""),
        data_source = if (is.na(source)) na_chr
                      else str_replace(source, regex("^Original data source:\\s*", ignore_case = TRUE), ""),
        stringsAsFactors = FALSE
      )
    }
  }
  bind_rows(rows)
}

# -----------------------------------------------------------------------------
# Label parsing ("Dove, Mourning CMU Hunter Days" -> species/population/measure)
# -----------------------------------------------------------------------------
species_group <- function(species) {
  s <- if (is.na(species)) "" else str_to_lower(species)
  for (pat in names(SPECIES_GROUPS)) if (str_detect(s, pat)) return(SPECIES_GROUPS[[pat]])
  "Other"
}

parse_label <- function(label) {
  out <- list(species = na_chr, population = na_chr, qualifier = na_chr,
              season_type = na_chr, measure_tag = na_chr)
  s <- str_trim(str_replace_all(label, "\u2019", "'"))

  m <- str_match(s, "^Light Goose CO (Hunters|Days|Harvest|Crippling)$")
  if (!is.na(m[1, 1])) {
    out$species     <- "Light Goose"
    out$measure_tag <- paste0("Conservation order ", str_to_lower(m[1, 2]))
    return(out)
  }

  for (pat in names(LABEL_TAGS)) {
    if (str_detect(s, pat)) {
      s <- str_replace(s, pat, "")
      out$measure_tag <- LABEL_TAGS[[pat]]
      break
    }
  }
  m <- str_match(s, "\\s+(Early|Regular)$")
  if (!is.na(m[1, 1])) {
    s <- str_sub(s, 1, str_locate(s, "\\s+(Early|Regular)$")[1, "start"] - 1)
    out$season_type <- m[1, 2]
  }
  # only season-like parentheticals are qualifiers; "(minima)" stays part of the population
  q_pat <- "\\s*\\(((?:spring|summer|fall|winter)[^)]*)\\)\\s*$"
  m <- str_match(s, q_pat)
  if (!is.na(m[1, 1])) {
    s <- str_sub(s, 1, str_locate(s, q_pat)[1, "start"] - 1)
    out$qualifier <- m[1, 2]
  }

  species <- na_chr; population <- na_chr
  m_pop <- if (!str_detect(s, ",")) str_match(s, paste0("^(.*?)\\s+(", POP_RE, ")$")) else NULL
  m_mid <- str_match(s, "^(Midcontinent|Western) Mallard$")
  if (!is.null(m_pop) && !is.na(m_pop[1, 1])) {            # "American Woodcock CMR"
    species <- m_pop[1, 2]; population <- m_pop[1, 3]
  } else if (!is.na(m_mid[1, 1])) {
    population <- str_split(s, " ", simplify = TRUE)[1]; species <- "Mallard"
  } else if (str_detect(s, ",")) {
    parts <- str_split_fixed(s, ",", 2)
    head  <- str_trim(parts[1, 1]); rest <- str_trim(parts[1, 2])
    if (head %in% INVERT_HEADS) {                          # "Teal, Blue-winged" / "Dove, Mourning CMU"
      mm <- str_match(rest, paste0("^(.*?)(?:\\s+(", POP_RE, "))?$"))
      species <- paste(mm[1, 2], head); population <- mm[1, 3]
    } else {                                               # "Sandhill Crane, MP" / "Brant, Pacific"
      species <- head; population <- rest
    }
  } else {
    species <- s
  }

  key <- str_to_lower(str_replace_all(species, "-", " "))
  out$species    <- if (key %in% names(ALIASES)) ALIASES[[key]] else species
  out$population <- population
  out
}

data_category <- function(caption, label, tag) {
  blob <- str_to_lower(paste(
    if (is.na(caption)) "" else caption,
    if (is.na(label)) "" else label,
    if (is.na(tag)) "" else tag))
  for (pat in names(DATA_CATEGORY)) if (str_detect(blob, pat)) return(DATA_CATEGORY[[pat]])
  na_chr
}

# -----------------------------------------------------------------------------
# CSV handling
# -----------------------------------------------------------------------------
# column name -> (entity, stat).  'a1_se' -> ('a1','se'); 'estimate' -> (NA,'estimate')
split_variable <- function(v) {
  entity <- rep(na_chr, length(v)); stat <- rep(na_chr, length(v))
  is_stat <- v %in% TABLE_STATS
  stat[is_stat] <- v[is_stat]
  rest <- which(!is_stat)
  if (length(rest)) {
    mm  <- str_match(v[rest], "^(.+)_(se|va|sd|l95ci|u95ci)$")
    has <- !is.na(mm[, 1])
    entity[rest] <- ifelse(has, mm[, 2], v[rest])
    stat[rest]   <- ifelse(has, mm[, 3], "value")
  }
  data.frame(entity = entity, stat = stat, stringsAsFactors = FALSE)
}

read_table_csv <- function(path) {
  read_csv(path, col_types = cols(.default = col_character()), na = c("NA", ""),
           trim_ws = FALSE, progress = FALSE, show_col_types = FALSE,
           name_repair = "minimal")
}

# management-unit codes found in the CSV's unit/region column
csv_unit_values <- function(df) {
  vals <- character(0)
  for (col in c("unit", "region")) {
    if (col %in% names(df)) vals <- c(vals, str_to_upper(unique(na.omit(df[[col]]))))
  }
  intersect(unique(vals), MGMT_UNITS)
}

label_pops <- function(label) {
  MGMT_UNITS[str_detect(label, paste0("\\b", MGMT_UNITS, "\\b"))]
}

# most frequent value, ties -> first seen (same as Python's Counter.most_common(1))
mode_first <- function(x) {
  tab <- table(factor(x, levels = unique(x)))
  names(tab)[which.max(tab)]
}

find_root <- function() {
  parents <- function(d) { out <- d; repeat { p <- dirname(d); if (p == d) break; out <- c(out, p); d <- p }; out }
  script_dir <- tryCatch({
    fa <- grep("^--file=", commandArgs(FALSE), value = TRUE)
    if (length(fa)) dirname(normalizePath(sub("^--file=", "", fa[1]))) else dirname(normalizePath(sys.frame(1)$ofile))
  }, error = function(e) NA_character_)
  bases <- unique(c(parents(getwd()), if (!is.na(script_dir)) parents(script_dir)))
  for (b in bases) {
    cand <- file.path(b, "US-Flyway-Data", "Flyway Data Books")
    if (dir.exists(cand)) return(normalizePath(cand))
  }
  NULL
}

# -----------------------------------------------------------------------------
# Main
# -----------------------------------------------------------------------------
aggregate_flyway_tables <- function(root = NULL,
                                    out = "flyway_species_long.csv",
                                    catalog = "flyway_table_catalog.csv",
                                    keep_na = FALSE, slim = FALSE) {
  if (is.null(root)) root <- find_root()
  if (is.null(root) || !dir.exists(root)) {
    stop("Could not find 'US-Flyway-Data/Flyway Data Books'; pass root = ...", call. = FALSE)
  }
  root <- normalizePath(root)

  cat_df  <- build_catalog(root)
  cat_key <- paste(cat_df$flyway, cat_df$book, cat_df$table_id, sep = "|")
  cat(sprintf("catalog: %d table headings from %d HTML books\n",
              nrow(cat_df), nrow(distinct(cat_df, flyway, book))))

  # ---- pass 1: read every CSV, resolve its heading ---------------------------
  rel <- list.files(root, pattern = "^table.*\\.csv$", recursive = TRUE)
  rel <- rel[str_detect(rel, "^[^/]+/Supplemental Data/[^/]+/table\\w+\\.csv$")]
  parts <- str_split_fixed(rel, "/", 4)                      # flyway | Supplemental Data | book dir | file
  rel   <- rel[order(parts[, 1], parts[, 3], parts[, 4], method = "radix")]

  items <- vector("list", length(rel))
  for (k in seq_along(rel)) {
    p      <- str_split_fixed(rel[k], "/", 4)
    flyway <- str_replace(p[1, 1], " Flyway", "")
    book   <- if (grepl("HIP", p[1, 3], fixed = TRUE)) "HIP Book" else "Data Book"
    tid    <- str_match(p[1, 4], "^table(\\w+)\\.csv$")[1, 2]
    df     <- read_table_csv(file.path(root, rel[k]))
    flags  <- character(0); how <- "html_heading"; drop_population <- FALSE

    idx       <- match(paste(flyway, book, tid, sep = "|"), cat_key)
    entry     <- if (is.na(idx)) NULL else as.list(cat_df[idx, ])
    all_units <- csv_unit_values(df)
    units     <- if (length(all_units) == 1) all_units else character(0)  # single-unit files can be cross-checked
    sibs_all  <- which(cat_df$flyway == flyway & cat_df$book == book &
                         cat_df$table_id %in% paste0(tid, letters))

    # (a) a unit/region code inside the CSV disagrees with the heading's label,
    #     or there is no heading: try the lettered siblings (9 -> 9a/9b, 85 -> 85b)
    if (is.null(entry) || (length(units) > 0 && length(intersect(units, label_pops(entry$table_label))) == 0)) {
      sibs <- sibs_all[vapply(sibs_all, function(j)
        length(intersect(units, label_pops(cat_df$table_label[j]))) > 0, logical(1))]
      if (length(sibs) == 1) {
        if (!is.null(entry)) {
          flags <- c(flags, sprintf("relabelled:%s->%s (csv unit %s)", tid, cat_df$table_id[sibs], py_list(units)))
        }
        entry <- as.list(cat_df[sibs, ]); how <- "html_heading+unit_code"
      } else if (!is.null(entry)) {
        flags <- c(flags, sprintf("unit_label_mismatch (csv unit %s)", py_list(units)))
      }
    }

    # (b) no heading, but the CSV combines several lettered headings (9 = 9a + 9b):
    #     annotate at species level and let the unit/region column carry the population
    if (is.null(entry) && length(sibs_all) >= 2) {
      combined <- str_trim(str_replace_all(cat_df$table_label[sibs_all],
                                           paste0(",?\\s*\\b(?:", paste(MGMT_UNITS, collapse = "|"), ")\\b"), ""))
      if (length(unique(combined)) == 1) {
        entry <- as.list(cat_df[sibs_all[1], ])
        entry$table_id    <- tid
        entry$table_label <- combined[1]
        entry$caption     <- paste(ifelse(is.na(cat_df$caption[sibs_all]), "", cat_df$caption[sibs_all]), collapse = " | ")
        how   <- "html_heading_siblings"
        flags <- c(flags, paste0("csv combines headings ", paste(cat_df$table_id[sibs_all], collapse = "+")))
      }
    }

    # (c) the label names ONE population but the file holds several: the label is
    #     only partly right, so don't pin every row to it (unit/region column is truth)
    if (!is.null(entry) && length(all_units) > 1 && length(label_pops(entry$table_label)) > 0 &&
        how == "html_heading") {
      drop_population <- TRUE
      flags <- c(flags, sprintf("label names %s but csv holds %s",
                                py_list(label_pops(entry$table_label)), py_list(all_units)))
    }
    items[[k]] <- list(rel = rel[k], flyway = flyway, book = book, table_id = tid, df = df,
                       entry = entry, how = how, flags = flags, drop_population = drop_population)
  }

  # species-code lookup learned from tables that DO have a heading (spp -> species)
  v_code <- character(0); v_sp <- character(0)
  for (it in items) {
    if (!is.null(it$entry) && "spp" %in% names(it$df)) {
      sp    <- parse_label(it$entry$table_label)$species
      codes <- unique(na.omit(it$df$spp))
      v_code <- c(v_code, codes); v_sp <- c(v_sp, rep(sp, length(codes)))
    }
  }
  spp_lookup <- vapply(split(v_sp, factor(v_code, levels = unique(v_code))), mode_first, character(1))
  # hunter-activity measure learned from the column signature (days / act / bag / ret)
  SIGS <- c("days", "act", "bag", "ret")
  v_sig <- character(0); v_tag <- character(0)
  for (it in items) {
    sig <- first_or_na(intersect(SIGS, names(it$df)))
    if (!is.na(sig) && !is.null(it$entry)) {
      tag <- parse_label(it$entry$table_label)$measure_tag
      if (!is.na(tag)) { v_sig <- c(v_sig, sig); v_tag <- c(v_tag, tag) }
    }
  }
  sig_lookup <- vapply(split(v_tag, factor(v_sig, levels = unique(v_sig))), mode_first, character(1))

  # ---- pass 2: melt to long ---------------------------------------------------
  key_ord <- order(vapply(items, `[[`, "", "flyway"), vapply(items, `[[`, "", "book"),
                   as.integer(str_extract(vapply(items, `[[`, "", "table_id"), "^\\d+")),
                   str_extract(vapply(items, `[[`, "", "table_id"), "[a-z]*$"), method = "radix")
  frames <- vector("list", length(items)); cat_rows <- vector("list", length(items))

  for (n in seq_along(key_ord)) {
    it <- items[[key_ord[n]]]
    df <- it$df; entry <- it$entry; flags <- it$flags; how <- it$how

    if (!is.null(entry)) {
      meta <- parse_label(entry$table_label)
      if (it$drop_population) meta$population <- na_chr
      ann <- list(book_section = entry$book_section, table_label = entry$table_label,
                  caption = entry$caption, data_source = entry$data_source)
    } else {                                                # no heading anywhere: use spp code
      codes   <- if ("spp" %in% names(df)) unique(na.omit(df$spp)) else character(0)
      species <- if (length(codes) == 1 && codes %in% names(spp_lookup)) spp_lookup[[codes]] else na_chr
      sig     <- first_or_na(intersect(SIGS, names(df)))
      meta <- list(species = if (!is.na(species)) species else if (length(codes) == 1) codes else na_chr,
                   population = na_chr, qualifier = na_chr, season_type = na_chr,
                   measure_tag = if (!is.na(sig) && sig %in% names(sig_lookup)) sig_lookup[[sig]] else na_chr)
      ann <- list(book_section = na_chr, table_label = na_chr, caption = na_chr, data_source = na_chr)
      how <- if (!is.na(species)) "spp_code_lookup" else "unresolved"
      flags <- c(flags, paste0("no_html_heading", if (is.na(species)) "; species_code_unknown" else ""))
    }

    dims   <- names(df)[names(df) %in% c(DIM_PERIOD, names(DIM_CATEGORICAL))]
    values <- setdiff(names(df), dims)
    df$source_row <- seq_len(nrow(df))
    long <- pivot_longer(df, cols = all_of(values), names_to = "variable", values_to = "raw",
                         cols_vary = "slowest")             # column-major, like pandas melt
    num <- suppressWarnings(as.numeric(long$raw))
    long$value      <- num
    long$value_text <- ifelse(is.na(num) & !is.na(long$raw), long$raw, na_chr)
    if (!keep_na) long <- long[!is.na(long$raw), , drop = FALSE]
    long$raw <- NULL

    per_col <- first_or_na(intersect(DIM_PERIOD, dims))
    long$period      <- if (!is.na(per_col)) suppressWarnings(as.numeric(long[[per_col]])) else rep(NA_real_, nrow(long))
    long$period_type <- rep(per_col, nrow(long))
    for (old in intersect(names(DIM_CATEGORICAL), names(long))) {
      names(long)[names(long) == old] <- DIM_CATEGORICAL[[old]]
    }
    long <- long[, setdiff(names(long), DIM_PERIOD), drop = FALSE]

    vars <- unique(long$variable)
    sv   <- split_variable(vars)
    ix   <- match(long$variable, vars)
    long$entity <- sv$entity[ix]
    long$stat   <- sv$stat[ix]
    etype <- unname(ENTITY_TYPES[str_to_lower(long$entity)])
    long$entity_type <- ifelse(!is.na(long$entity) & long$stat %in% c("value", "se", "va"), etype, na_chr)
    long$entity      <- ifelse(!is.na(etype), str_to_upper(long$entity), long$entity)

    qc <- if (length(flags)) paste(flags, collapse = "; ") else na_chr
    meta_cols <- c(meta, list(species_group = species_group(meta$species),
                              data_category = data_category(ann$caption, ann$table_label, meta$measure_tag)))
    adds <- c(list(flyway = it$flyway, book = it$book, table_id = it$table_id), ann, meta_cols,
              list(annotation_source = how, qc_flag = qc, source_file = file.path(basename(root), it$rel)))
    for (nm in names(adds)) long[[nm]] <- rep(as.character(adds[[nm]]), nrow(long))

    frames[[n]] <- long
    cat_rows[[n]] <- data.frame(
      flyway = it$flyway, book = it$book, table_id = it$table_id, species = meta$species,
      table_label = ann$table_label, book_section = ann$book_section, caption = ann$caption,
      data_source = ann$data_source, annotation_source = how, qc_flag = qc,
      n_rows = nrow(df), n_long_rows = nrow(long),
      columns = paste(setdiff(names(df), "source_row"), collapse = " "),
      source_file = file.path(basename(root), it$rel), stringsAsFactors = FALSE)
  }

  out_df <- bind_rows(frames)
  col_order <- c("flyway", "book", "book_section", "table_id", "table_label", "caption", "data_source",
                 "species", "species_group", "population", "qualifier", "season_type", "measure_tag",
                 "data_category", "period", "period_type", "unit", "state", "region", "spp_code", "aou",
                 "species_in_table", "model", "variable", "entity", "entity_type", "stat", "value",
                 "value_text", "annotation_source", "qc_flag", "source_file", "source_row")
  for (cn in setdiff(col_order, names(out_df))) out_df[[cn]] <- na_chr
  out_df <- out_df[, col_order]
  if (slim) out_df <- out_df[, setdiff(col_order, c("caption", "data_source", "source_file"))]
  cat_out <- bind_rows(cat_rows)

  write_csv(out_df, out, na = "")                           # a .csv.gz name is compressed automatically
  write_csv(cat_out, catalog, na = "")

  # ---- report -----------------------------------------------------------------
  cat(sprintf("wrote %s  (%s rows x %d cols) from %d CSVs\n", out,
              format(nrow(out_df), big.mark = ","), ncol(out_df), length(items)))
  cat(sprintf("wrote %s  (%d tables)\n", catalog, nrow(cat_out)))
  src <- table(factor(cat_out$annotation_source, levels = unique(cat_out$annotation_source)))
  cat("annotation_source:", paste0(names(src), "=", as.integer(src), collapse = ", "), "\n")
  kind <- function(flag) {
    if (startsWith(flag, "label names")) return("label_population_dropped (csv holds several management units; see unit/region column)")
    if (startsWith(flag, "csv combines")) return("csv_combines_lettered_headings (e.g. 9 = 9a+9b)")
    sub(":.*$", "", sub(" \\(.*$", "", flag))
  }
  all_flags <- unlist(strsplit(na.omit(cat_out$qc_flag), "; ", fixed = TRUE))
  if (length(all_flags)) {
    kinds <- table(factor(vapply(all_flags, kind, ""), levels = unique(vapply(all_flags, kind, ""))))
    kinds <- kinds[order(-as.integer(kinds), method = "radix")]
    cat("qc_flag kinds (details per table in the catalog CSV):\n")
    for (nm in names(kinds)) cat(sprintf("  %4d  %s\n", kinds[[nm]], nm))
  }
  cat(sprintf("tables with NO species annotation: %d\n",
              sum(cat_out$annotation_source == "unresolved" | is.na(cat_out$species))))
  invisible(list(data = out_df, catalog = cat_out))
}

# -----------------------------------------------------------------------------
# Command-line entry point (Rscript only; sourcing in RStudio just defines the function)
# -----------------------------------------------------------------------------
if (!interactive() && sys.nframe() == 0L) {
  args <- commandArgs(trailingOnly = TRUE)
  opts <- list(root = NULL, out = "flyway_species_long.csv",
               catalog = "flyway_table_catalog.csv", keep_na = FALSE, slim = FALSE)
  i <- 1L
  while (i <= length(args)) {
    a <- args[i]
    val <- function() { i <<- i + 1L; args[i] }
    if (a %in% c("-h", "--help")) {
      cat("Usage: Rscript aggregate_flyway_tables.R [--root DIR] [--out FILE] [--catalog FILE] [--keep-na] [--slim]\n")
      quit(status = 0)
    } else if (a == "--keep-na") opts$keep_na <- TRUE
    else if (a == "--slim") opts$slim <- TRUE
    else if (a == "--root") opts$root <- val()
    else if (a == "--out") opts$out <- val()
    else if (a == "--catalog") opts$catalog <- val()
    else if (grepl("^--(root|out|catalog)=", a)) {
      opts[[sub("^--([a-z]+)=.*$", "\\1", a)]] <- sub("^--[a-z]+=", "", a)
    } else stop("Unknown argument: ", a, call. = FALSE)
    i <- i + 1L
  }
  do.call(aggregate_flyway_tables, opts)
} else if (interactive()) {
  message("Loaded. Run  res <- aggregate_flyway_tables()  (see the header for options).")
}
