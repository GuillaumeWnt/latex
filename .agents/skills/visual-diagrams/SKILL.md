---
name: visual-diagrams
description: >-
  Use this skill when creating, editing, or integrating technical diagrams, flowcharts, architectures,
  and figures using Draw.io MCP (io.draw/mcp) or native TikZ/tcolorbox (cadreFigure) in LaTeX.
---

# Visual Diagrams & Technical Schematics Skill

This skill provides step-by-step instructions, reference manuals, and templates for designing and embedding technical diagrams in LaTeX documents using Draw.io (`io.draw/mcp`) and native TikZ.

---

## 1. Quick Workflows

### Generating Schematics via Draw.io MCP
1. Formulate diagram structure (nodes, relationships, containers).
2. Call `create_diagram` with diagram parameters or XML structure.
3. Save output to `images/diagrams/<name>.drawio.xml`.
4. Export as PDF/SVG vector graphic into `images/` or embed directly.

### Authoring Native TikZ Flowcharts
1. Place modular TikZ code inside `figures/<name>.tikz` or directly in a chapter.
2. Use relative positioning (`below=of ...`, `right=of ...`) rather than absolute coordinates.
3. Wrap in a figure environment or the document's custom `cadreFigure` container.

---

## 2. Reference Documentation
- **[Draw.io MCP Integration Guide](./references/drawio-mcp-guide.md):** Detailed guide to calling `create_diagram` and `search_shapes`.
- **[TikZ & tcolorbox Cheatsheet](./references/tikz-tcolorbox-cheatsheet.md):** Reusable styling presets, palette harmony, and `cadreFigure` wrapping.

---

## 3. Examples & Assets
- **[Sample Modular Flowchart](./examples/sample-flowchart.tex):** Clean TikZ flowchart with branching logic.
- **[Sample Architecture XML](./examples/sample-architecture.drawio.xml):** Production-ready Draw.io XML schema for multi-tier architectures.
- **[Sample Cadre Figure](./examples/sample-cadre-figure.tex):** Demonstration of `cadreFigure` usage in `ClasseGuillaume.cls`.

