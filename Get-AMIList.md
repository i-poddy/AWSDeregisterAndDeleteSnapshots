### `Get_AMI_List_By_Name.md`

# Retrieve AMI IDs by Name Pattern

This PowerShell script retrieves Amazon Machine Image (AMI) IDs based on a name pattern using the AWS CLI. It helps you find and log AMIs that match a specific naming convention, such as backups or versioned images.

---

## 📋 What It Does

- Accepts a wildcard name pattern for AMIs (e.g., `your_ami_name*`)
- Queries AWS for AMIs that match the pattern
- Appends each AMI ID to `ami-id-list.txt`, with one ID per line

---

## ▶️ How to Use

1. Open PowerShell or Bash console.
2. Navigate to the folder containing the script.
3. Set the environment variables for access Keys
4. Run the script like this:

```powershell
.\Get-AMIListByName.ps1 -amiNamePattern "your_ami_name*"
```

OR

```bash
./get_ami_ids.sh 'your_ami_name*'
```

Replace `your_ami_name` with the one you want to match.

---

## 🗂 Output

The script appends AMI IDs to a file called `ami-id-list.txt` in the same directory. 
Each AMI ID is written on a new line.

---

## 🔐 Required Permissions

The AWS CLI must be configured, and the IAM user or role executing the script must have the following permission:

- `ec2:DescribeImages`

## TODO

Improve the script to accept different filtering method

- Older than 