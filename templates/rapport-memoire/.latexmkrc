# .latexmkrc — Configuration automatique pour latexmk
# Usage : latexmk main.tex (toutes les options sont pré-configurées)

$pdf_mode = 4;          # 4 = LuaLaTeX
$out_dir  = 'build';
$lualatex = 'lualatex -interaction=nonstopmode -synctex=1 %O %S';

# Fichiers auxiliaires supplémentaires à nettoyer
$clean_ext = 'run.xml bbl bcf fdb_latexmk fls loi tdo upa upb synctex.gz';

