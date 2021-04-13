# Generate MSOL Group Membership csv

$Groups = Get-MsolGroup
[array]$GroupMembers = $null
foreach ($Group in $Groups)
{
    $Members = Get-MsolGroupMember -GroupObjectId $Group.ObjectId
    foreach($Member in $Members)
    {
        $GroupMember = New-Object -TypeName psobject
        $GroupMember | Add-Member NoteProperty -Name GroupName -Value $Group.DisplayName
        $GroupMember | Add-Member NoteProperty -Name GroupEmail -Value $Group.EmailAddress
        $GroupMember | Add-Member NoteProperty -Name MemberName -Value $Member.DisplayName
        $GroupMembers += $GroupMember
    }
}
$GroupMembers | Export-Csv Members.csv
