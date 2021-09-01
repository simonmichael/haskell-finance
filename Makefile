HLEDGER=hledger

# update reports in readme

# README.md: hf.journal Makefile
# 	sed '/## Reports/q' $@ >.$@
# 	printf '\n```\n' >>.$@
# 	$(HLEDGER) is -QT -e tomorrow --pretty >>.$@
# 	printf '```\n\n```\n' >>.$@
# 	$(HLEDGER) bs -QE -e tomorrow --pretty >>.$@
# 	printf '```\n\n' >>.$@
# 	mv .$@ $@

README.md: hf.journal Makefile
	sed '/## Reports/q' $@ >.$@
	$(HLEDGER) is -QT -e tomorrow -O html >>.$@
	$(HLEDGER) bs -QE -e tomorrow -O html >>.$@
	mv .$@ $@
	git commit -m "reports" -- $@
