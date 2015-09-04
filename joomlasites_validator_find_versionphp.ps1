#######################################################
# # Script Name: joomlasites_validator_find_versionphp.ps1
# # Author: Anastasis Ksouzafeiris
# # Purpose: Joomla Sites Validator - Find version.php v.0.1
#
# # Usage:
# # 1. Import-Module .\joomlaSites_validator_find_versionphp.ps1
# # 2. Get-JoomlaSitesFindPHP
# # If you don't want the default values:
# # 3. Get-JoomlaSitesFindPHP -Root "D:\test\" -FileType ".txt", ".exe" -Outfile "D:\foo\bar.txt"
#
#######################################################

function Get-JoomlaSitesFindPHP {
	param(
		$Root = "C:\TheFolderOfYourSites\",
		$FileType = @("version.php"),
		$Outfile = "C:\findversion-php.txt"
	)
	# Filecount per type
	$header = @()
	# All the filepaths
	$filelist = @()
	
	Foreach ($type in $FileType) {
		$files = Get-ChildItem $Root -Filter *$type -Recurse | ? { !$_.PSIsContainer }
		$header += "$type ---> $($files.Count) files"
		Foreach ($file in $files) {
			$filelist += $file.FullName
		}
	}
	# Collect to single output
	$output = @($header, $filelist) 
	$output | Set-Content $Outfile
}