# vagrant-box
A dev environment that I use for mainly PHP/Drupal but also has some other goodies.

## How to use
I usually make a folder in my home directory called 'Sites' and then I clone this repo into that folder. 
You will need to have Vagrant and Virtualbox installed on your system. 
Virtualbox can be substituted for some other systems, [LINK](http://docs.vagrantup.com/v2/providers/index.html).
If you do use this box I would recommend making a box out of it so you don't need to re-provision with Salt, which can take a long time, [LINK](https://scotch.io/tutorials/how-to-create-a-vagrant-base-box-from-an-existing-one).
I basically use this to simply compile a Vagrant Box for use.
The Salt files are very basic so if you are interested in learning a bit of Salt I would recommend checking them out.
```
$ cd $HOME
$ mkdir Sites
$ cd Sites
$ git clone https://github.com/thornycrackers/vagrant-box .
$ vagrant up
```
After running vagrant up you will probably have to choose an internet connection, which is almost always choice 0 because that's usually the active one.
You will also be asked for you password so /etc/exports can be modified.


