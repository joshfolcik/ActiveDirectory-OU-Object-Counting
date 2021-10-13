$ouresults = @()
$ous = Get-ADOrganizationalUnit -LDAPFilter '(name=*)' -SearchBase 'DC=<yourdomain>,DC=com' -Server <your domain.com or specific DC>
Foreach($ou in $ous)
{
$counting = Get-ADObject -server <yourdomain.com or specific DC> -Filter * -SearchBase $ou.distinguishedname -SearchScope OneLevel | 
    where-object {$_.ObjectClass -ne "organizationalUnit"} | Measure-Object
$ouresult =$ou.tostring() + ";" + $counting.count
    $ouresults += $ouresult
} 

$ouresults | export-csv -path .\ouresults.csv -notypeinformation
