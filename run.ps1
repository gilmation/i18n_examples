# args is less than 2 - adios
if($args.length -lt 2) {
  write-host Usage: "run host sub_directory" 
  return
}

# si MYSQL_HOME no existe
if(($env:MYSQL_HOME -eq $null) -or ($env:MYSQL_HOME.length -eq 0)) {
  write-host "Cannot continue MYSQL_HOME is [$env:MYSQL_HOME]" 
  write-host "Bailing"
  return
}

#Copy command line args to local vars
$ipValue = $args[0]
$dirValue = $args[1]

if(!(Test-Path ".\$dirValue")) {
  write-host "Oops, cannot continue [$dirValue] does not exist !" 
  write-host "Bailing"
  return
}

if(!(Test-Path ".\$dirValue\schema.sql")) {
  write-host "Oops, cannot continue [.\$dirValue\schema.sql] does not exist !" 
  write-host "Bailing"
  return
}

if(!(Test-Path ".\$dirValue\data.sql")) {
  write-host "Oops, cannot continue [.\$dirValue\data.sql] does not exist !" 
  write-host "Bailing"
  return
}

cd $dirValue

& "$env:MYSQL_HOME\mysql.exe" "--host=$ipValue" --user=root -e '\. schema.sql'
& "$env:MYSQL_HOME\mysql.exe" "--host=$ipValue" --user=root -e '\. data.sql'

cd ..

