# Sécurité & Hygiène Documentaire LaTeX

## 1. Politique `-shell-escape`
- **Interdit par défaut :** Ne jamais activer `-shell-escape` dans `latexmkrc` ni en ligne de commande (exécution de commandes système arbitraires lors de la compilation).
- **Alternatives sûres :** Utiliser `listings` (`\lstinputlisting` déjà configuré dans `config/packages.sty`) plutôt que `minted`, et la précompilation `standalone` (`figures/tikz/`) plutôt que `tikz-externalize`.
- Si une exception est indispensable et validée par l'utilisateur, privilégier `-shell-restricted`.

---

## 2. Hygiène des Sources, `.bib` & Métadonnées PDF
- **Pas de données sensibles :** Ne jamais laisser de notes confidentielles de relecteurs, URLs internes privées, ni identifiants dans les commentaires `%`, `\todoH` ou fichiers `.bib` destinés à être partagés.
- **Assainissement des métadonnées :** Avant diffusion finale, vérifier `\hypersetup` (`pdftitle`, `pdfauthor`, `pdfsubject`, `pdfkeywords`), désactiver l'option `todos` dans `\documentclass` et purger les champs superflus dans `biblio/references.bib`.
- **Échappement lors de génération automatisée :** Toute conversion automatique vers LaTeX (ex. scripts Python, Markdown $\rightarrow$ LaTeX) doit échapper les caractères réservés TeX (`%`, `&`, `_`, `$`, `#`, `{`, `}`, `~`, `^`, `\`) hors blocs de code (`lstlisting`, `\code`) et hors mode mathématique.
