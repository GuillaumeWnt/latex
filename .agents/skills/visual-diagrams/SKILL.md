---
name: visual-diagrams
description: >-
  Utiliser ce skill pour concevoir, éditer ou intégrer des schémas techniques, diagrammes de flux
  et figures vectorielles via Draw.io MCP (io.draw/mcp) ou TikZ/tcolorbox (cadreFigure) en LaTeX.
---

# Skill : Diagrammes Visuels & Schémas Techniques

Workflow de conception et d'intégration de figures vectorielles dans les projets basés sur `templates/template_officiel/` via Draw.io (`io.draw/mcp`) et TikZ/PGFPlots natif.

---

## 1. Draw.io MCP vs TikZ Natif

| Besoin | Outil recommandé | Emplacement dans `template_officiel` |
| :--- | :--- | :--- |
| Architectures systèmes, topologies réseau, schémas blocs complexes | Draw.io (`io.draw/mcp`) | `figures/<nom>.drawio.xml` + export vectoriel `.pdf` |
| Organigrammes, automates, courbes de données, figures héritant des polices | TikZ / `standalone` / `pgfplots` | `figures/tikz/<nom>.tex` (précompilé `.pdf`) ou `figures/<nom>.tikz` |

---

## 2. Procédure Rapide

### Schéma Draw.io (`io.draw/mcp`)
1. Identifier les nœuds, flux et hiérarchies ; utiliser `search_shapes` si des icônes métier sont nécessaires.
2. Générer le diagramme avec `create_diagram` et sauvegarder la source dans `figures/<nom>.drawio.xml`.
3. Exporter en PDF vectoriel dans `figures/<nom>.pdf` puis l'intégrer dans `figure` + `cadreFigure`.

### Schéma TikZ Natif
1. Privilégier la compilation autonome `standalone` dans `figures/tikz/<nom>.tex` $\rightarrow$ `figures/tikz/<nom>.pdf` (accélère `latexmk`).
2. Utiliser le positionnement relatif (`positioning`) et les couleurs du thème (`ThesisPrimary`, `ThesisSecondary`, `ThesisAccent`).
3. Encapsuler dans `figure` (ou `illustration`) avec `\begin{cadreFigure}[width=0.9\linewidth]` et `\label{fig:...}` après `\caption{...}`.

---

## 3. Références & Exemples

- **[Guide Draw.io MCP](./references/drawio-mcp-guide.md)**
- **[Aide-Mémoire TikZ & `cadreFigure`](./references/tikz-tcolorbox-cheatsheet.md)**
- **[Exemple Organigramme TikZ](./examples/sample-flowchart.tex)**
- **[Exemple `cadreFigure`](./examples/sample-cadre-figure.tex)**
- **[Exemple Architecture Draw.io](./examples/sample-architecture.drawio.xml)**
