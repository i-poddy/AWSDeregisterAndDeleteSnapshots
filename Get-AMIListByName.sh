#!/bin/bash

# Validate input
if [ -z "$1" ]; then
  echo "Usage: $0 <AMI_NAME_PATTERN>"
  echo "Example: $0 'your_ami_name*'"
  exit 1
fi

AMI_NAME_PATTERN="$1"
OUTPUT_FILE="ami-id-list.txt"

# Get AMI IDs matching the name pattern
AMI_LIST=$(aws ec2 describe-images \
  --filters "Name=name,Values=${AMI_NAME_PATTERN}" \
  --query "Images[*].ImageId" \
  --output text)

# Check if AMIs were found
if [ -n "$AMI_LIST" ]; then
  # Split and write each AMI ID on a new line
  for ami_id in $AMI_LIST; do
    echo "$ami_id" >> "$OUTPUT_FILE"
  done
  echo "Successfully appended AMI IDs to $OUTPUT_FILE"
else
  echo "No AMIs found matching the pattern: ${AMI_NAME_PATTERN}"
fi
