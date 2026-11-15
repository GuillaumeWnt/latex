# Plan d'Exécution — Ancrage Direct des Documents d'Annexe A & Ajout de `radioPatient.jpeg`

- [x] Auditer `backmatter/appendix-a.tex`, les renvois existants (`01-rapport-synthetique.tex` p. 47 et `03-cas-therapeutique/01-cas-clinique.tex` p. 24), `ExamenParacliniqueCasM2.pdf` (pp. 56–58) et `radioPatient.jpeg` (`1148x1131`)
- [x] Structurer `backmatter/appendix-a.tex` pour intégrer `radioPatient.jpeg` en Annexe A (p. 59) et créer des ancres directes sur chaque document (`annexe:examens_cas_m2` en p. 56 et `annexe:radio_patient` en p. 59) sans décaler l'annexe
- [x] Orienter les renvois existants vers le premier document (p. 56) et placer le renvoi temporaire vers `radioPatient.jpeg` juste avant l'Annexe A (fin du chapitre VI) avec commentaire de marge `GuillaumeVertStyle` (`author=guillaume`)
- [x] Compiler `projets/portefolio_2/`, vérifier les cibles hyperliens PDF (pages 56 et 59) dans `.aux`/`main.pdf`, contrôler `build/main.log` + `chktex` et inspecter les rendus PNG (pages 47, 54, 55, 56 et 59)
- [x] Capitaliser cette solution technique dans `projets/portefolio_2/docs/` et mettre à jour `docs/historique.md`
