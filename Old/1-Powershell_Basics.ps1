﻿#A few things before we get started(these need to be run as administrator)
Update-Help
Set-ExecutionPolicy RemoteSigned

#Execution policies are a security feature to protect against malicious scripts
get-help about_executionpolicies

#What version are we using?
$PSVersionTable

#Cmdlets - the core functionality
Get-Command
Get-Command | Measure-Object #Don't worry about the pipe yet, we'll cover that later

Get-Command -Name *New*

#Verb-Noun construction
#Makes things very intuitive
#Limited number of verbs for standardization
Get-Verb

#Unlimited number of nouns

#Cmdlets can have aliases to make them easier to use
dir C:\

#dir is and alias for Get-ChildItem
Get-ChildItem C:\

#We can see all the aliases for a cmdlet
Get-Alias -Definition Get-ChildItem

#let's use a cmdlet to make a new directory
New-Item -ItemType Directory 'C:\TEMP'

#Providers - Drives and more
Get-PSDrive

#Note the different types of providers
dir ENV:\

dir ALIAS:\

#You can reference these values from the command line
$env:computername
$env:username
$Alias:ls

#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#The three most important cmdlets you need to remember
#The Holy Trinity of Self Discovery
#Get-Command
#Get-Help
#Get-Member
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

Get-Help Get-Command
Get-Help Get-Command -Full
Get-Help Get-Command -ShowWindow
Get-Help about_Providers -ShowWindow
man Get-Command -Full
help Get-Command -Full

#Get-Member is important for Powershell variables

#Variables and using variables
Get-Help about_variables

#Powershell variables start with a $
$string="This is a variable"
$string

#We can use Get-Member to find out all the information on our objects
$string | Get-Member

#Powershell is strongly typed and uses .Net objects.
#Not just limited to strings and intgers

$date=Get-Date
$date
$date | gm #gm is the alias of Get-Member

#Because they are .Net types/classes, we can use the methods and properties.
$date.Day
$date.DayOfWeek
$date.DayOfYear
$date.ToUniversalTime()

#Powershell tries to figure out the variable type when it can(implicit types)
#We can also explicitly declare our type
[string]$datestring = Get-Date #could also use [System.String]
$datestring
$datestring|gm

#Variable Typing can get you in to trouble, so be careful.

#EVERYTHING is an object.  This means more than just basic types:
$file = New-Item -ItemType File -Path 'C:\TEMP\junkfile.txt'
$file | gm

$file.Name
$file.FullName
$file.Extension
$file.LastWriteTime

#note that the values for properties are objects to, and the Get-Member will show you what those objects are.
#This means we can apply those properties and methods to the return values.
$file.Directory | gm
$file.Directory.EnumerateFiles()

#let's clean up that file using the method
$file.Delete()

#note, the object is still in memory, but doesn't really exist
#You can check that using the object's methods, though
$file
dir C:\TEMP
$file.Refresh()
$file
$file.Exists

#cmdlets and functions will output objects.  You can work with them by using ()
(Get-ChildItem C:\Windows).Length

(Get-Date).AddDays(-3)

#Concatenation and Interpolation
#The plus sign is used for concatenation

$temperature = 'Hot'
'Tea. Earl Grey. ' + $temperature + '.'

#We can use interpolation to make life easier and cleaner.
#Interpolation is a useful tool when working with variables, especially strings.
"Tea. Earl Grey. $temperature."
'Tea. Earl Grey. $temperature.'

#It is important to understand the difference between single and double quotes.

#` (the tick on the tilde key) is the escape character, use this when you need to get around special characters
"Tea. Earl Grey. `$temperature."

#The pipeline allows us to extend the functionality.
Get-Help about_pipelines
#It works something like a "gate" where everything thing on the left side that matches
#gets passed to the right.

#we've used it already for Get-Member
(Get-ChildItem C:\) | Get-Member

#We can also use it for performing an action on a object
dir \\PICARD\C$\backups\dummy\*.trn
dir \\PICARD\C$\backups\dummy\*.trn | Remove-Item -WhatIf

#We can use the pipeline to further enhance our actions
dir \\PICARD\C$\backups\ -Recurse | Where-Object {$_.Extension  -eq ".trn" -and $_.LastWriteTime -lt (Get-Date).AddDays(-1)} | rm -WhatIf

#$_ means the current object in the pipeline.  In the above example, we want to reference the Extension and LastWriteTime properties for the current object


#Operators and variable comparison
Get-Help about_operators

#Symbols like '>' and '<' mean different things in standard shell scripting.

#You use -lt, -ne, -eq, and other phrases are used to perform logical compariso
'1 -eq 2 returns:' + (1 -eq 2)
'1 -lt 2 returns:' + (1 -lt 2)

#For multiple conditions, use -and and -or
'1 -eq 1 -or 1 -gt 2 returns:' + (1 -eq 1 -or 1 -gt 2)
'1 -eq 1 -and 1 -lt 2 returns:' + (1 -eq 1 -and 1 -lt 2)

#Powershell also has control flow structures that you can use
#if(){
#}

#while/until(){
#}
#do{
#}while/until()

#foreach(){
#}

#switch(){
#}

Get-Help about_If
Get-Help about_While
Get-Help about_ForEach
Get-Help about_Switch

#Use If to check for things, like if a file or directory exists (and what to do if it doesn't)
New-Item -ItemType Directory -Path 'C:\TEMP'
If((Test-Path 'C:\TEMP') -eq $false){New-Item -ItemType Directory -Path 'C:\TEMP'}

Remove-Item -Recurse 'C:\TEMP'
If((Test-Path 'C:\TEMP') -eq $false){New-Item -ItemType Directory -Path 'C:\TEMP'}


#while or until do things based on their conditions
#do is sytnax that allows you to put the while/until at the end of the loop instead of the beginning
$x=0
while($x -lt 10){
    New-Item -ItemType File -Path "C:\TEMP\WhileJunk$x.txt"
    $x++
}

dir C:\TEMP

$x=0
do{
    Remove-Item -Path "C:\TEMP\WhileJunk$x.txt"
    $x++
}until($x -ge 10 )

dir C:\TEMP

#Collections and Arrays
Get-Help about_arrays

#Arrays are useful ways to collect data
$list = @('PICARD','RIKER','WESLEY')
$list

#Specify the specific item in an array with [] (0 based numbering)
"This is list item #2:"+ $list[1]

#Use foreach to iterate through collections
foreach ($item in $list){
    "Item $item" | out-host
}

#So now we can make a collection of other objects and process it using our control checks
$dirs = dir C:\ | Where-Object {$_.PSIsContainer -eq $true}
foreach($dir in $dirs){
    $fullname = $dir.FullName
    $count = (dir $fullname | Measure-Object).Count
    "$fullname - $count"
    if($count -gt 10){
        "$fullname has lots of files!"| out-host
    }
    else{
        "$fullname is kind of puny."| out-host
    }
}

#Powershell supports error handling with standard syntax: try/catch/finally/throw
get-help about_try_catch_finally
get-help about_throw


try{ #the inital thing we try to do
    "This is a code block" | Out-Host
    throw (Write-warning "Then an Error happens....")
}
catch{ #What happens with an error
    Write-Error "An error has occurred!" #using Write-Error actually feeds things to the host's error handling system
}
finally{ #optional, always happens
    Write-host "Run a cleanup action" -ForegroundColor Green #Write-Host is generally not used, but here in this case to change text color
}

#Powershell can interface with .Net libraries, COM objects, other functionality.
#For example, we can use Powershell to interact directly with the WMI
$wmi=Get-WmiObject -Class Win32_ComputerSystem
$wmi | Get-Member

$wmi.NumberOfProcessors
$Wmi.NumberOfLogicalProcessors
$wmi.Domain

#We can format output in a couple different ways.  Table and list are the most commonly used options
$wmi | Format-List
$wmi | Format-Table -AutoSize

#Note that the object doesn't display everything available.  We can control this with Select-Object.
$wmi | Select-Object Name,Domain,TotalPhysicalMemory,NumberOfProcessors,Model | Format-List

$wmi | Select-Object Name,Domain,TotalPhysicalMemory,NumberOfProcessors,Model | Format-Table -AutoSize

#of course, we can get really fancy
#This funcion allows us to query all the attached volumes (disks and mountpoints) for size and freespace.
gwmi win32_volume -computername 'localhost' | where {$_.drivetype -eq 3} | Sort-Object name `
	 | Format-Table name,@{l="Size(GB)";e={($_.capacity/1gb).ToString("F2")}},@{l="Free Space(GB)";e={($_.freespace/1gb).ToString("F2")}},@{l="% Free";e={(($_.Freespace/$_.Capacity)*100).ToString("F2")}}

#Note the -computername parameter.  We can execute the WMI call against a remote machine if we want.
#Working with our previous example, we could make a quick inventory report of our environment
$comps = Get-ADComputer -Filter 'ObjectClass -eq "Computer"' 
Get-WmiObject -Class Win32_ComputerSystem -ComputerName $comps.name | Select-Object Name,Domain,TotalPhysicalMemory,NumberOfProcessors,Model | Format-Table -AutoSize

#Many commands in Powershell can be used remotely.
Get-Help about_remote

#We can also use an ssh-like command to enter a Powershell terminal session on a remote machine
Enter-PSSession -ComputerName PICARD

$env:computername
$env:username
exit

#Also, we can use the Invoke-Command cmdlet to run any command remotely.
[ScriptBlock]$cmd = {Test-Path -Path 'C:\DBFiles'}

Invoke-Command -ComputerName PICARD -ScriptBlock $cmd

#For these to work, Windows Remote Managment(WinRM) needs to be enabled and firewall rules set to allow the remote connections.

#While we have a base set of cmdlets and functions, we can also extend Powershell through the use of modules and snap-ins
#Snap-ins were introduced in v1, but were replaced by modules in v2+

Import-Module ActiveDirectory
Get-Command -Module ActiveDirectory

#With Powershell 3, modules can be implicitly loaded when you use a cmdlet from that module
Remove-Module ActiveDirectory
Get-ADDomain