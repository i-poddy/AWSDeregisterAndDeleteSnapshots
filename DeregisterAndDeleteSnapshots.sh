#!/bin/bash

# Define log file
LOG_FILE="deregister_and_delete_snapshots.log"

# Function to log messages to both console and log file
log_message() {
  echo "$1" | tee -a "$LOG_FILE"
}

# Check if input file was provided
if [ -z "$1" ]; then
  log_message "Usage: $0 <ami-id-list.txt>"
  exit 1
fi

INPUT_FILE="$1"

# Check if file exists
if [ ! -f "$INPUT_FILE" ]; then
  log_message "File not found: $INPUT_FILE"
  exit 1
fi

# Log start of script
log_message "Starting script at $(date)"

# Loop through each line in the file
while IFS= read -r AMI_ID || [ -n "$AMI_ID" ]; do
  log_message "Processing AMI: $AMI_ID"

  # Get snapshot IDs associated with the AMI
  SNAPSHOT_IDS=$(aws ec2 describe-images \
    --image-ids "$AMI_ID" \
    --query "Images[*].BlockDeviceMappings[*].Ebs.SnapshotId" \
    --output text)

  if [ -z "$SNAPSHOT_IDS" ]; then
    log_message "No snapshots found for AMI $AMI_ID or AMI does not exist."
    continue
  fi

  log_message "Snapshots associated with AMI $AMI_ID: $SNAPSHOT_IDS"

  # Deregister the AMI
  log_message "Deregistering AMI $AMI_ID..."
  aws ec2 deregister-image --image-id "$AMI_ID"
  if [ $? -ne 0 ]; then
    log_message "Failed to deregister AMI $AMI_ID"
    continue
  fi

  # Delete each snapshot
  for SNAP_ID in $SNAPSHOT_IDS; do
    log_message "Deleting snapshot $SNAP_ID..."
    aws ec2 delete-snapshot --snapshot-id "$SNAP_ID"
    if [ $? -ne 0 ]; then
      log_message "Failed to delete snapshot $SNAP_ID"
      continue
    fi
  done

  log_message "Finished processing AMI $AMI_ID"
  log_message "-----------------------------------"
done < "$INPUT_FILE"

# Log end of script
log_message "All done at $(date)"
