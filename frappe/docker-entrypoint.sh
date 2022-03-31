#!/bin/bash
# fix apps permission
sudo chown frappe:frappe /home/frappe/apps
# init
if [ ! -f /home/frappe/apps/.init ];  then
    cd /home/frappe/apps
    # init frappe
    bench init --frappe-branch $FRAPPE_BRANCH frappe-bench --frappe-path $FRAAPE_GIT
    cd /home/frappe/apps/frappe-bench
    # get app erpnext
    bench get-app --branch $ERPNEXT_BRANCH erpnext $ERPNEXT_GIT
    # setup admin password
    password=$(cat /dev/urandom | head -n 18 | md5sum | head -c 18)
    echo $password > /home/frappe/apps/password.txt
    echo "frappe default admin password at /home/frappe/apps/password.txt"
    cd /home/frappe/apps/frappe-bench
    # new site
    bench new-site $DOMAIN --db-type $DB_TYPE --db-host $DB_HOST --mariadb-root-password $DB_PASSWORD  --admin-password $password --install-app erpnext
    
    # Production Setup
    sudo sed -i 's/reload/force-reload/g' /usr/local/lib/python3.8/dist-packages/bench/config/supervisor.py
    bench setup supervisor --user frappe --yes
    bench setup nginx --yes
    touch /home/frappe/apps/.init
fi
# start
sudo ln -s /home/frappe/apps/frappe-bench/config/supervisor.conf /etc/supervisor/conf.d/frappe-bench.conf
sudo ln -s /home/frappe/apps/frappe-bench/config/nginx.conf /etc/nginx/conf.d/frappe-bench.conf

sudo /usr/sbin/nginx -g "daemon off; master_process on;" &
sudo /usr/bin/supervisord -n -c /etc/supervisor/supervisord.conf &

# Wait for any process to exit
wait -n

# Exit with status of process that exited first
exit $?