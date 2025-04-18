# Define log file
$logFile = "deregister_and_delete_snapshots.log"

# Function to log messages to both console and log file
function Log-Message {
    param (
        [string]$message
    )
    $message | Tee-Object -FilePath $logFile -Append
}

# Check if input file was provided
if ($args.Count -eq 0) {
    Log-Message "Usage: .\DeregisterAndDeleteSnapshots.ps1 <ami-id-list.txt>"
    exit 1
}

$inputFile = $args[0]

# Check if file exists
if (-not (Test-Path $inputFile)) {
    Log-Message "File not found: $inputFile"
    exit 1
}

# Log start of script
Log-Message "Starting script at $(Get-Date)"

# Loop through each line in the file
Get-Content $inputFile | ForEach-Object {
    $amiId = $_
    Log-Message "Processing AMI: $amiId"

    # Get snapshot IDs associated with the AMI
    $snapshots = (aws ec2 describe-images --image-ids $amiId --query "Images[*].BlockDeviceMappings[*].Ebs.SnapshotId" --output text)

    if ([string]::IsNullOrEmpty($snapshots)) {
        Log-Message "No snapshots found for AMI $amiId or AMI does not exist."
        return
    }

    Log-Message "Snapshots associated with AMI ${amiId}: ${snapshots}" # Used ${} because the variable was near to special characters ":" 

    # Deregister the AMI
    Log-Message "Deregistering AMI $amiId..."
    aws ec2 deregister-image --image-id $amiId
    if ($?) {
        Log-Message "Successfully deregistered AMI $amiId"
    } else {
        Log-Message "Failed to deregister AMI $amiId"
        return
    }

    # Delete each snapshot
    $snapshots.Split() | ForEach-Object {
        $snapshotId = $_
        Log-Message "Deleting snapshot $snapshotId..."
        aws ec2 delete-snapshot --snapshot-id $snapshotId
        if ($?) {
            Log-Message "Successfully deleted snapshot $snapshotId"
        } else {
            Log-Message "Failed to delete snapshot $snapshotId"
        }
    }

    Log-Message "Finished processing AMI $amiId"
    Log-Message "-----------------------------------"
}

# Log end of script
Log-Message "All done at $(Get-Date)"
