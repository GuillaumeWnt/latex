# Guide du Graphe de Connaissances (`memory` MCP)

Ce guide définit le schéma recommandé pour stocker la mémoire persistante des projets basés sur `templates/template_officiel/`.

---

## 1. Types d'entités standardisés

| Type d'entité | Champs d'observation attendus | Exemple aligné `template_officiel` |
| :--- | :--- | :--- |
| `DocumentConfig` | Classe, moteur, police, mode | `{"name": "ProjetDemo", "observations": ["Class: mythesis.cls", "Engine: LuaLaTeX", "Font: texgyreheros (fonts/)", "Mode: screen / oneside"]}` |
| `GeometryPreset` | Marges, `headheight`, `footskip` | `{"name": "GeometrieOfficielle", "observations": ["2.5cm marges", "headheight=20pt", "footskip=28pt", "Sync via \\syncKomaGeometry"]}` |
| `GlossaryTerm` | Acronyme, définition, 1re occurrence | `{"name": "Term_PID", "observations": ["Proportionnel-Intégral-Dérivé", "Défini dans content/01-introduction.tex"]}` |
| `LiteratureEntity` | Clé BibLaTeX, auteurs, année, apport | `{"name": "dupont2024", "observations": ["Fichier: biblio/references.bib", "Style: custom-style (authoryear)"]}` |
| `ChapterMilestone` | Fichier `content/*.tex`, statut compilation | `{"name": "Ch03_Methodologie", "observations": ["Fichier: content/03-methodologie.tex", "Statut: validé, 0 erreur, 0 Overfull hbox"]}` |

---

## 2. Relations standardisées

| Source | Relation | Cible | Rôle |
| :--- | :--- | :--- | :--- |
| `DocumentConfig` | `uses_geometry` | `GeometryPreset` | Associe la géométrie active au projet |
| `ChapterMilestone` | `defines_term` | `GlossaryTerm` | Trace le chapitre d'introduction d'un terme |
| `ChapterMilestone` | `cites` | `LiteratureEntity` | Cartographie les dépendances bibliographiques |
| `LiteratureEntity` | `supports_claim` | `ResearchClaim` | Relie une affirmation à sa source |

---

## 3. Cycle de maintenance

1. **Ouverture de session :** lire le graphe (`search_nodes` / `read_graph`) avant de modifier un chapitre existant pour préserver la cohérence terminologique.
2. **Mise à jour continue :** ajouter les nouveaux termes, macros ou backports décidés pour `template_officiel`.
3. **Nettoyage :** purger via `delete_observations` / `delete_entities` les remarques temporaires (`\todoH`) une fois résolues.
