---
name: zotero-biblio
description: >-
  Use this skill when searching academic literature, managing citations, interacting with Zotero via MCP,
  generating evidence tables, or maintaining BibLaTeX files (.bib) in Vancouver or author-year style.
---

# Zotero & Academic Bibliography Skill

This skill provides comprehensive instructions, runbooks, and automation tools for academic bibliography management using the `zotero-citations` MCP server and BibLaTeX/Biber in LaTeX documents.

---

## 1. Quick Reference Workflows

### Search Literature & Extract Citations
1. Call `zotero_search_items` or `zotero_scholar` to query papers by title, author, or keyword.
2. Inspect metadata with `zotero_get_item`.
3. Format the new BibLaTeX entry and append to `bib/references.bib`.
4. Ensure the citation key follows `[Author][Year]` convention.

### Generate Evidence Synthesis Tables
1. Collect reference items for your literature review topic.
2. Call `zotero_evidence_table` to synthesize study objectives, methodologies, sample sizes, and findings.
3. Adapt the output into a clean LaTeX table using [`sample-evidence-table.tex`](./examples/sample-evidence-table.tex).

### Bibliography Integrity Audit
Run the automated bibliography audit script to verify that all citation keys are valid and properly formatted:
```powershell
.\.agents\skills\zotero-biblio\scripts\audit-bib.ps1 -BibFile "bib/references.bib"
```

---

## 2. Reference Documentation
- **[Zotero MCP Tool Guide](./references/zotero-mcp-guide.md):** Complete documentation on available MCP tools, parameters, and typical workflows.
- **[Vancouver BibLaTeX Configuration](./references/vancouver-biblatex.md):** Guide to numeric citations, Biber options, and field requirements.

---

## 3. Examples & Assets
- **[Sample Evidence Table](./examples/sample-evidence-table.tex):** Modular `tabularx` table template for literature reviews.
- **[Clean BibLaTeX References](./examples/sample-references.bib):** Example `.bib` file adhering to modern standards (DOIs, capitalization protection).

