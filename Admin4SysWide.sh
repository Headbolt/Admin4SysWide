#!/bin/bash
#
###############################################################################################################################################
#
# ABOUT THIS PROGRAM
#
#	Admin4SysWide.sh
#	https://github.com/Headbolt/Admin4SysWide
#
#   This Script is designed for use in JAMF and was designed to force "Administrator Password Required to Access System-Wide Preferences"
#	This was done to comply with "CIS Apple macOS 13.0 Ventura Benchmark 1.0.0" Security Reccomendations
#
###############################################################################################################################################
#
# HISTORY
#
#   Version: 1.0 - 24/02/2023
#
#	24/02/2023 - V1.0 - Created by Headbolt
#
###############################################################################################################################################
#
#   DEFINE VARIABLES & READ IN PARAMETERS
#
###############################################################################################################################################
#
ScriptName="Security | Administrator Password Required to Access System-Wide Preferences"
ExitCode=0
#
###############################################################################################################################################
#
#   Checking and Setting Variables Complete
#
###############################################################################################################################################
# 
# SCRIPT CONTENTS - DO NOT MODIFY BELOW THIS LINE
#
###############################################################################################################################################
#
# Defining Functions
#
###############################################################################################################################################
#
# Check Function
#
Check(){
#
/bin/echo 'Grabbing current security authorizationdb'
Input=$(/usr/bin/sudo /usr/bin/security authorizationdb read system.preferences > /tmp/system.preferences.plist)
/bin/echo # Outputting a Blank Line for Reporting Purposes
/bin/echo 'Checking current value for "shared"'
Current=$(/usr/bin/defaults read /tmp/system.preferences.plist shared)
/bin/echo # Outputting a Blank Line for Reporting Purposes
/bin/echo 'Require an administrator password to access systemwide settings is currently :'
#
if [[ $Current != "0" ]]
	then
		/bin/echo 'NOT SET !!!!'
	else
		/bin/echo 'SET'
fi
#
}
#
###############################################################################################################################################
#
# Section End Function
#
SectionEnd(){
#
/bin/echo # Outputting a Blank Line for Reporting Purposes
/bin/echo  ----------------------------------------------- # Outputting a Dotted Line for Reporting Purposes
/bin/echo # Outputting a Blank Line for Reporting Purposes
#
}
#
###############################################################################################################################################
#
# Script End Function
#
ScriptEnd(){
#
/bin/echo Ending Script '"'$ScriptName'"'
/bin/echo # Outputting a Blank Line for Reporting Purposes
/bin/echo  ----------------------------------------------- # Outputting a Dotted Line for Reporting Purposes
/bin/echo # Outputting a Blank Line for Reporting Purposes
#
exit $ExitCode
#
}
#
###############################################################################################################################################
#
# End Of Function Definition
#
###############################################################################################################################################
# 
# Begin Processing
#
###############################################################################################################################################
#
/bin/echo # Outputting a Blank Line for Reporting Purposes
SectionEnd
#
/bin/echo 'Checking current setting'
/bin/echo # Outputting a Blank Line for Reporting Purposes
Check
SectionEnd
#
if [[ $Current != "0" ]]
	then
		/bin/echo 'Changing Setting'
        /bin/echo # Outputting a Blank Line for Reporting Purposes
		/usr/bin/defaults write /tmp/system.preferences.plist shared -bool false
        /usr/bin/security authorizationdb write system.preferences < /tmp/system.preferences.plist
        SectionEnd
        /bin/echo 'Re-Checking current setting'
        /bin/echo # Outputting a Blank Line for Reporting Purposes
		Check
	else
    	/bin/echo 'Nothing to do'
fi
#
SectionEnd
/bin/echo 'Cleaning up temporary files'
rm /tmp/system.preferences.plist
#
SectionEnd
ScriptEnd
