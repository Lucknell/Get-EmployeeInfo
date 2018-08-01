$employee =@()
function Get-EmployeeInfo{
param ($ADUsername)
$employee =@()
$Names =@("Firstname","Lastname")
$employee=Get-ADuser $ADUsername -properties * | Select-Object employeeid,displayname,department,samaccountname,mail,enabled,office,phone,payplan,organization

$employee.phone = $employee.phone -replace "555-555-","5"
$employee.phone = $employee.phone -replace "555/555-","5"
$employee.phone = $employee.phone -replace "444-444-","4"
$employee.phone = $employee.phone -replace "444/444-","4"
$employee.payplan = $employee.payplan |Out-string
$x = $employee.displayname.Split(" ")
$string = $x[0] +" "+ $x[1]
[string]$lastname =$x |select-object -last 1
if ($x.Length -gt 2)
{
$employee | Add-member -type NoteProperty -Name Firstname -Value $string
}
else 
{
$employee | Add-member -type NoteProperty -Name Firstname -Value $x[0]
}
$employee | Add-member -type NoteProperty -Name Lastname -Value $lastname


$employee}
 