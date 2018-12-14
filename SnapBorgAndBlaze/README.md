### This script:
 - Creates takes a snapshot of my LizardFS metadata.
 - Adds that snapshot to an encrypted borg repository.
 - Removed and backups older than 7 days.
 - Syncs the encrypted borg repo to a backblaze bucket.

### Prerequisites:
 - python-pip
 - BackBlaze Account (a 2GB account is free!)
 - BackBlaze B2 utility.
 - borgbackup

### Prerequisite instructions:

>sudo apt install python-pip borgbackup

>sudo pip install --upgrade b2

You will need to initialize your borg repo with something like:
>borg init --encryption=keyfile /LizardFS/BorgMetaBackup/Borg

Create a BackBlaze account and store your account info.  In this demo I am using my (I know its not best practice) root account at:
>/root/.b2_account_info

Finally, set add your password to the script (or use your preferred method of secure password storage).

### Notes: 
 - I create a file at [/LizardFS/BorgMetaBackup/LastBackup.txt] that is just a log of my last run time.  I then run this script in a cron job.
