# Deregister and Delete AMI Snapshots Script (Bash)

This Bash script allows you to deregister one or more Amazon Machine Images (AMIs) and delete their associated snapshots. It reads a list of AMI IDs from a file, processes each AMI ID, and performs the following actions:
- Retrieves the snapshots associated with each AMI.
- Deregisters the AMI.
- Deletes each associated snapshot.

---

### Requirements

- **AWS CLI**: The script uses AWS CLI commands to interact with AWS EC2. Ensure that the AWS CLI is installed and configured on your system.
- **AWS Access Keys**: The script requires valid AWS access keys or an IAM role with the necessary permissions.

---

### Prerequisites

1. **Install AWS CLI** (if you haven't already):
   - You can download and install AWS CLI from [here](https://aws.amazon.com/cli/).
   - After installation, run `aws --version` to verify it's installed correctly.

2. **Configure AWS CLI Credentials**:
   - Run `aws configure` and enter your AWS Access Key ID, Secret Access Key, and default region.
   - Alternatively, you can export the environment variables `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` as needed.

---

### Setting AWS Credentials in Bash

Before running the script, you need to set the AWS access credentials. Use the following export commands:

```bash
export AWS_ACCESS_KEY_ID="YOUR_ACCESS_KEY"
export AWS_SECRET_ACCESS_KEY="YOUR_SECRET_KEY"
export AWS_DEFAULT_REGION="us-east-1"  # Replace with your region (e.g., us-west-2)
```

Replace `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` with your actual AWS credentials.

### Preparing the Input File

Create a text file (e.g., `ami-id-list.txt`) containing one AMI ID per line. For example:

```
ami-1234567890aXXXXXX
ami-0abcdef1234XXXXXX
ami-0123456789aXXXXXX
```

To automate this step check 

- [Automate AMI List Generation →](Get-AMIList.md)

### Running the Script

To execute the script, follow these steps:

1. Open a terminal and navigate to the directory where `deregister_and_delete_snapshots.sh` is located.

2. Make the script executable (only needs to be done once):

```bash
chmod +x deregister_and_delete_snapshots.sh
```

3. Run the script with the input file containing AMI IDs:

```bash
.\DeregisterAndDeleteSnapshots.ps1 ami-id-list.txt
```

### Script Output

- **Log File**: The script logs all actions and errors to `deregister_and_delete_snapshots.log` in the same directory.
- **Console Output**: You will also see real-time updates in the console as the script processes each AMI and its snapshots.

### Permissions Required

Ensure that the AWS user or role running this script has the following permissions:

- `ec2:DescribeImages`
- `ec2:DeregisterImage`
- `ec2:DeleteSnapshot`

### Troubleshooting

- **AWS CLI not configured**: Check you have Set AWS Access Keys as Environment Variables correctly
- **Insufficient Permissions**: Check the user whose AWS Access Keys you are using has the required permissions