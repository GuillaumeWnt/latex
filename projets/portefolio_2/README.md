# Portfolio Médical (`portefolio_2`)

Migration architecturale du projet `portefolio_1` vers le socle modulaire [`templates/template_officiel/`](../../templates/template_officiel/README.md) (`ClasseGuillaume v2.0`, LuaLaTeX + Biber + KOMA-Script `scrbook` + `geometry`).

> **Garantie de fidélité :** Aucun mot du contenu rédactionnel de `portefolio_1` n'a été modifié ; seule l'architecture logicielle et la syntaxe LaTeX défectueuse (mode mathématique, sauts de ligne forcés avant paragraphe vide, surlignage `lua-ul` compatible UTF-8, synchronisation KOMA/`geometry`) ont été assainies.

---

## Arborescence

- `main.tex` : point d'entrée compilable (`screen, french, todos, font=calibri, bibstyle=vancouver, spacing=double`)
- `ClasseGuillaume.cls`, `ClasseGuillaume-*.clo` : classe générique issue de `template_officiel`
- `config/` : `packages.sty`, `macros.sty`, et `portefolio-style.sty` (surcharge visuelle dédiée à l'esthétique exacte du portfolio)
- `frontmatter/` : pages de garde modulaire (`cover-main.tex`, `cover-chap1.tex` à `cover-chap4.tex`)
- `content/` : chapitres `01-*.tex` à `06-*.tex`, sous-sections découpées et `tables/` (`archives/` inclus)
- `backmatter/` : `appendix-a.tex`
- `biblio/` : `references.bib` et styles `custom-style.*`
- `figures/` : `covers/`, `logos/`, figures actives et orphelines classées par chapitre
- `fonts/` : polices figées (`CalibriFontFiles/`, `AsapFontFiles/`, `ComicSansMSFontFiles/`, `texgyreheros-*.otf`)
- `docs/` : notes et documents annexes conservés (`note.txt`, `Cas_polypathologique_M3.pdf`)

## Compilation

```bash
latexmk
```

Le PDF généré est isolé dans `build/main.pdf`.
