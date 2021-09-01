HLEDGER=hledger
SED=gsed
DELCSS=$(SED) -E -z 's/<style>[^>]+><link href="hledger.css" rel="stylesheet">/\n<br>\n/g'

# update reports in readme
# html
README.md: hf.journal Makefile
	$(SED) '/<!-- REPORTS -->/q' $@ >.$@
	$(HLEDGER) is -QTS -e tomorrow -O html >>.$@
	$(HLEDGER) bs -QE -e tomorrow -O html >>.$@
	echo >>.$@
	$(DELCSS) <.$@ >$@
	git commit -m "reports" -- $@ || echo "reports have not changed"

# plain text
# README.md: hf.journal Makefile
# 	$(SED) '/<!-- REPORTS -->/q' $@ >.$@
# 	printf '\n```\n' >>.$@
# 	$(HLEDGER) is -QT -e tomorrow --pretty >>.$@
# 	printf '```\n\n```\n' >>.$@
# 	$(HLEDGER) bs -QE -e tomorrow --pretty >>.$@
# 	printf '```\n\n' >>.$@
# 	mv .$@ $@
