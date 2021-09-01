HLEDGER=hledger
SED=gsed
DELCSS=$(SED) -E -z 's/<style>[^>]+><link href="hledger.css" rel="stylesheet">/\n<br>\n/g'

REPORT1=$(HLEDGER) is -QETS -e tomorrow
REPORT2=$(HLEDGER) bs -QE -e tomorrow

# update reports in readme
# html
README.md: hf.journal Makefile
	$(SED) '/<!-- REPORTS -->/q' $@ >.$@
	$(REPORT1) -O html >>.$@
	$(REPORT2) -O html >>.$@
	echo >>.$@
	$(DELCSS) <.$@ >$@
	git commit -m "reports" -- $@ || echo "reports have not changed"

# plain text
# README.md: hf.journal Makefile
# 	$(SED) '/<!-- REPORTS -->/q' $@ >.$@
# 	printf '\n```\n' >>.$@
# 	$(REPORT1) --pretty >>.$@
# 	printf '```\n\n```\n' >>.$@
# 	$(REPORT2) --pretty >>.$@
# 	printf '```\n\n' >>.$@
# 	mv .$@ $@

preview:
	$(REPORT1) --pretty #-%
	$(REPORT2) --pretty #-%
