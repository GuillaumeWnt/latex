# Compte-Rendu des Modifications & Réponses Techniques

Ce document remplace les deux fichiers Markdown précédents et synthétise l'ensemble des actions réalisées ainsi que les réponses détaillées suite à ton dernier message.

---

## 1. Nouvelle règle globale inscrite & mise en évidence des demandes de règles

Conformément à ton accord, la boucle d'amélioration et d'obsolescence a été ajoutée dans les fichiers maîtres globaux puis propagée à toutes les IA de ton poste.

### Ce qui a été modifié
- **[`C:/Users/guill/.agents/AGENTS.md`](file:///C:/Users/guill/.agents/AGENTS.md)** (Section 3, points 2–3) et **[`C:/Users/guill/.agents/rules/04-gouvernance-et-securite.md`](file:///C:/Users/guill/.agents/rules/04-gouvernance-et-securite.md)** (Section 2, points 1–2) :
  - Toute règle devenue **obsolète**, redondante, inadaptée ou contradictoire, ainsi que toute **amélioration ou suggestion** pertinente, peut et doit être proposée proactivement par l'IA, **sans jamais être appliquée avant ton accord explicite**.
  - **Règle de mise en évidence ajoutée :** toute proposition d'ajout, de modification ou de suppression de règle doit désormais être affichée **tout en haut de la réponse** (ligne 1, avant tout résumé ou explication), dans un bloc d'alerte **`> [!CAUTION]`** titré **`🔴 ACTION REQUISE — PROPOSITION DE RÈGLE (VALIDATION UTILISATEUR)`**, en précisant le fichier ciblé, la justification et le texte exact proposé.
- **Synchronisation exécutée :** `powershell -NoProfile -ExecutionPolicy Bypass -File "C:\Users\guill\.agents\scripts\deploy-and-sync-global.ps1"` (`exit 0`) a propagé la mise à jour vers `C:\Users\guill\.claude\CLAUDE.md`, `C:\Users\guill\.gemini\GEMINI.md`, `C:\Users\guill\.cline\AGENTS.md`, `plugins\global-core\rules\AGENTS.md` et `%APPDATA%\Code\User\prompts\global.instructions.md` (les jonctions NTFS vers `rules\` pointent déjà directement sur `C:\Users\guill\.agents\rules\`).

### Pourquoi `> [!CAUTION]` + `🔴 **...**` tout en haut plutôt que du HTML rouge ?
En Markdown, les balises HTML comme `<span style="color:red">` ou `<font color="red">` sont ignorées ou affichées en texte brut dans plusieurs interfaces de chat et terminaux (Claude Code, CLI, aperçus sécurisés). À l'inverse :
- **`> [!CAUTION]`** est rendu nativement comme un **encadré rouge vif avec icône d'alerte** dans Antigravity, VS Code et GitHub ;
- **`🔴 **...**`** reste immédiatement repérable en rouge/gras même dans les clients qui affichent le Markdown brut ;
- Le placer **tout en haut de la réponse** garantit qu'il est impossible de passer à côté.

---

## 2. Adapter un projet LaTeX en anglais (français principal, anglais secondaire fréquent)

**Réponse :** **Oui, c'est tout à fait possible et facile à systématiser**, tout en conservant le français comme langue principale du socle. En auditant `templates/template_officiel/`, `lint-latex.ps1` et `.agents/`, voici **exactement** tous les points aujourd'hui couplés au français (et rien d'autre ne bloque l'anglais) :

### A. Inventaire exhaustif des réglages dépendants de la langue

| Fichier | Lignes / Élément | Ce qui est configuré pour le français | Adaptation pour un projet en anglais |
| :--- | :--- | :--- | :--- |
| [`templates/template_officiel/.chktexrc`](file:///c:/Users/guill/dev/perso/latex/general/templates/template_officiel/.chktexrc) | L16 `CmdLine { -n1 -n12 -n24 -n26 -n36 -n46 }` | **`-n26`** désactive l'avertissement *"Space may not precede punctuation"*, indispensable en français avant `:`, `;`, `?`, `!`. | Retirer **`-n26`** dans le `.chktexrc` d'un projet anglais pour que ChkTeX vérifie l'absence d'espace avant la ponctuation double anglaise. *(Conserver `-n1 -n12 -n24 -n36 -n46` et `Linker` : `word~\cite{}` et `see~\cref{}` restent recommandés en anglais contre les coupures orphelines.)* |
| [`config/packages.sty`](file:///c:/Users/guill/dev/perso/latex/general/templates/template_officiel/config/packages.sty) | L173 `\RequirePackage[english, french]{babel}` | `french` est placé en dernier $\rightarrow$ langue par défaut du document. | Passer en `[french, english]{babel}` (et encapsuler `\frenchsetup` uniquement quand le français est actif). *(Les lignes 183–195 sur `\captionsfrench` ne s'appliquent déjà qu'au français.)* |
| [`config/packages.sty`](file:///c:/Users/guill/dev/perso/latex/general/templates/template_officiel/config/packages.sty) | L229–236 `\sisetup{...}` (`siunitx`) | **`locale = FR`** (virgule décimale `12,5`) et **`range-phrase = { à }`**. | Basculer sur `locale = US` (ou `UK`) et `range-phrase = { to }` (ou `\textendash` selon le style). |
| [`config/packages.sty`](file:///c:/Users/guill/dev/perso/latex/general/templates/template_officiel/config/packages.sty) | L267–276 `\DeclareNewTOC` (`illustration`) | **`listname={Liste des illustrations}`** codé en français. | Remplacer par `listname={List of Illustrations}`. |
| [`config/packages.sty`](file:///c:/Users/guill/dev/perso/latex/general/templates/template_officiel/config/packages.sty) | L359–361 (`cleveref`) | `\RequirePackage[capitalise, noabbrev, french]{cleveref}` + `\crefname{appendix}{annexe}{annexes}`. | Utiliser l'option `english` dans `cleveref` et `appendix`/`appendices`. *(Note : `csquotes` avec `autostyle=true` L198 bascule déjà tout seul vers les guillemets anglais `“...”` !)* |
| [`config/macros.sty`](file:///c:/Users/guill/dev/perso/latex/general/templates/template_officiel/config/macros.sty) | L63, L86, L121, L147, L202–205, L325–327, L373 | Titres/préfixes par défaut en français : `Remarque`, `Point d'attention`, `Hypothèse`, `Définition`, `\crefname` (`hypothèse`/`définition`), profils `\todostyle` (`Auteur`, `Directeur`, `Rapporteur`) et `\thesistodolist` (`Tableau de Bord...`). | Traduire ces libellés (`Note`, `Attention`, `Hypothesis`, `Definition`, `Author`, `Supervisor`, `Reviewer`, `Revision Todo List`) ou les conditionner à l'option de langue. |
| [`ClasseGuillaume.cls`](file:///c:/Users/guill/dev/perso/latex/general/templates/template_officiel/ClasseGuillaume.cls) | L336 (`ThesisDebug` en mode `screen`) | `Page \thepage{} sur \pageref{LastPage}` (`sur` codé en dur). | Mettre `of` en anglais (`Page \thepage{} of \pageref{LastPage}`). *(Tout le reste de la classe — en-têtes `\chapapp`, KOMA-Script — suit déjà automatiquement `babel` !)* |
| [`biblio/custom-style.bbx`](file:///c:/Users/guill/dev/perso/latex/general/templates/template_officiel/biblio/custom-style.bbx) | L26–29 | `\DefineBibliographyStrings{french}{...}` est déjà correctement cantonné à la langue `french`. | Aucune retouche requise : en anglais, BibLaTeX utilise nativement ses chaînes anglaises (`and`, `see p.`, `see pp.`). |
| [`main.tex`](file:///c:/Users/guill/dev/perso/latex/general/templates/template_officiel/main.tex), [`titlepage.tex`](file:///c:/Users/guill/dev/perso/latex/general/templates/template_officiel/frontmatter/titlepage.tex), [`abstract.tex`](file:///c:/Users/guill/dev/perso/latex/general/templates/template_officiel/frontmatter/abstract.tex) | Texte d'exemple | `title={Références Bibliographiques}`, mentions de couverture en français, et petite espace française dans `\textbf{Keywords :}` (L43 de `abstract.tex`). | Adapter les textes de couverture/titres en anglais et écrire `\textbf{Keywords:}` sans espace avant `:`. |

### B. Ce qui fonctionne déjà sans modification en anglais
- **`lint-latex.ps1` :** ses 9 contrôles (`{\bf}`, `$$`, `|`, `\hline`, `~` avant citations/renvois, `\\` en fin de paragraphe, `\ref` manuel, `\caption` sans `\label`) restent pertinents en LaTeX anglais (en anglais scientifique, `word~\cite{...}` et `see~\cref{...}` sont également recommandés pour éviter qu'un `[1]` ou un numéro de figure ne passe seul à la ligne suivante).
- **Documents mixtes français + passages anglais :** `babel` charge déjà `[english, french]`, donc `\begin{otherlanguage}{english} ... \end{otherlanguage}` (déjà utilisé dans [`frontmatter/abstract.tex`](file:///c:/Users/guill/dev/perso/latex/general/templates/template_officiel/frontmatter/abstract.tex)) bascule immédiatement césures et guillemets `csquotes`.

### C. Implémentation réalisée suite à ta validation (`english` / `french`)
Le support bilingue complet est désormais intégré dans [`templates/template_officiel/`](file:///c:/Users/guill/dev/perso/latex/general/templates/template_officiel/README.md) et dans `.agents/`, avec le français conservé par défaut :
1. **Option de classe `english` / `french` dans [`ClasseGuillaume.cls`](file:///c:/Users/guill/dev/perso/latex/general/templates/template_officiel/ClasseGuillaume.cls) :**
   - Ajout de `\DeclareOption{english}` et `\DeclareOption{french}` (défaut `french`) et du conditionnel public `\ifenglishversion`.
   - Adaptation de l'en-tête/pied de page `ThesisDebug` (`[DEBUG / REVISION]`, `Profile`, `Font`, `Page X of Y`) lorsque `english` est actif (`hyperref` héritant déjà automatiquement la langue PDF depuis `babel`).
2. **Packages et macros localisés ([`config/packages.sty`](file:///c:/Users/guill/dev/perso/latex/general/templates/template_officiel/config/packages.sty) & [`config/macros.sty`](file:///c:/Users/guill/dev/perso/latex/general/templates/template_officiel/config/macros.sty)) :**
   - `babel` bascule vers `[french, english]` (tout en gardant la possibilité d'utiliser `otherlanguage{french}`), `siunitx` passe en `locale = US` avec `range-phrase = { to }`, `DeclareNewTOC{loi}` affiche `List of Illustrations`, et `cleveref` utilise `english` + `appendix`/`appendices`.
   - Titres par défaut des boîtes (`Note`, `Key Point`, `Hypothesis`, `Definition`), `\crefname` (`hypothesis`/`definition`), profils `\todostyle` (`Author`, `Supervisor`, `Reviewer`) et `\thesistodolist` traduits automatiquement en anglais lorsque l'option `english` est active.
   - Correction dans [`frontmatter/abstract.tex`](file:///c:/Users/guill/dev/perso/latex/general/templates/template_officiel/frontmatter/abstract.tex) : `\textbf{Keywords:}` sans espace typographique français devant `:`.
3. **Profil ChkTeX anglais ([`.chktexrc-en`](file:///c:/Users/guill/dev/perso/latex/general/templates/template_officiel/.chktexrc-en)) et outillage `.agents/` :**
   - Création de `.chktexrc-en` identique à `.chktexrc` mais **sans `-n26`**, afin de signaler toute espace fautive devant `: ; ? !` en anglais.
   - Mise à jour de [`lint-latex.ps1`](file:///c:/Users/guill/dev/perso/latex/general/.agents/skills/latex-quality-auditor/scripts/lint-latex.ps1) avec `-Language auto|french|english` : en mode `auto`, le script détecte l'option `english` dans `\documentclass[...]{ClasseGuillaume}` de `main.tex`, charge `.chktexrc-en` et active `-w26`.
   - Documentation mise à jour dans [`README.md`](file:///c:/Users/guill/dev/perso/latex/general/templates/template_officiel/README.md), [`backmatter/appendix-a.tex`](file:///c:/Users/guill/dev/perso/latex/general/templates/template_officiel/backmatter/appendix-a.tex), [`.agents/rules/general.md`](file:///c:/Users/guill/dev/perso/latex/general/.agents/rules/general.md), [`.agents/rules/architecture.md`](file:///c:/Users/guill/dev/perso/latex/general/.agents/rules/architecture.md), [`.agents/rules/testing.md`](file:///c:/Users/guill/dev/perso/latex/general/.agents/rules/testing.md), [`latex-quality-auditor/SKILL.md`](file:///c:/Users/guill/dev/perso/latex/general/.agents/skills/latex-quality-auditor/SKILL.md), [`new-project.md`](file:///c:/Users/guill/dev/perso/latex/general/.agents/workflows/new-project.md) et [`markdown-to-latex/SKILL.md`](file:///c:/Users/guill/dev/perso/latex/general/.agents/skills/markdown-to-latex/SKILL.md).

---

## 3. Profils VS Code : comment installer proprement des extensions ?

Dans [`C:/Users/guill/.agents/scripts/create-vscode-profiles.ps1`](file:///C:/Users/guill/.agents/scripts/create-vscode-profiles.ps1), les profils reposent sur deux listes :
- **`$coreExtIds`** (lignes 36–59) : le **socle de base de 18 extensions** inclus automatiquement dans les 3 profils (`socle-polyvalent`, `electronique-embarque`, `bases-de-donnees-pgsql`).
- **`$profileExtMap`** (lignes 61–75) : les extensions supplémentaires spécifiques à un profil (ex. `+7` pour l'électronique/PIO/PLC, `+1` `ms-ossdata.vscode-pgsql` pour PostgreSQL).

Point technique essentiel (lignes 23–25 et 256) : le script filtre les métadonnées depuis `C:\Users\guill\.vscode\extensions\extensions.json`. Une extension doit donc d'abord être téléchargée dans `C:\Users\guill\.vscode\extensions\` pour que le script puisse l'ajouter à un profil.

### Les 3 méthodes propres selon ton objectif

| Besoin | Procédure recommandée | Attention / Piège à éviter |
| :--- | :--- | :--- |
| **1. Ajouter durablement au « socle de base » ou à un profil du script** *(recommandé)* | 1. Installer l'extension une fois dans VS Code (`code --install-extension <editeur.extension>` ou via l'UI).<br>2. Ajouter son ID `"editeur.extension"` dans **`$coreExtIds`** *(pour les 3 profils)* ou dans **`$profileExtMap["<profil>"]`** de [`create-vscode-profiles.ps1`](file:///C:/Users/guill/.agents/scripts/create-vscode-profiles.ps1).<br>3. **Fermer toutes les fenêtres VS Code**, puis relancer `create-vscode-profiles.ps1`. | Si l'extension n'a jamais été téléchargée via VS Code/CLI avant de lancer le script, `$allExtensions` ne la contiendra pas encore. |
| **2. Ajouter rapidement dans un seul profil actif (UI ou CLI)** | - **UI :** basculer sur le profil voulu $\rightarrow$ installer l'extension depuis le Marketplace (ou clic roue dentée sur une extension $\rightarrow$ *Appliquer l'extension à tous les profils*).<br>- **CLI (`code.cmd` est dans le PATH) :** `code --profile "Socle Polyvalent (Python, LaTeX & IA)" --install-extension <editeur.extension>` | Si tu réexécutes plus tard `create-vscode-profiles.ps1`, celui-ci régénère les `extensions.json` des 3 profils depuis ses listes et écrasera un ajout fait uniquement à la main. |
| **3. Extension utile uniquement pour un projet précis** | Ajouter son ID dans `recommendations` du [`.vscode/extensions.json`](file:///c:/Users/guill/dev/perso/latex/general/.vscode/extensions.json) du dépôt. | N'alourdit pas les profils globaux ; VS Code propose de l'installer à l'ouverture du dossier. |

---

## 4. Inspection des fichiers `.ignore` / `.exclude` des différentes IA

Tous les fichiers d'exclusion présents dans le dépôt et dans tes dossiers globaux ont été inspectés (aucun fichier `*ignore*` global n'existe dans `C:\Users\guill\.agents\`, `.gemini\`, `.claude\` ou `.cline\`).

### État initial observé lors de l'audit (avant mise à jour)

1. **[`.aiexclude`](file:///c:/Users/guill/dev/perso/latex/general/.aiexclude), [`.claudeignore`](file:///c:/Users/guill/dev/perso/latex/general/.claudeignore), [`.geminiignore`](file:///c:/Users/guill/dev/perso/latex/general/.geminiignore)** *(initialement 36 lignes chacun)* :
   - **Secrets protégés :** `.env`, `.env.*`, `*.key`, `*.pem`, `*.secret`, `*.local.json`.
   - **Python & OS :** `.venv/`, `__pycache__/`, `*.pyc`, `.DS_Store`, `Thumbs.db`.
   - **Artefacts LaTeX ignorés :** `*.synctex.gz`, `*.synctex`, `*.fls`, `*.fdb_latexmk`, `*.xdv`, `*.nav`, `*.snm`, `*.vrb`, `dist/`, `_minted-*/`, `auto/`.
   - **Choix intelligent déjà présent :** **`*.log`** et **`*.bbl`** sont volontairement **autorisés** (non ignorés), tout comme le dossier `build/` lui-même, afin que l'IA puisse lire `build/main.log` pour diagnostiquer les erreurs de compilation.
2. **[`.gitignore` (racine)](file:///c:/Users/guill/dev/perso/latex/general/.gitignore) (54 lignes)** & **[`templates/template_officiel/.gitignore`](file:///c:/Users/guill/dev/perso/latex/general/templates/template_officiel/.gitignore) (38 lignes)** :
   - Couvrent `.env`, `.venv/`, `build/` et tous les auxiliaires LaTeX (`*.aux`, `*.bbl`, `*.bcf`, `*.blg`, `*.log`, `*.synctex.gz`, `*.toc`, `*.lof`, `*.lot`, `*.run.xml`, `*.upa`, `*.upb`, etc.).
   - Différence : le `.gitignore` de `template_officiel` exclut aussi `.vscode/` (L37), alors que la racine ne l'exclut pas (ce qui est normal ici puisque `.vscode/` est suivi à la racine du dépôt).
3. **[`.claude/settings.json`](file:///c:/Users/guill/dev/perso/latex/general/.claude/settings.json), [`.gemini/settings.json`](file:///c:/Users/guill/dev/perso/latex/general/.gemini/settings.json), [`.git/info/exclude`](file:///c:/Users/guill/dev/perso/latex/general/.git/info/exclude)** :
   - `.claude/settings.json` a `permissions.allow: []` et `permissions.deny: []` ; `.gemini/settings.json` vaut `{}` ; `.git/info/exclude` ne contient que le modèle Git commenté par défaut.

### Pourquoi **ne pas** bloquer `**/build/*.pdf` ? (Ta remarque est tout à fait juste)
La règle consistant à bloquer `**/build/*.pdf` provient d'un vieux réflexe hérité des indexeurs purement textuels, qui tentaient parfois d'ouvrir des fichiers PDF binaires volumineux lors d'explorations automatiques. Dans un workflow moderne, **exclure `build/*.pdf` est contre-productif** pour deux raisons :
1. **Zéro pollution sur le texte :** les outils de recherche textuelle (`rg`/`Select-String`) et le `.gitignore` ignorent déjà les fichiers binaires et `build/`.
2. **Inspection visuelle directe par une IA multimodale :** une IA capable de lire des PDF (comme Antigravity/Gemini via `read_file` sur PDF) peut ouvrir directement `build/main.pdf` pour contrôler visuellement les marges, les débordements de tableaux, l'alignement des formules mathématiques, les sauts de page ou les figures TikZ. Lui bloquer `build/*.pdf` la priverait d'un diagnostic visuel précieux.

### Modifications appliquées aux fichiers `.ignore`
Suite à ton accord (et en conservant strictement les PDF compilés accessibles) :
1. **Mise à jour de [`.aiexclude`](file:///c:/Users/guill/dev/perso/latex/general/.aiexclude), [`.claudeignore`](file:///c:/Users/guill/dev/perso/latex/general/.claudeignore) et [`.geminiignore`](file:///c:/Users/guill/dev/perso/latex/general/.geminiignore) :**
   - Ajout des auxiliaires LaTeX texte jetables et sans valeur diagnostique (`*.aux`, `*.bcf`, `*.run.xml`, `*.toc`, `*.lof`, `*.lot`, `*.loi`, `*.out`, `*.tdo`, `*.idx`, `*.ilg`, `*.ind`, `*.upa`, `*.upb`).
   - Commentaire explicite confirmant que **`*.pdf` (y compris `build/*.pdf`), `*.log`, `*.blg` et `*.bbl` restent volontairement autorisés** pour permettre l'inspection visuelle du rendu et le diagnostic des erreurs LaTeX/Biber.
2. **Diffusion dans `templates/template_officiel/` :** ajout des trois fichiers [`.aiexclude`](file:///c:/Users/guill/dev/perso/latex/general/templates/template_officiel/.aiexclude), [`.claudeignore`](file:///c:/Users/guill/dev/perso/latex/general/templates/template_officiel/.claudeignore) et [`.geminiignore`](file:///c:/Users/guill/dev/perso/latex/general/templates/template_officiel/.geminiignore) identiques afin que tout futur projet copié reste autonome.
3. **Note optionnelle conservée pour mémoire (non appliquée) :** certains modes de Claude Code lisant en priorité `.gitignore` et `permissions.deny` dans `.claude/settings.json` plutôt que `.claudeignore`, tu pourras y ajouter `.env` / `*.key` ultérieurement si tu souhaites verrouiller encore davantage les secrets côté Claude Code.
