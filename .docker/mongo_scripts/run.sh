#!/bin/bash
if [[ -e /.firstrun ]]; then
    echo"Running entrypoint.sh"
    /mongo_scripts/entrypoint.sh    
    echo"Scheduling backup CRON job for 13:00"
    cat <(crontab -l) <(echo "00 13 * * * /mongo_scripts/backup_job.sh") | crontab - 
    echo"Scheduling backup CRON job for 1:00"
    cat <(crontab -l) <(echo "00 01 * * * /mongo_scripts/backup_job.sh") | crontab -
    echo"Running first_run.sh"
    /mongo_scripts/first_run.sh
fi
echo"Starting MongoDB..."
/usr/bin/mongod --auth --bind_ip_all $@