# Diagnostic des 129 avertissements dans l'IDE (`portefolio_2`)

Ce document explique pourquoi l'éditeur (panneau *Problèmes* / compteur LaTeX Workshop) affiche **129 avertissements** alors que la compilation LuaLaTeX du projet [`portefolio_2`](../README.md) réussit quasi silencieusement.

---

## 1. Distinction entre compilateur (LuaLaTeX) et linter (ChkTeX)

Le compteur **129** additionne deux sources distinctes dans l'extension **LaTeX Workshop** (`james-yu.latex-workshop`, activée par [`.vscode/settings.json`](../../../.vscode/settings.json)) :

| Source | Outil | Nombre | Rôle |
| :--- | :--- | :---: | :--- |
| Journal de compilation (`build/main.log`) | LuaLaTeX | **2** | Véritables alertes de mise en page pendant la génération du PDF |
| Analyse syntaxique statique (`.tex`) | ChkTeX | **127** | Recommandations typographiques/stylistiques sur le code source LaTeX |
| **Total affiché dans l'IDE** | **LaTeX Workshop** | **129** | Somme affichée dans le compteur *Problèmes* |

---

## 2. Détail des 2 messages issus de la compilation (`build/main.log`)

À l'issue de la compilation à froid (`latexmk` / LuaLaTeX + Biber), le journal [`build/main.log`](../build/main.log) contient :
- **0 erreur fatale** (`!`), **0 `Overfull \hbox`**, **0 caractère manquant** et **0 avertissement Biber** ([`build/main.blg`](../build/main.blg)) ;
- **1 avertissement LaTeX bénin :** `LaTeX Warning: Marginpar on page 16 moved.` (décalage automatique entre deux notes marginales `\todoH` très proches dans [`content/02-activite-exterieure/01-resume-activite.tex`](../content/02-activite-exterieure/01-resume-activite.tex)) ;
- **1 boîte sous-remplie :** `Underfull \hbox (badness 3240) in paragraph at lines 35--35` (dans une colonne étroite de [`content/tables/les-hypotheses-diagnostiques.tex`](../content/tables/les-hypotheses-diagnostiques.tex)), comptée parce que le réglage par défaut `latex-workshop.message.badbox.show` vaut `"both"`.

---

## 3. Détail des 127 avertissements issus de ChkTeX

Dans [`.vscode/settings.json`](../../../.vscode/settings.json), la ligne `"latex-workshop.linting.chktex.enabled": true` lance automatiquement **ChkTeX** sur [`main.tex`](../main.tex) avec les arguments par défaut de LaTeX Workshop (`-wall -n22 -n30 -e16 -q`) et le fichier local [`.chktexrc`](../.chktexrc) :

```text
chktex -wall -n22 -n30 -e16 -q -l .chktexrc -f"%f:%l:%c:%d:%k:%n:%m\n" main.tex
```

Cette exécution produit exactement **127 avertissements**, tous **hérités du source d'origine `portefolio_1`** (conservés volontairement pour ne modifier aucun mot ni la mise en forme quadrillée des tableaux) :

| Code ChkTeX | Occurrences | Signification et origine dans `portefolio_2` |
| :--- | :---: | :--- |
| **Warning 19** | **50** | *« Use `'` (ASCII 39) instead of `’` (ASCII 180) »* — Faux positif UTF-8 activé par `-wall` sur les apostrophes typographiques `’` (`U+2019`), que ChkTeX (conçu avant UTF-8) interprète octet par octet |
| **Warning 44** | **33** | `\hline` détecté dans les tableaux (règle `booktabs` de `.chktexrc`) — conservé intentionnellement pour préserver les bordures quadrillées d'origine |
| **Warning 13** | **13** | Espacement inter-phrases `\@` suggéré après majuscules/abréviations en fin de mot (ex. `HFpEF`, `BAV`) |
| **Warning 18** | **12** | Guillemets droits `"` au lieu de `` `` `` / `''` (notamment dans l'équation de recherche PubMed) |
| **Warning 2** | **9** | Espace sécable recommandée (`~`) avant `\cite` / `\ref` |
| **Warning 8** | **7** | Tiret `-` au lieu de `--` dans le texte d'origine |
| **Warning 11** | **2** | `...` au lieu de `\ldots` |
| **Warning 37** | **1** | Espace devant parenthèse fermante dans l'équation PubMed |

---

## 4. Pistes d'allègement du bruit (sans toucher au texte rédigé)

Si vous souhaitez réduire ce compteur **sans modifier un seul mot du portfolio** :
1. **Éliminer les 50 faux positifs UTF-8 (`-n19`) :** ajouter `-n19` dans `CmdLine` de [`.chktexrc`](../.chktexrc) (le compteur passe immédiatement de 129 à **79**).
2. **Tolérer temporairement les styles hérités de `portefolio_1` dans `.chktexrc` local :** désactiver aussi `-n2`, `-n8`, `-n11`, `-n13`, `-n18`, `-n37` et retirer ou assouplir la règle regex sur `\hline` (`Warning 44`) uniquement dans `projets/portefolio_2/.chktexrc`.
3. **Masquer les `Underfull` dans l'éditeur (optionnel) :** passer `latex-workshop.message.badbox.show` à `"overfull"` dans vos réglages utilisateur VS Code si vous ne voulez voir que les débordements réels (`0` dans `portefolio_2`).
