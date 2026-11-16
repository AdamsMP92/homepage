#!/usr/bin/env ruby
# frozen_string_literal: true

require "net/http"
require "uri"

SOURCE = URI("https://raw.githubusercontent.com/AdamsMP92/publication_bibliography/main/AdamsPublications.bib")
TARGET = File.expand_path("../_bibliography/papers.bib", __dir__)
SELECTED_KEYS = %w[
  Adams2026Landscape
  Adams2026minimal
  Adams2026NuMagSANS
  Titov2025SpinDisorder
].freeze
ARXIV_IDS = {
  "Hortschitz2026MagneticOntology" => "2609.11464",
  "Adams2026ReducedVortex" => "2608.16720",
  "Holt2026BeyondStonerWohlfarth" => "2607.29249",
  "Rai2026PolarizedVortexAssemblies" => "2606.18791",
  "Adams2026Landscape" => "2603.29830",
  "Adams2026NuMagSANS" => "2601.18444",
  "Adams2026minimal" => "2601.17176",
  "Titov2025SpinDisorder" => "2507.01666",
  "Jefremovas2025OxidizedMagnetite" => "2506.20571",
  "Kuchkin2025BlochPoints" => "2405.20798",
  "Adams2024Nutation" => "2405.14586",
  "Rai2024FeNbB" => "2405.14324",
  "Adams2024TractorMagnets" => "2405.06402",
  "Adams2024vortex" => "2404.15826",
  "Sinaga2024DMI" => "2402.00558",
  "Adams2024Signature" => "2311.05706",
  "Bersweiler2023Fingerprint" => "2303.15330",
  "Adams2023GreensFunction" => "2302.05773",
  "Adams2023AngularIUCrJ" => "2210.08406",
  "Sinaga2023PoreDefects" => "2207.09164",
  "Adams2022NeelAtomistic" => "2205.07552",
  "Adams2022NeelAnalytical" => "2205.07549",
  "Bersweiler2022Softness" => "2109.04107"
}.freeze

# The independent bibliography repository is intentionally kept as the upstream
# source. These website-side corrections reconcile it with the author's
# WordPress publication list and official DOI metadata. Keeping the corrections
# here prevents a later sync from silently restoring obsolete preprint or
# incomplete DOI records.
ENTRY_UPDATES = {
  "Adams2026ClimatePhaseSpace" => {
    fields: {
      "additional_info" => "Available on [Research Square](https://www.researchsquare.com/article/rs-11351600/v1)"
    }
  },
  "Adams2026ReducedVortex" => {
    type: "article",
    remove: %w[note],
    fields: {
      "journal" => "Physical Review Research",
      "volume" => "8",
      "number" => "4",
      "pages" => "043133",
      "doi" => "10.1103/mhfg-6sjm",
      "url" => "https://doi.org/10.1103/mhfg-6sjm"
    }
  },
  "Fangohr2026MaMMoS" => {
    remove: %w[note],
    fields: {
      "volume" => "62",
      "number" => "10",
      "pages" => "7001606",
      "doi" => "10.1109/TMAG.2026.3689962",
      "url" => "https://doi.org/10.1109/TMAG.2026.3689962"
    }
  },
  "Jefremovas2025OxidizedMagnetite" => {
    fields: {
      "number" => "45",
      "doi" => "10.1039/D5NR02700D",
      "url" => "https://doi.org/10.1039/D5NR02700D"
    }
  },
  "Adams2025PhD" => {
    fields: {
      "pdf" => "https://drive.google.com/drive/folders/1nY8UV-8x1_rOnZHz8e9-xwjPDMMD1mE6?usp=sharing",
      "website" => "https://hdl.handle.net/10993/65624"
    }
  },
  "Adams2024TractorMagnets" => {
    fields: {
      "number" => "8",
      "doi" => "10.1119/5.0198262",
      "url" => "https://doi.org/10.1119/5.0198262"
    }
  },
  "Adams2024NeutronNews" => {
    fields: {
      "volume" => "35",
      "number" => "2",
      "pages" => "2--5",
      "doi" => "10.1080/10448632.2024.2355849",
      "url" => "https://doi.org/10.1080/10448632.2024.2355849"
    }
  },
  "Adams2023GreensFunction" => {
    fields: {
      "number" => "10",
      "doi" => "10.1088/1402-4896/acf5b0",
      "url" => "https://doi.org/10.1088/1402-4896/acf5b0"
    }
  },
  "Bersweiler2022Resolving" => {
    fields: {
      "volume" => "33",
      "number" => "2",
      "pages" => "15--17",
      "doi" => "10.1080/10448632.2022.2050641",
      "url" => "https://doi.org/10.1080/10448632.2022.2050641"
    }
  },
  "Bersweiler2022Softness" => {
    fields: {
      "number" => "1",
      "doi" => "10.1107/S2052252521010605",
      "url" => "https://doi.org/10.1107/S2052252521010605"
    }
  },
  "Braband2020TorqueSensitivity" => {
    fields: {
      "number" => "2",
      "doi" => "10.1016/j.ifacol.2020.12.939",
      "url" => "https://doi.org/10.1016/j.ifacol.2020.12.939"
    }
  },
  "Adams2018COMSOL" => {
    fields: {
      "website" => "https://www.comsol.com/paper/empirical-verification-of-comsol-simulation-of-resonance-frequency-of-an-archimedean-spiral-coil-63381"
    }
  }
}.freeze

def fetch(uri, redirects_left = 5)
  raise "Too many redirects while fetching #{SOURCE}" if redirects_left.zero?

  response = Net::HTTP.get_response(uri)
  case response
  when Net::HTTPSuccess
    response.body
  when Net::HTTPRedirection
    fetch(URI.join(uri, response.fetch("location")), redirects_left - 1)
  else
    raise "Could not fetch bibliography: HTTP #{response.code} #{response.message}"
  end
end

def update_entry!(bib, key, update)
  pattern = /^@\w+\{#{Regexp.escape(key)},\n.*?^\}\n?/m
  entry = bib[pattern]
  raise "Publication key not found for metadata update: #{key}" unless entry

  entry.sub!(/\A@\w+\{/, "@#{update[:type]}{") if update[:type]

  Array(update[:remove]).each do |field|
    entry.gsub!(/^  #{Regexp.escape(field)} = \{[^\n]*\},?\n/, "")
  end

  update.fetch(:fields, {}).each do |field, value|
    field_pattern = /^  #{Regexp.escape(field)} = \{[^\n]*\},?\n/
    if entry.match?(field_pattern)
      entry.sub!(field_pattern, "  #{field} = {#{value}},\n")
    else
      entry = entry.rstrip
      entry.sub!(/([^,\n])\n\}\z/, "\\1,\n}")
      entry.sub!(/\n\}\z/, "\n  #{field} = {#{value}}\n}")
    end
  end

  entry.sub!(/,\n\}\z/, "\n}")
  bib.sub!(pattern, "#{entry.rstrip}\n")
end

def decorate(raw_bib)
  bib = raw_bib.sub(
    "% Michael P. Adams -- full publication record",
    "% Michael P. Adams -- full publication record\n" \
      "% Source: https://github.com/AdamsMP92/publication_bibliography\n" \
      "% Website-only fields (selected, bibtex_show, code, arxiv) are added by scripts/sync_publications.rb."
  )

  bib.sub!(
    "% 32 outputs. Check REVIEW_NOTES before publishing; missing DOIs have not been invented.",
    "% 32 outputs.\n% Website metadata reconciled with the WordPress publication list and DOI registries on 16 November 2026."
  )

  bib.gsub!(/^(@\w+\{[^,\n]+,\n)/, "\\1  bibtex_show = {true},\n")

  ENTRY_UPDATES.each do |key, update|
    update_entry!(bib, key, update)
  end

  SELECTED_KEYS.each do |key|
    pattern = /(@\w+\{#{Regexp.escape(key)},\n(?:  bibtex_show = \{true\},\n))/
    raise "Publication key not found: #{key}" unless bib.match?(pattern)

    bib.sub!(pattern, "\\1  selected = {true},\n")
  end

  numag_pattern = /(bibtex_show = \{true\},\n  selected = \{true\},\n)(  author = \{Adams, Michael P\. and Michels, Andreas\},\n  title = \{\{\{NuMagSANS\})/
  raise "NuMagSANS entry could not be decorated" unless bib.match?(numag_pattern)

  bib.sub!(numag_pattern, "\\1  code = {https://github.com/AdamsMP92/NuMagSANS},\n\\2")

  ARXIV_IDS.each do |key, arxiv_id|
    entry_pattern = /^@\w+\{#{Regexp.escape(key)},\n.*?(?=^@\w+\{|\z)/m
    entry = bib[entry_pattern]
    raise "Publication key not found for arXiv link: #{key}" unless entry

    existing_id = entry[/^\s*arxiv\s*=\s*\{([^}]+)\}/, 1]
    if existing_id
      raise "Unexpected arXiv ID for #{key}: #{existing_id}" unless existing_id == arxiv_id

      next
    end

    bib.sub!(/^(@\w+\{#{Regexp.escape(key)},\n)/, "\\1  arxiv = {#{arxiv_id}},\n")
  end

  "---\n---\n\n#{bib.strip}\n"
end

output = decorate(fetch(SOURCE))
File.write(TARGET, output)
puts "Updated #{TARGET}"
