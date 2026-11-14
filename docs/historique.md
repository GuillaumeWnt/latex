# Historique Synthétique du Projet (`general`)

> **Mécanisme actif :** Ce document résume l'évolution du dépôt en **3 horizons à compaction progressive** pour permettre à toute IA de comprendre le contexte en un minimum de tokens (~45–60 lignes max). Les phases anciennes sont condensées en une ligne ; la session courante est détaillée puis compactée lors des demandes suivantes.

```mermaid
flowchart LR
  P1["Phases 1-2<br/>Refonte .agents & AGENTS"] --> P3["Phase 3<br/>Skill markdown-to-latex"]
  P3 --> P4["Phase 4<br/>Déduplication .vscode"]
  P4 --> P56["Phases 5-6<br/>ClasseGuillaume & clean.ps1"]
  P56 --> P7["Phase 7<br/>Règle !CAUTION & Audits"]
  P7 --> P89["Phases 8-9<br/>FR/EN, .ignore & Slides v1"]
  P89 --> P10["Phase 10<br/>Slides v2.0 & Règle Plan/Hist"]
  P10 --> P11["Phase 11<br/>portefolio_2 & Rétroportage"]
```

---

## 1. Socle Ancien *(compacté)*
- **Phases 1–2 :** Refonte de `AGENTS.md` et `.agents/` (suppression du MCP `memory` et modèles obsolètes), script `sync-mcp.ps1` corrigé en UTF-8 sans BOM.
- **Phases 3–4 :** Création du skill `markdown-to-latex`, workflows associés, et déduplication/alignement de `.vscode/` sur la configuration globale.
- **Phases 5–6 :** Renommage de la classe en `ClasseGuillaume.cls`, sécurisation de `clean.ps1` (préservation du PDF et des logs) et assouplissement des citations.
- **Phase 7 :** Ajout de la règle globale de proposition visible (`> [!CAUTION]`) et audits linguistique / extensions / `.ignore`.

---

## 2. Évolution Récente *(synthétique)*
- **Phase 8 — Support bilingue FR/EN & `.ignore` :** option `french`/`english` dans `ClasseGuillaume`, `.chktexrc-en`, option `-Language` dans `lint-latex.ps1` et conservation des artefacts `*.pdf`/`*.log`/`*.bbl`/`*.blg`.
- **Phase 9 — Exclusions globales & `ClasseGuillaumeSlides v1` :** transfert des exclusions génériques vers les réglages globaux, création de `templates/template_slides/` et `<projet>/slides/` (`integrated`).
- **Phase 10 — Gouvernance Plan/Hist & `ClasseGuillaumeSlides v2.0` :** règle globale `docs/plan.md` éphémère + `docs/historique.md` compact, archivage visuel [`templates/exemples-slides/`](file:///c:/Users/guill/dev/perso/latex/general/templates/exemples-slides), refonte 4 palettes / 3 styles / composants ouverts de `ClasseGuillaumeSlides v2.0` et veille MCP présentation ([`docs/compte-rendu-et-reponses.md`](file:///c:/Users/guill/dev/perso/latex/general/docs/compte-rendu-et-reponses.md)).

---

## 3. Session Courante *(détaillée — sera compactée au prochain changement majeur)*
- **Phase 11 — Refonte modulaire de `portefolio_1` en [`projets/portefolio_2/`](file:///c:/Users/guill/dev/perso/latex/general/projets/portefolio_2/README.md) & rétroportage :**
  - **Rétroportage `templates/template_officiel/` :** ajout des options publiques `font=comicsans`, `bibstyle=custom|vancouver` (chaînes FR *consulté le* / *disponible sur*) et `spacing=single|onehalf|double` (`setspace` sans affecter titres/TOC), détection locale dans `fonts/` (`\CalibriFont`, `\AsapFont`, `\ComicSansMSFont`), paquets `rotating`/`xltabular`/`float`, garde `\ifstrempty` sur `\todoH` et `\singlespacing` sur `\thesistodolist`, documentés dans `README.md` et `appendix-a.tex`.
  - **Architecture [`projets/portefolio_2/`](file:///c:/Users/guill/dev/perso/latex/general/projets/portefolio_2/main.tex) :** séparation stricte selon `template_officiel`, style dédié [`config/portefolio-style.sty`](file:///c:/Users/guill/dev/perso/latex/general/projets/portefolio_2/config/portefolio-style.sty) (`mdtRed`, `Calibri` + `Asap Condensed`, `Chapitre I` romain centré, en-tête seul sans logo/pied de page, `\geometrieWord` 2,5 cm / `\geometrieLarge` 1 cm synchronisés sans alerte `typearea`, `hidelinks`, `\todoH` sous `lua-ul` UTF-8 avec URL cliquables), rapatriement intégral des pages de garde, polices, figures, archives de tableaux et fichiers orphelins (`docs/`) sans modifier un seul mot du texte rédactionnel.
  - **Validation :** compilation à froid LuaLaTeX + Biber (`portefolio_2` : 70 p., 0 erreur fatale, 0 `Overfull \hbox`, 1 seul avertissement `Marginpar on page 16 moved` ; non-régression `template_officiel` : 56 p., 0 erreur fatale, 1 avertissement préexistant) et contrôle visuel PNG comparatif.
