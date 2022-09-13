param ([Parameter(Mandatory=$true)][string]$loc)
Push-Location flexpmd 
java -jar flex-pmd-command-line-1.2.jar -r ruffle-ruleset.xml -s ..\..\output\$loc -o ..\tmp\
Pop-Location
