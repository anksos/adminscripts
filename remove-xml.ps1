# Backup Script with Powershell
# Removes .xml files in Specific directory, if it's created in more than 7 days
# The scripts look for all .xml files recursive to the directory that we have selected
# To add it as a Schedule task add the above on the Schedule Wizard:
# Program/Script: powershell
# Arguments: -ExecutionPolicy Unrestricted -File C:\remove-xml.ps1
# Of course you can change this script in whatever filetype you want to delete, have fun!

$Path = "C:\a\path\that\you\keep\your\data" # the path that you have to remove the .xml files
$Daysback = "-7" # how many days want to have retention
$CurrentDate = Get-Date
$DatetoDelete = $CurrentDate.AddDays($Daysback)

Get-ChildItem $Path -Recurse -Include *.xml | Where-Object {$_.LastWriteTime -lt $DatetoDelete } | Remove-Item