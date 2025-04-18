param(
    [string]$amiNamePattern
)

# Define the output file
$outputFile = "ami-id-list.txt"

# Validate input
if (-not $amiNamePattern) {
    Write-Host "Please provide the AMI name pattern (e.g., your_ami_name*)"
    exit
}

# Get AMI list matching the pattern
$amiList = aws ec2 describe-images --filters "Name=name,Values=$amiNamePattern" --query "Images[*].ImageId" --output text

# Check and process the result
if ($amiList) {
    # Split by tab and append each AMI ID on a new line
    $amiList -split "`t" | ForEach-Object {
        $_.Trim() | Out-File -Append -FilePath $outputFile
    }

    Write-Host "Successfully appended AMI IDs to $outputFile"
} else {
    Write-Host "No AMIs found matching the pattern: $amiNamePattern"
}
