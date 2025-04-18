# Deregister and Delete AMI Snapshots Script

This script allows you to deregister one or more Amazon Machine Images (AMIs) and delete their associated snapshots. It reads a list of AMI IDs from a file, processes each AMI ID, and performs the following actions:
- Retrieves the snapshots associated with each AMI.
- Deregisters the AMI.
- Deletes each associated snapshot.

## Script Version

There are two versions of this script, one written in bash and one written in powershell. 
Refer to the specific documentation for usage.

- [PowerShell Version →](Execute_Powershell.md)
- [Bash Version →](Execute_Bash.md)

### Script Output

- **Log File**: The script logs all actions and errors to `deregister_and_delete_snapshots.log` in the same directory.
- **Console Output**: You will also see real-time updates in the console as the script processes each AMI and its snapshots.

### Supporting Scripts

- [Automate AMI List Generation →](Get-AMIList.md)