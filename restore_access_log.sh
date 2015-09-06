# Restore apache access_logs if they have been deleted
# Note: If you have Ubuntu or Debian based distribution
# there is not httpd directories but apache2
# Scenario:

$ su -
$ cd /var/log/httpd
$ rm -f access_log

# Solution:

$ ps aux | grep httpd	# note the PID of the main Apache process
$ ls -lsa /proc/1784/fd	# fd = a directory containing all of the file descriptors for a particular process
# we will find something like this: /var/log/httpd/access_log (deleted) and in front of it a 'X' number
$ service httpd stop	# stop the httpd service
$ cp /proc/1784/fd/7 /var/log/httpd/access_log
$ service httpd start
$ tail -f /var/log/httpd/access_log 	# to check if we restore it without problem

