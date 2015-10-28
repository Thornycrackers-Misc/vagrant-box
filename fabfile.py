# -*- coding: utf-8 -*-
'''
Fabfile for dealing with some simple vagrant commands
'''

# Import libs
from fabric.api import * 
from time import gmtime, strftime
import string
import os

def vagrant():
    '''
    Method for defining the vagrant environment
    '''
    env.user = 'vagrant'
    env.hosts = ['127.0.0.1:2222']
    result = local('vagrant ssh-config | grep IdentityFile', capture=True)
    env.key_filename = result.split()[1]

def mysql_export():
    '''
    Dump all the MySQL databases in vagrant to ~/Desktop
    '''
    databases = run("mysql --user=root --password=root -e 'SHOW DATABASES;' | tr -d '| ' | grep -v Database") 
    databases = databases.split('\n')
    current_date = strftime("%Y_%m_%d", gmtime())
    local_dir = '~/Desktop/vagrant_mysql_dump_' + current_date
    local('mkdir -p %s' % local_dir)
    for database in databases:
        database = database.strip()
        if database not in ['mysql', 'performance_schema', 'information_schema']:
            remote_file = '%s.sql' % database
            run('mysqldump -u root -proot --result-file=%s %s' % (remote_file, database))
            get(remote_path=remote_file, local_path=local_dir)
            run('rm %s' % remote_file)

def mysql_import(local_path):
    '''
    If you have a bunch of .sql files inside of a folder 
    this import will bring all of the files into the vagrant 
    mysql server based on filename
    '''
    if prompt('Are you sure you wish to import databases? This may overwrite if duplicates exist.'):
        mysql_files = local("ls %s" % local_path, capture=True)
        mysql_files = mysql_files.split('\n')
        print "Here they come"
        for import_file in mysql_files:
            import_file = import_file.strip()
            local_file = '%s/%s' % (local_path, import_file)
            put(local_file, '/home/vagrant/')
            run('mysql -u root -proot -e "CREATE DATABASE IF NOT EXISTS %s;"' % os.path.splitext(import_file)[0])
            run('mysql -u root -proot %s < %s' % (os.path.splitext(import_file)[0], import_file))
            run('rm %s' % import_file)

def prompt(query):
    print('\n%s [y/n]' % query)
    val = raw_input()
    if val == 'y':
        return True
    elif val == 'n':
        return False
    else:
        return prompt(query)
