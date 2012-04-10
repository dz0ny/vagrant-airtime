# Vagrant Airtime #

This is a [Vagrant][vagrant] setup for testing [Airtime][airtime] 2.1-beta3 internet radio playout/automation software. Uses
[Chef Solo][chef] recipes for provisioning. The recipes are copied from [those by Opscode][cookbooks-opscode], which
allows for their use with Chef Solo.

## Requirements ##

* [Vagrant][vagrant]

    $ gem install vagrant

## To get started ##

    $ git clone -b dev git://github.com/dz0ny/vagrant-airtime.git
    $ cd vagrant-airtime
    $ vagrant up
    $ open http://[node:fqdn] and login using admin:admin

Your Ubuntu/Airtime box exists as a virtual machine. The music folder running on 
the virtual machine is pointing back at the music directory on your local 
machine. So you can link your music directly to virtual machine.

    $ vagrant destroy

[vagrant]:http://vagrantup.com
[chef]:http://wiki.opscode.com/display/chef/Chef+Solo
[cookbooks-opscode]:https://github.com/opscode/cookbooks
[airtime]:http://en.flossmanuals.net/airtime-en-2-0/
