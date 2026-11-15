# Questions Techniques, Typographie LaTeX, Unités & Notes `guillaume` (`portefolio_2`)

> **Intégrité rédactionnelle vérifiée :** Aucun mot de la prose des chapitres (`content/`, `backmatter/`, `frontmatter/`) n'a été ajouté, supprimé ou reformulé (contrôle programmatique de parité des 10 fichiers modifiés), et `projets/portefolio_1/` est resté strictement intact.

Ce document complète [`refonte-styles-et-bibliographie.md`](refonte-styles-et-bibliographie.md) en répondant en détail aux questions techniques et en documentant les ajustements appliqués dans [`projets/portefolio_2/`](../README.md).

---

## 1. Que fait « Ajout de `\let\textsc\@firstofone` dans `\pdfstringdefDisableCommands` » ?

Dans [`ClasseGuillaume.cls`](../ClasseGuillaume.cls#L417-L435), la classe injecte automatiquement au début du document les métadonnées PDF via `\hypersetup{pdftitle=..., pdfauthor=...}` et configure `\pdfstringdefDisableCommands`.

- **Pourquoi le problème existait :** dans [`main.tex`](../main.tex), le nom de l'autrice est saisi avec `\author{Flora \textsc{Piron}}` afin d'imprimer `Flora PIRON` en petites capitales dans le document (page de garde, pied de page via `\getauthor`). Or, les champs internes d'un fichier PDF (`pdfauthor`, signets de navigation/bookmarks) n'acceptent **que du texte brut Unicode**, jamais de commandes typographiques TeX (`\textsc`, `\textbf`, `\\`, etc.). Sans neutralisation, `hyperref` lève un avertissement (`Token not allowed in a PDF string`) ou risque de perturber l'écriture du champ `Author`.
- **Ce que fait exactement `\let\textsc\@firstofone` :** dans le noyau LaTeX, `\@firstofone` est une macro utilitaire qui prend un argument entre accolades et le restitue tel quel sans modification (`#1 -> #1`). En réaffectant temporairement `\textsc` à `\@firstofone` à l'intérieur de `\pdfstringdefDisableCommands`, `hyperref` transforme automatiquement `Flora \textsc{Piron}` en `Flora Piron` lors de l'écriture des métadonnées et des signets PDF, tout en préservant les vraies petites capitales partout sur la page imprimée.
- **Vérification (`pdfinfo build/main.pdf`) :** le champ produit est exactement `Author: Flora Piron`.

---

## 2. Interligne « double comme dans Word » (`spacing=double`) et listes en `\singlespacing`

### 2.1 Pourquoi Word et LaTeX (`setspace`) ne calculent pas le double interligne de la même manière

La différence vient de la grandeur de référence utilisée par chacun des deux moteurs :

| Grandeur / Réglage | Valeur calculée (corps Calibri `11 pt`) | Rapport vs simple Word (`13,43 pt`) | Statut |
| :--- | :---: | :---: | :--- |
| Métriques natives `calibri-regular.ttf` (`UPM = 2048`) | `(1536 + 512 + 452) / 2048 = 1,2207` (`win = 2500 / 2048 = 1,2207`) | — | Référence police TTF |
| Word — Simple (`1,0`) | `11 × 1,2207 ≈ 13,43 pt` | `1,00 ×` | Word multiplie la hauteur de boîte TTF |
| Word — `1,5` | `1,5 × 13,43 ≈ 20,14 pt` | `1,50 ×` | — |
| Word — Double (`2,0`) | `2,0 × 13,43 ≈ 26,86 pt` | `2,00 ×` | — |
| LaTeX `scrbook` `11pt` simple (`\baselineskip`) | `13,60 pt` (corps nominal `10,95 pt`) | `1,01 ×` | Base `setspace` |
| `spacing=onehalf` (`\onehalfspacing`) | `1,213 × 13,60 = 16,50 pt` | `1,23 ×` | `onehalf` standard LaTeX |
| Réglage transitoire `\setstretch{1.32}` | `1,32 × 13,60 = 17,95 pt` | `1,34 ×` | Retiré (trop proche de 1,35) |
| **`spacing=double` (`\doublespacing`)** *(actif)* | **`1,618 × 13,60 = 22,00 pt`** (`= 2 × 11 pt`) | **`1,64 ×`** | **Actif dans `main.tex` (identique à `portefolio_1`)** |
| Équivalent exact Word `2,0` sous LaTeX | `1,97 × 13,60 ≈ 26,80 pt` | `2,00 ×` | Optionnelle (`\setstretch{1.97}`) |

- **Choix appliqué :** [`main.tex`](../main.tex#L10) utilise désormais `spacing=double` (et la surcharge `\setstretch{1.32}` a été supprimée de [`portefolio-style.sty`](../config/portefolio-style.sty)). Cela rétablit exactement le double interligne standard LaTeX (`22,00 pt`, identique à `portefolio_1`) qui correspond aux attentes universitaires habituelles pour « double interligne » sans créer d'espacements démesurés entre les lignes.
- **Possibilité d'ajustement au millimètre :** si une grille d'évaluation vérifie littéralement les `26,86 pt` d'un fichier `.docx`, il suffirait d'ajouter `\setstretch{1.97}` dans [`config/portefolio-style.sty`](../config/portefolio-style.sty).

### 2.2 Conservation du `\singlespacing` dans les listes à puces (`itemize` / `enumerate`)

Dans [`config/portefolio-style.sty`](../config/portefolio-style.sty#L271), toutes les listes appliquent explicitement :

```latex
\setlist{before=\singlespacing, topsep=0.35em, parsep=0.15em, itemsep=0.35em}
```

- **Conformité aux standards rédactionnels :** dans les recommandations typographiques universitaires (et notamment les guides de rédaction médicale/scientifique et normes de type APA), l'interligne simple **à l'intérieur des éléments structurés** (tableaux cliniques, listes à puces longues, notes de bas de page et notices bibliographiques) est pleinement accepté et même fréquemment conseillé pour éviter de fragmenter visuellement des énumérations multi-lignes, tout en conservant un espacement distinct entre chaque puce (`itemsep=0.35em`).
- Cette configuration officialise et améliore aussi ce qui figurait en commentaire inactif (`%before=\singlespacing`) dans `portefolio_1`.

---

## 3. Chiffres entourés de `$...$` et modernisation via `siunitx`

### 3.1 Pourquoi entourer tous les chiffres de `$...$` est une mauvaise pratique

En LuaLaTeX avec une police TrueType bureautique (**Calibri**) chargée via `fontspec`, écrire `$28$`, `$2025$`, `$91$\%`, `B$1$B$2$` ou `$20,8$ kg/m$^2$` entraîne quatre défauts concrets :

1. **Rupture de police :** `$...$` force le mode mathématique de TeX (Computer Modern Math `cmr/cmmi` avec empattements) au milieu d'un texte sans-sérif Calibri — les chiffres n'ont ni la même hauteur d'œil, ni la même graisse, ni les mêmes proportions.
2. **Typographie des unités et opérateurs fautive :** `$74\,x\,68\,x\,53$ mm` utilise une lettre $x$ algébrique au lieu du signe `×` ; `$91$\%` omet l'espace fine réglementaire française avant `%` ; `$13 000$ pg/mL` laisse TeX supprimer l'espace dans le mode mathématique (`13000` collé) et permet un saut de ligne malvenu entre le nombre et son unité.
3. **Contresens sémantique :** des dates (`$6$ avril $2025$`), des codes médicaux (`CA $125$`, `G$0$P$0$`, `SGLT$2$`, `B$1$B$2$`) ou des références légales (`$15$`, `\S~$2$`) ne sont pas des expressions algébriques.
4. **Accessibilité / copier-coller PDF dégradés :** certains symboles mathématiques s'extraient mal lors de la sélection ou de la recherche dans le PDF.

### 3.2 Standard moderne appliqué dans les 10 fichiers de `content/`

Sans modifier un seul mot du texte, tous les `$...$` superflus de [`content/`](../content/) et des tableaux actifs ont été convertis :

- **Nombres du texte courant (âges, dates, scores, effectifs, codes cliniques) :** écrits directement en texte Calibri normal (`28 ans`, `6 avril 2025`, `18/22 patients`, `9 études`, `CA 125`, `G0P0`, `SGLT2`, `B1B2`, `article 15, §~2`).
- **Grandeurs physiques/cliniques, dimensions et grands nombres (`siunitx` v3) :** encadrés avec `\qty{...}{...}`, `\qtyrange{...}{...}{...}`, `\qtyproduct{...}{...}` et `\num{...}`, associés à une configuration dédiée dans [`config/portefolio-style.sty`](../config/portefolio-style.sty#L260-L269) :

```latex
\sisetup{
  mode = text,
  detect-all = false,
  per-mode = symbol,
  product-units = single
}
\DeclareSIUnit\bpm{bpm}
\DeclareSIUnit\SA{SA}
\DeclareSIUnit\enzymU{U}
\DeclareSIUnit\dL{\deci\liter}
```

  > **Points techniques clés :**
  > - `mode = text` garantit que les chiffres et unités restent composés en **Calibri** (même lorsqu'un `\num{0.001}` apparaît à l'intérieur d'une relation statistique mathématique comme `$p < \num{0.001}$`).
  > - L'option globale `locale = FR` de [`packages.sty`](../config/packages.sty) convertit automatiquement les points décimaux d'entrée en virgules (`2055.0` $\rightarrow$ `2 055,0`), regroupe les milliers par espaces fines insécables (`\num{20000}` $\rightarrow$ `20 000`), place l'espace insécable avant `%` (`\qty{91}{\percent}` $\rightarrow$ `91 %`) et formate les produits (`\qtyproduct{74 x 68 x 53}{\mm}` $\rightarrow$ `74 × 68 × 53 mm`).
  > - Les seules commandes encore entre `$...$` dans le projet sont de **véritables objets mathématiques, grecs ou chimiques** : `$p < \num{0.001}$`, `$p = \num{0.65}$`, `$p \ge \num{0.05}$`, `$I^2$`, `$\beta_1$`, `$\beta_2$`, `$\rightarrow$`, `$\times$`, `$\mathrm{CHA_2DS_2}\text{-}\mathrm{VA}$` et `$\mathrm{D_3}$`.
  > - `\DeclareSIUnit\dL{\deci\liter}` a été déclaré explicitement car `siunitx-abbreviations.cfg` fournit `\mL` et `\uL` par défaut mais omet `\dL`. De même, pour la minute en notation quotient, la macro `siunitx` standard est `\minute` (et non `\min`, qui est un opérateur mathématique TeX).

---

## 4. Pourquoi déclarer les métadonnées dans `main.tex` plutôt que dans `portefolio-style.sty` ?

En architecture LaTeX modulaire (séparation **contenu / données / présentation**), chaque fichier joue un rôle strictement distinct :

| Couche | Fichier | Ce qu'il doit contenir | Pourquoi |
| :--- | :--- | :--- | :--- |
| **Données du document** | [`main.tex`](../main.tex) | Langue, options de mise en page, `\title`, `\author`, `\degree`, `\specialty`, `\keywords` | Carte d'identité propre à **ce** travail (change si un autre étudiant réutilise le style) |
| **Moteur structurel** | [`ClasseGuillaume.cls`](../ClasseGuillaume.cls#L417-L435) | Lecture des métadonnées et injection unique dans `\hypersetup{pdftitle=..., pdfauthor=...}` + accesseurs `\getauthor`, `\gettitle`, `\getinstitution` | Une seule mécanique fiable d'injection PDF, zéro risque de conflit entre deux `\hypersetup` |
| **Charte graphique** | [`config/portefolio-style.sty`](../config/portefolio-style.sty) | Palette de couleurs, titres, listes, filets, mise en page du pied de page (`\getauthor • \gettitle — \getinstitution`) | Reste **100 % générique et réutilisable** sans aucun nom propre ni titre codé en dur à l'intérieur |

Déplacer `\author` ou `\hypersetup` dans `portefolio-style.sty` recréerait la redondance supprimée et empêcherait `portefolio-style.sty` de rester un thème graphique indépendant des métadonnées du document.

---

## 5. Un document rédigé en anglais (`[english, bibstyle=vancouver]`) garde-t-il bien les mois en anglais ?

**Oui, à 100 %.** L'examen de [`config/packages.sty`](../config/packages.sty#L488-L538) et de la définition d'origine dans `biblatex-vancouver` (`vancouver.bbx`, lignes 48–85) le confirme :

- Dans `packages.sty`, toutes les surcharges françaises (`\shortmonth` en `janv.`, `fév.`, ..., `déc.`, `urlfrom = {Disponible sur}`, format `[Consulté le ...]`) sont placées strictement à l'intérieur de la branche négative `\ifClasseGuillaume@english \else ... \fi`.
- Dès que l'option `english` est passée à la classe (`\documentclass[english, bibstyle=vancouver]{ClasseGuillaume}`), le test `\ifClasseGuillaume@english` est **vrai** : tout le bloc français dans `\else` est ignoré par LuaLaTeX, et `vancouver.bbx` conserve ses définitions anglaises natives (`Jan`, `Feb`, ..., `Dec`, `Available from:`, `[Accessed on: ...]`).

---

## 6. Qu'est-ce qu'une « collectivité » et à quoi servent les doubles accolades `{{...}}` et `{...}` dans `.bib` ?

- **Définition d'une collectivité (*corporate author*) :** c'est une personne morale, une institution, une société savante ou un organisme agissant en tant qu'auteur à la place d'un individu (exemples présents dans [`biblio/references.bib`](../biblio/references.bib) : `Circus Baobab`, `Déméter Santé`, `American Psychiatric Association`, `European Medicines Agency`, `Celagri`, `SIEP`).
- **Pourquoi `author = {{European Medicines Agency}}` (double accolade) ?**
  - Avec une seule paire (`{European Medicines Agency}`), Biber/BibLaTeX découpe la chaîne selon la règle *Prénom(s) Nom* et traite *Agency* comme nom de famille et *European Medicines* comme prénoms — ce qui imprime en style Vancouver **`Agency EM`** !
  - La paire d'accolades interne (`{{European Medicines Agency}}`) indique à Biber que le groupe entier forme un bloc atomique indivisible (`corporate author`), imprimé intact sans inversion de mots ni réduction aux initiales.
- **Pourquoi `{HFpEF}` ou `{SGLT}` dans les champs `title` (accolade simple interne) ?**
  - De nombreux styles bibliographiques (dont Vancouver pour les titres d'articles) appliquent une mise en *sentence case* automatique (seule la première lettre du titre reste majuscule, tout le reste passe en minuscules).
  - Entourer les sigles d'accolades internes (`{HFpEF}`, `{SGLT}2`, `{EMDR}`) verrouille leur casse afin qu'ils ne soient jamais dégradés en `hfpef` ou `sglt2`.

---

## 7. Notes de marge vertes ajoutées (`author=guillaume`)

Un style dédié `GuillaumeVertStyle` (`author=guillaume, color=green!25, bordercolor=green!60!black`) a été défini dans [`config/portefolio-style.sty`](../config/portefolio-style.sty#L286), et les deux notes demandées ont été placées exactement sur les phrases qui citent les deux entrées incomplètes :

1. **Formation SIEP (`siep_formation_524`) :** dans [`content/02-activite-exterieure/02-impact-personnel.tex`](../content/02-activite-exterieure/02-impact-personnel.tex#L5) sur `huiles essentielles` avant `\parencite{siep_formation_524}` — demande de remplacer `[Titre de la formation]` par le titre exact dans `references.bib` (et d'indiquer la date si connue).
2. **Article Lagedamon et al. (`lagedamon2025accompagnement`) :** dans [`content/04-incident-medical/02-implications-ethiques-deontologiques-legales.tex`](../content/04-incident-medical/02-implications-ethiques-deontologiques-legales.tex#L5) sur `Une revue de la littérature` avant `\textcite{lagedamon2025accompagnement}` — demande de vérifier et compléter le prénom manquant pour l'auteur `Baraille` dans `references.bib`.

> **Astuce technique (`\emph{references.bib}` dans `#3`) :** dans [`config/macros.sty`](../config/macros.sty#L383-L395), `\todoH` tronque automatiquement à 30 caractères (`...`) dans la boîte de marge tout commentaire purement textuel dépourvu de commande LaTeX (renvoyant le texte complet uniquement en infobulle et dans la `TODO list`). L'utilisation de `\emph{references.bib}` met en forme le nom de fichier **et** permet d'afficher immédiatement la consigne complète dans la marge verte, comme les notes de Flora, tout en apparaissant intégralement dans la `TODO list` en page `i`.

---

## 8. Contrôles effectués après ces modifications

- **Compilation (`compile.ps1`, LuaLaTeX + Biber) :** `68` pages générées dans `build/main.pdf` (`24 659 521` octets), **`0` erreur fatale**, **`0` `Overfull \hbox`**, **`0` `Missing character`**, **`0` avertissement de citation/référence**, `2` avertissements `Marginpar` préexistants (`Marginpar on page 16 moved.` et `Marginpar on page 18 moved.`), `18` clés BibLaTeX résolues dans `build/main.blg` (`0` erreur/avertissement).
- **Analyse statique (`chktex -q -l .chktexrc config\portefolio-style.sty`) :** `0` avertissement.
- **Contrôle visuel (rendus PNG à `120 DPI` des pages PDF `1`, `8`, `11`, `23`, `33`, `41`, `49`, `51`, `53`) :** police Calibri homogène sur les nombres isolés, unités `siunitx` (`mode = text`) et formules statistiques (`$p < \num{0.001}$`), listes compactes en `\singlespacing` dans le corps en `spacing=double`, notes vertes `guillaume` complètes et sans chevauchement ni dans la marge ni dans la `TODO list`.
- **Parité rédactionnelle :** vérification programmatique des `10` fichiers modifiés dans `content/` (parité exacte des mots de prose) et `git status -s projets/portefolio_1/` vide.

---

## 9. Pourquoi les renvois vers plusieurs documents d'Annexe A pointaient-ils vers la page de garde (p. 55) ?

### Le problème d'origine

Dans [`backmatter/appendix-a.tex`](../backmatter/appendix-a.tex), l'unique étiquette `\label{annexe:examens_complementaires}` était placée juste sous `\chapter{Examens complémentaires}` (**page 55**). Comme `\includepdf` démarre ensuite une nouvelle page pour les pièces jointes (pages **56–58**), tout renvoi `\cref{annexe:examens_complementaires} en \cpageref{annexe:examens_complementaires}` affichait `annexe A en Page 55` et pointait vers la page titre de l'annexe plutôt que vers le document visé. En ajoutant un second document (`radioPatient.jpeg`), tous les renvois auraient convergé vers la même page 55.

### Solution retenue : ancrage direct par page sans casser la numérotation d'annexe

1. **Conserver le compteur `chapter` (`A`) sans créer de `\section` ni de `figure` parasite :**
   - Document 1 ([`ExamenParacliniqueCasM2.pdf`](../figures/03-cas-therapeutique/ExamenParacliniqueCasM2.pdf), pp. 56–58) : la première page est incluse séparément avec `pagecommand={\thispagestyle{plain}\phantomsection\label{annexe:examens_cas_m2}}`, puis les pages suivantes avec `pages=2-`.
   - Document 2 ([`radioPatient.jpeg`](../figures/05-cas-polypathologique-complexe/radioPatient.jpeg), p. 59) : placé juste après via `\clearpage\thispagestyle{plain}\phantomsection\label{annexe:radio_patient}` suivi de l'image centrée (`\includegraphics[width=\linewidth, height=0.88\textheight, keepaspectratio]`).
2. **Pourquoi `\phantomsection` fonctionne ici :**
   - `\phantomsection` crée une ancre PDF `hyperref` fraîche (`section*.24` en p. 56, `section*.25` en p. 59) exactement en haut de la page cible (`y = 768.2 pt`), tout en conservant le dernier compteur incrémenté (`appendix` = `A`).
   - Ainsi, `\cref{...}` continue d'imprimer **`annexe A`**, `\cpageref{...}` imprime directement **`Page 56`** ou **`Page 59`**, la table des figures n'est pas polluée, et un clic sur l'un ou l'autre lien amène immédiatement sur le bon document.
3. **Renvois mis à jour & renvoi temporaire :**
   - Les deux renvois existants vers `ExamenParacliniqueCasM2.pdf` — en **page 47** ([`01-rapport-synthetique.tex`](../content/05-cas-polypathologique-complexe/01-rapport-synthetique.tex#L98)) et en **page 24** ([`01-cas-clinique.tex`](../content/03-cas-therapeutique/01-cas-clinique.tex#L58)) — pointent désormais vers `annexe:examens_cas_m2` (**page 56**).
   - Le renvoi vers `radioPatient.jpeg` (`annexe:radio_patient`, **page 59**) a été placé provisoirement à la fin de [`01-auto-evaluation.tex`](../content/06-auto-evaluation/01-auto-evaluation.tex#L15) (bas de **page 54**, juste avant l'Annexe A) avec une note de marge verte `\todoH[GuillaumeVertStyle][green!25]{...}` (`author=guillaume`) signalant son caractère temporaire mais opérationnel.

