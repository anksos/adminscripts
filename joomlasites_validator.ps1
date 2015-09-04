#######################################################
# # Script Name: joomlasites_validator.ps1
# # Author: Anastasis Ksouzafeiris
# # Purpose: Joomla Sites version Validator v.0.4
#
# # Usage:
# # 1. Import-Module .\joomlaSites_validator.ps1
# # 2. Get-ExtensionCount
#
# # How to determine version of Joomla Sites:
# # 1. /includes/version.php -> 1.0.x
# # 2. /libraries/joomla/version.php -> 1.5.x and 1.6.x
# # 3. /libraries/cms/version.php -> 2.5.x
# # 4. /libraries/cms/version/version.php -> 3.0.x
#
# # How to determine version of Wordpress:
# # 1. The version.php is on \wp-includes\version.php
# # 2. Parses the file and checks for the "$wp_version = 'x.x.x';"
#######################################################

function Get-JoomlaSitesValidator {
	param(
		$Root = "C:\TheFolderOfYourSites\",
		$FileType = @("version.php"),
		$Outfile = "C:\joomlaSites_validator.txt"
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
	# Check for the specific version of the Joomla Sites
	# and add the version next of every line/directory structure
	$output = @($header, $(
		switch -wildcard ($filelist) {
			"*\includes\version.php" { "$_ ---> 1.0.x - [*ALERT*]" } # Joomla
			"*\libraries\joomla\version.php" { "$_ ---> 1.5.x or 1.6.x - [*ALERT*]" } # Joomla
			"*\libraries\cms\version.php" { "$_ ---> 2.0.x or 2.5.x - [OK!]" } # Joomla
			"*\libraries\cms\version\version.php" { "$_ ---> 3.0.x - [OK!]" } # Joomla
			"*\wp-includes\version.php" { "$_ ---> Wordpress" } # [new add]
		}
	))
	$output | Set-Content $Outfile
}