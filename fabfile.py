from fabric.api import * #Fabric
from time import gmtime, strftime #Timestamping files
import string # For split() function
import os # filename stuff

# Defining the vagrant environment
def vagrant():
    # change from the default user to 'vagrant'
    env.user = 'vagrant'
    # connect to the port-forwarded ssh
    env.hosts = ['127.0.0.1:2222']
    # use vagrant ssh key
    result = local('vagrant ssh-config | grep IdentityFile', capture=True)
    env.key_filename = result.split()[1]

# Dump all of the mysql databases from vagrant
def mysql_export():
    # Get all the databases
    databases = run("mysql --user=root --password=root -e 'SHOW DATABASES;' | tr -d '| ' | grep -v Database") 
    # Turn multi-line output into array of words
    databases = databases.split('\n')
    current_date = strftime("%Y_%m_%d", gmtime())
    local_dir = '~/Desktop/vagrant_mysql_dump_' + current_date
    # Make the directory
    local('mkdir -p %s' % local_dir)
    for database in databases:
    # Remove white space
        database = database.strip()
        # Ignore the default databases
        if database not in ['mysql', 'performance_schema', 'information_schema']:
            remote_file = '%s.sql' % database
            run('mysqldump -u root -proot --result-file=%s %s' % (remote_file, database))
            get(remote_path=remote_file, local_path=local_dir)
            run('rm %s' % remote_file)


# Import a bunch of sql files from a folder into vagrant
def mysql_import(local_path):
    if prompt('Are you sure you wish to import databases? This may overwrite if duplicates exist.'):
        mysql_files = local("ls %s" % local_path, capture=True)
        mysql_files = mysql_files.split('\n')
        print "Here they come"
        for import_file in mysql_files:
            #get rid of any white space
            import_file = import_file.strip()
            local_file = '%s/%s' % (local_path, import_file)
            put(local_file, '/home/vagrant/')
            run('mysql -u root -proot -e "CREATE DATABASE IF NOT EXISTS %s;"' % os.path.splitext(import_file)[0])
            run('mysql -u root -proot %s < %s' % (os.path.splitext(import_file)[0], import_file))
            run('rm %s' % import_file)

# Issues a y/n prompt to the user
def prompt(query):
    print('\n%s [y/n]' % query)
    val = raw_input()
    if val == 'y':
        return True
    elif val == 'n':
        return False
    else:
        return prompt(query)
