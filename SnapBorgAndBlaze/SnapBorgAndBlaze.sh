#!/bin/bash

DATE=`date +%Y-%m-%d-%H-%M`

echo $DATE > /LizardFS/BorgMetaBackup/LastBackup.txt
echo Taking snapshot...  >> /LizardFS/BorgMetaBackup/LastBackup.txt
rsync -vart /var/lib/mfs/* /LizardFS/BorgMetaBackup/Snap/ >> /LizardFS/BorgMetaBackup/LastBackup.txt

echo Starting backup...  >> /LizardFS/BorgMetaBackup/LastBackup.txt
export BORG_PASSPHRASE=### Your Password Here! ###
/LizardFS/Files/MediaStore/Backups/borg-linux64 create -xv --stats --progress --compression lzma,9 /LizardFS/BorgMetaBackup/Borg::$DATE /LizardFS/BorgMetaBackup/Snap 2>&1 /LizardFS/BorgMetaBackup/LastBackup.txt
/LizardFS/Files/MediaStore/Backups/borg-linux64 prune --keep-within 7d /LizardFS/BorgMetaBackup/Borg >> /LizardFS/BorgMetaBackup/LastBackup.txt

echo Uploading files... >> /LizardFS/BorgMetaBackup/LastBackup.txt
### Don't forget to create this file!
B2_ACCOUNT_INFO=/root/.b2_account_info
b2 sync --delete /LizardFS/BorgMetaBackup/Borg b2://MetaBack &>> /LizardFS/BorgMetaBackup/LastBackup.txt
