system-update:
  cmd.run:
    - name: 'sudo rm -rvf /var/lib/apt/lists/* && sudo apt-get update'

/home/vagrant/.bashrc:
  file.managed:
    - source: 'salt://files/bashrc'

/home/vagrant/.vimrc:
  file.managed:
    - source: 'salt://files/vimrc'

mail-packages:
  pkg.installed:
    - pkgs:
      - build-essential
      - mailutils
      - sendmail

mail-host-entry:
  host.present:
    - ip: 127.0.0.1
    - names:
      - localhost.localdomain
      - localhost
      - vagrant-ubuntu-trusty-32

git:
  pkg.installed
