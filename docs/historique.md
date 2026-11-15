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
  P11 --> P12["Phase 12<br/>Refonte Styles & Biblio"]
  P12 --> P13["Phase 13<br/>Tableaux Paysages & Notes"]
```

---

## 1. Socle Ancien *(compacté)*
- **Phases 1–7 :** Refonte `.agents/` & `AGENTS.md`, `sync-mcp.ps1`, skill `markdown-to-latex`, alignement `.vscode/`, `ClasseGuillaume.cls`, `clean.ps1`, règle `> [!CAUTION]`.
- **Phases 8–10 :** Options `french`/`english`, `.chktexrc-en`, gouvernance `docs/plan.md` + `docs/historique.md`, `ClasseGuillaumeSlides v2.0` (4 palettes / 3 styles).

---

## 2. Évolution Récente *(synthétique)*
- **Phase 11 — Création modulaire de [`projets/portefolio_2/`](file:///c:/Users/guill/dev/perso/latex/general/projets/portefolio_2/README.md) & rétroportage :** migration de `portefolio_1` vers `ClasseGuillaume v2.0` (`lua-ul`, `\todoH` sécurisé) avec parité rédactionnelle stricte ([diagnostic](file:///c:/Users/guill/dev/perso/latex/general/projets/portefolio_2/docs/diagnostic-avertissements-compilation.md)).
- **Phase 12 — Refonte éditoriale, Vancouver & typographie `portefolio_2` ([refonte](file:///c:/Users/guill/dev/perso/latex/general/projets/portefolio_2/docs/refonte-styles-et-bibliographie.md), [Q&R](file:///c:/Users/guill/dev/perso/latex/general/projets/portefolio_2/docs/questions-typographie-et-latex.md)) :** palette `CoverNavy`/`CoverPlum`/`CoverSky`/`CoverSlate`, `spacing=double` + listes `\singlespacing`, `siunitx` (`mode = text`), biblio Vancouver nettoyée, notes vertes `GuillaumeVertStyle` et `\let\textsc\@firstofone` rétroporté.

---

## 3. Session Courante *(détaillée — sera compactée au prochain changement majeur)*
- **Phase 13 — Harmonisation des tableaux paysages (`Tableau I.1` p. 4 & `Tableau V.1` p. 43–44) ([fiche](file:///c:/Users/guill/dev/perso/latex/general/projets/portefolio_2/docs/harmonisation-tableaux-paysages.md)) :**
  - **Orientation unifiée `landscape` (`pdflscape`) :** conversion de [`les-hypotheses-diagnostiques.tex`](file:///c:/Users/guill/dev/perso/latex/general/projets/portefolio_2/content/tables/les-hypotheses-diagnostiques.tex) de `sidewaystable` vers `landscape` + suppression de `\geometrieLarge`/`\geometrieWord` dans [`01-cas-clinique.tex`](file:///c:/Users/guill/dev/perso/latex/general/projets/portefolio_2/content/01-cas-diagnostique/01-cas-clinique.tex).
  - **Style unifié & notes d'abréviations ([`portefolio-style.sty`](file:///c:/Users/guill/dev/perso/latex/general/projets/portefolio_2/config/portefolio-style.sty), [`medication-cas-polypathologique-penche.tex`](file:///c:/Users/guill/dev/perso/latex/general/projets/portefolio_2/content/tables/medication-cas-polypathologique-penche.tex)) :** retrait de `\rowcolor{gray!15}` et du gras superflu, double filet continu `\hhline`, légende de suite `\tableSuiteCaption`, notes `ThreePartTable` (`ᵃ cp : comprimé ; ᵇ inh : inhalation.`), liste `tableitemize`, suppression de 9 `\vspace{-3mm}`/`\parbox` et correction `\par` avant `\endgroup` (`Overfull \hbox` passé de `10.95pt` à `0`).
  - **Validation :** compilation à froid LuaLaTeX + Biber (`68` p., `0` erreur, `0` `Overfull`/`Underfull`, `2` `Marginpar` p. 16/18 préexistants), inspection PNG pp. 4, 43 et 44, et parité textuelle maintenue.
