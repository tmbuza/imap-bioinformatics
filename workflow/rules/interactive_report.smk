# rule target:
# 	input:
# 		"report/report.html"

rule interactive_report:
	output:
		"report/report.html",
	shell:
		"bash workflow/scripts/interactive_report.sh"