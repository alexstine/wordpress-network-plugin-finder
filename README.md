# wordpress-network-plugin-finder

A very simple shell script to scan for WordPress Multisite network activated plugins. Compatible with Linux and MySQL. This script will not check every sub site, just network wide plugins. The script will use wp_sitemeta to search in by default. You can change optional params as outlined below.

## To Use

First of all, if you are not comfortable around the command line, don't use this script as it requires some manual editing.

1. Clone the repo or download the .zip from the Releases tab.
2. Extract the .zip if you went that direction.
3. Open network-plugin-finder.sh to edit the following values.
- base_path: set this to the base directory path of your script. For example, /home/user/subdirectory.
- The default logfile will output to base_path/output.log. You can change this if you wish.
- The default save file will output to base_path/save.log. You can change this if you wish.
- dbhost: set to localhost by default. Enter your database host value here.
- dbuser: set to user by default. Enter your database username here.
- dbpass: set to arg by default. Enter the database password as the first arg while executing the script or manually fill it in.
- dbprefix: default is wp_. Only change if your WordPress database prefix is different. You can find your database prefix in your wp-config.php file.
- plugin: default set to some-plugin. Change this to the name of the plugin directory. E.g. /wp-content/plugins/plugin-directory/plugin-file.php. The part you want is plugin-directory.

## Running the Script

To run the script, execute the following.

    /path/to/script/network-plugin-finder.sh 'db_password_here'

### Support

If you spot an issue or have a question, open an issue. I hope this script serves useful.