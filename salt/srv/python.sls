python-pip:
  pkg.installed

python3:
  pkg.installed

python3-pip:
  pkg.installed
  
python-dev:
  pkg.installed
  
libmysqlclient-dev:
  pkg.installed

virtualenv:
  pip.installed:
    - require:
      - pkg: python-pip

django:
  pip.installed:
    - require:
      - pkg: python-pip

flask:
  pip.installed:
    - require:
      - pkg: python-pip

mysql-python:
  pip.installed:
    - require:
      - pkg: python-pip
      
pudb:
  pip.installed:
    - require:
      - pkg: python-pip
