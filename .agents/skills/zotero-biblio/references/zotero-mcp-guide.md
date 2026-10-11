# Zotero MCP Tool Guide (`zotero-citations`)

This guide details the capabilities of the `zotero-citations` MCP server and how to utilize them within LaTeX authoring workflows.

---

## 1. Search & Discovery Tools

### `zotero_search_items`
- **Use Case:** Find references already stored in the local Zotero library.
- **Parameters:**
  - `query`: Text search across title, creator, notes, and metadata.
  - `collection`: (Optional) Limit search to a specific collection key.
  - `tag`: (Optional) Filter by user tag.
  - `limit`: Number of results to return.

### `zotero_scholar`
- **Use Case:** Search Google Scholar for academic papers, citation counts, and BibTeX snippets.
- **Parameters:**
  - `query`: Search query (keywords, author, title).
  - `num_results`: Number of entries to retrieve.

### `zotero_semantic_search`
- **Use Case:** Find conceptually related literature in your library using embedding-based search rather than simple keyword matching.

---

## 2. Extraction & Evidence Synthesis

### `zotero_evidence_table`
- **Use Case:** Automatically extract structured comparisons across selected papers.
- **Parameters:**
  - `item_keys`: Array of Zotero item keys to include.
  - `fields`: Array of columns to extract (e.g., `["Objective", "Methodology", "Sample", "Results", "Limitations"]`).
- **LaTeX Integration:** Convert the extracted JSON/table into a `tabularx` environment inside `tables/evidence_table.tex`.

### `zotero_get_item`
- **Use Case:** Retrieve full metadata for a specific item key.
- **Fields of Interest for BibLaTeX:**
  - `title`, `creators` (authors/editors)
  - `publicationTitle` -> `journaltitle` / `booktitle`
  - `date` -> `year` / `date`
  - `DOI` -> `doi = {10.xxx}`
  - `url`, `urldate`
  - `abstractNote` -> used for synthesizing chapter context

---

## 3. Library Management & Export

### `zotero_export`
- **Use Case:** Export collections or selected items directly to BibLaTeX format.
- **Format Options:** `biblatex`, `bibtex`, `csljson`.

### `zotero_tag_audit`
- **Use Case:** Verify consistent tagging across literature collections to identify untagged or unread papers.

