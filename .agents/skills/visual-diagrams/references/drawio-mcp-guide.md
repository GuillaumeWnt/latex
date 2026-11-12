# Guide Draw.io MCP (`io.draw/mcp`)

Conventions d'utilisation du serveur MCP `io.draw/mcp` dans l'écosystème `template_officiel`.

---

## 1. Outils MCP Principaux

- **`create_diagram` :** Génère ou édite un graphe Draw.io (`<mxGraphModel>`) à partir de nœuds, connecteurs et styles structurés.
- **`search_shapes` :** Recherche des bibliothèques de formes (UML, ERD, Flowchart, BPMN, réseau, cloud).

---

## 2. Intégration dans `templates/template_officiel/`

1. **Stockage :** Enregistrer les sources `.drawio` / `.drawio.xml` dans `figures/` (ou `figures/diagrams/` si nombreuses).
2. **Export vectoriel :** Toujours exporter en `.pdf` vectoriel dans `figures/<nom>.pdf` (netteté infinie, polices vectorielles).
3. **Harmonie visuelle :**
   - Polices neutres sans-serif (Helvetica / Arial / TeX Gyre Heros), taille relative 9–11 pt.
   - Palette douce coordonnée à `mythesis-screen.clo` : fond `#F6F8FB`, bleu marine `#0F3C6E`, sarcelle `#146E78`, corail `#BE4B28`, bordures `#334155`.
