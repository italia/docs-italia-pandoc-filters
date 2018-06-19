# Converte un test in un esempio leggibile. Esempio di uso:
#
# docs-italia-pandoc-filters (master)*$ cd tests/remove-page-numbers/1/
# 1 (master)*$ . ../../../da-test-ad-esempio.sh 
#
:> README.md 
echo '```' >> README.md
pandoc in.native -t markdown >> README.md 
echo '```' >> README.md
echo 'diventa:' >> README.md
echo '```' >> README.md
pandoc out.native -t markdown >> README.md 
echo '```' >> README.md
