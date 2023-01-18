rule interactive_report:
	output:
		"report/report.html",
	shell:
		"bash workflow/scripts/interactive_report.sh"