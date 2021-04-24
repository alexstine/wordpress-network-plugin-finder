#!/bin/bash
base_path="/home/user/subdir" # Base path of script directory.
logfile="${base_path}/output.log" # Base path plus log file.
rm -f "$logfile" # Start with a fresh log file.
save="${base_path}/save.log" # A place to save our results.
echo "Starting: $(date)..." | tee -a "$logfile"
if [ -z "$1" ]; then
	echo "Provide DB password as first script arg. Exiting..." | tee -a "$logfile"
	exit 1
fi
dbhost="localhost" # Database host.
dbuser="user" # Database username.
dbpass="$1" # Database password or filled from command arg.
dbprefix="wp_" # The WordPress database prefix. Default is set to wp_.
plugin="some-plugin" # Plugin we're searching for.
for database in $(mysql -h"$dbhost" -u"$dbuser" -p"$dbpass" -e "show databases;" | tail -n +2 | grep -v 'information_schema' | grep -v 'performance_schema' | grep -v 'mysql' ); do # Creating a loop of databases.
	if ! mysql -h"$dbhost" -u"$dbuser" -p"$dbpass" "$database" -e "show tables;" | grep -q "${dbprefix}sitemeta"; then # Checking to make sure our database table exists. If not, continue the loop.
		echo "${dbprefix}sitemeta table doesn't exist for ${database}. Next..." | tee -a "$logfile"
		continue
	fi
	if ! mysql -h"$dbhost" -u"$dbuser" -p"$dbpass" "$database" -e "select meta_value from ${dbprefix}sitemeta where meta_key = 'active_sitewide_plugins';" | grep -q "$plugin"; then # Check to see if our plugin exists. If not, continue the loop.
		echo "Skipping ${database}. ${plugin} not found." | tee -a "$logfile"
		sleep 5
		continue
	fi
	echo "$database" >> "$save" # Write our database to the save file.
	echo "Saving ${database} because ${plugin} was found." | tee -a "$logfile"
	sleep 5 # Wait a few seconds to not overload database server.
done
if [ -r "$save" ]; then
	total_records=$(wc -l "$save") # Get the total lines of our save file.
	echo "Total records saved: ${total_records}." | tee -a "$logfile"
else
	echo "The script came up empty." | tee -a "$logfile"
fi
echo "Completed: $(date)." | tee -a "$logfile"
exit 0