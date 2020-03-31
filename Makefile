
ubuntu: usergroups
	add-apt-repository ppa:moonsdad/ppa
	apt-get purge byobu yelp #https://bugs.launchpad.net/ubuntu/+source/yelp/+bug/1404728
	apt-get autoremove

umask:
	@echo "Setting default umask to 077"
	sed -i -e "s/^UMASK.*$/UMASK\t\t077/" /etc/login.defs
	sed -i -e "s/^umask.*$/umask 077/" /etc/profile
	sed -i -e "s/#umask 022/#umask 077/" /etc/skel/.profile

usergroups: umask
	@echo "Enabling users group"
	sed -i -e "s/USERGROUPS_ENAB yes/USERGROUPS_ENAB no/" /etc/login.defs
	sed -i -e "s/^# GROUP=100/GROUP=100/" /etc/default/useradd
	usermod -g users $USER
	gpasswd -d $USER $USER
	delgroup $USER
	chmod -R g-w $HOME

