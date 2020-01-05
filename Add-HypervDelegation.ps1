Param (
    [Parameter(ValueFromRemainingArguments=$true)][String[]]$ComputerName
)

Import-Module ActiveDirectory
$DefDelegation = @()

foreach ($computer in $ComputerName) {
    $DefDelegation += @("Microsoft Virtual System Migration Service/$computer","cifs/$computer")

}

foreach ($computer in $ComputerName) {
    $ADcomputer = Get-ADComputer -Identity $computer
    $ADcomputer | Set-ADObject -add @{"msDS-AllowedToDelegateTo"=$DefDelegation}
    $ADcomputer | Set-ADAccountControl -TrustedToAuthForDelegation $true

}