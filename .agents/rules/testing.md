# Compilation, Tests & Contrôle Qualité (Zéro Erreur)

## 1. Règle Obligatoire de Contrôle Post-Édition

À la fin de **chaque ajout ou modification de code LaTeX** :
1. **Compiler le document cible** jusqu'à stabilisation (LuaLaTeX + Biber dans `build/`).
2. **Exiger zéro erreur de compilation** (code retour `0`, `build/main.pdf` produit et non vide).
3. **Analyser `build/main.log` et réduire les avertissements au minimum :**
   - Vérifier l'absence de `There were undefined references`, `Citation ... undefined`, `Missing character: There is no ... in font`, `scrlayer-scrpage Warning` (`\headheight`), `typearea Warning`, ou erreur Biber (`WARN`).
   - Traquer et corriger les `Overfull \hbox` et `Underfull \hbox` évitables (reformulation, colonnes `L`/`Y`/`X` de `tabularx`, `\allowbreak`, `xurl`).
4. **Exécuter le linting statique** (`chktex` avec `.chktexrc` et/ou `lint-latex.ps1`).

---

## 2. Commandes de Compilation & Nettoyage

```powershell
# Depuis un projet suivant template_officiel (utilise latexmkrc : LuaLaTeX + Biber + outdir=build)
latexmk

# Ou explicitement sans latexmkrc :
latexmk -lualatex -outdir=build -interaction=nonstopmode -synctex=1 main.tex

# Nettoyage des fichiers auxiliaires (conserve le PDF) / purge totale (avec PDF) :
latexmk -c
latexmk -C
```

---

## 3. Diagnostic Rapide de `build/main.log`

```powershell
# Extraire erreurs et avertissements critiques du log après compilation :
Select-String -Path "build\main.log" -Pattern "^!|LaTeX Warning:|Package .* Warning:|Missing character:|Overfull \\hbox"
```

| Message dans `build/main.log` | Cause fréquente | Correctif |
| :--- | :--- | :--- |
| `! Undefined control sequence` / `! LaTeX Error:` | Macro inconnue, accolade ou caractère spécial non échappé (`_`, `%`, `&`) | Inspecter la ligne `l.<num>`, échapper ou charger le package |
| `Missing character: There is no ...` | Symbole mathématique en mode texte (`\rightarrow`) | Encadrer en mode math : `$\rightarrow$` |
| `scrlayer-scrpage Warning: \headheight` | `\newgeometry` sans `headheight` / `footskip` | Ajouter `headheight=20pt, footskip=28pt` (ou utiliser `\geometrieWord` / `\geometrieLarge`) |
| `fontspec` : fichier de police introuvable | Chemin `fonts/` absent ou nom de police invalide | Vérifier `fonts/` ou l'option `font=...` dans `\documentclass` |
| `Citation '...' undefined` / `undefined references` | Clé absente de `biblio/references.bib` ou passe manquante | Vérifier `.bib` et relancer `latexmk` (Biber + passes LuaLaTeX) |

---

## 4. Linting Statique & Formatage

```powershell
# Contrôle ChkTeX (s'appuie automatiquement sur le .chktexrc local)
chktex -q -v0 main.tex content\*.tex backmatter\*.tex frontmatter\*.tex

# Audit typographique du dépôt (.agents)
.\.agents\skills\latex-quality-auditor\scripts\lint-latex.ps1 -TargetDir "projets\<nom_projet>" -RunChkTeX

# Formatage automatique (2 espaces)
latexindent -w -s <fichier.tex>
```
