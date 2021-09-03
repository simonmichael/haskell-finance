HLEDGER=hledger -f hf.journal
SED=gsed
DELCSS=$(SED) -E -z 's/<style>[^>]+><link href="hledger.css" rel="stylesheet">/\n<br>\n/g'

REPORT1=$(HLEDGER) is -QETS -e tomorrow
REPORT2=$(HLEDGER) cf -QET -e tomorrow
REPORT3=$(HLEDGER) bs -QE -e tomorrow

default: report

# show plain text reports
report:
	$(REPORT1) --pretty; echo
	$(REPORT2) --pretty; echo
	$(REPORT3) --pretty; echo

# show reports including forecast
forecast:
	$(REPORT1) --pretty -e 2022; echo
	$(REPORT2) --pretty -e 2022; echo
	$(REPORT3) --pretty -e 2022; echo

# update html reports in readme
README.md: hf.journal Makefile
	$(SED) '/<!-- REPORTS -->/q' $@ >.$@
	$(REPORT1) -O html >>.$@
	$(REPORT2) -O html >>.$@
	$(REPORT3) -O html >>.$@
	echo >>.$@
	$(DELCSS) <.$@ >$@
	git commit -m "reports" -- $@ || echo "reports have not changed"

# update plain text reports in readme
# README.md: hf.journal Makefile
# 	$(SED) '/<!-- REPORTS -->/q' $@ >.$@
# 	printf '\n```\n' >>.$@
# 	$(REPORT1) --pretty >>.$@
# 	printf '```\n\n```\n' >>.$@
# 	$(REPORT2) --pretty >>.$@
# 	printf '```\n\n' >>.$@
# 	mv .$@ $@

