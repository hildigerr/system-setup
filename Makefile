TIMEZONE=/usr/share/zoneinfo/US/Pacific
LOCALE=en_US

arch: umask usergroups wheel timezone localization

timezone:
	ln -sf "$TIMEZONE" /etc/localtime
	hwclock --systohc

localization:
	sed -i "s/#$LOCALE.UTF-8/$LOCALE.UTF-8/" /etc/locale.gen
	locale-gen
	echo "LANG=$LOCALE.UTF-8" > /etc/locale.conf


ubuntu: usergroups-ubuntu ubuntu-xxx
	add-apt-repository ppa:moonsdad/ppa
	apt-get purge byobu yelp #https://bugs.launchpad.net/ubuntu/+source/yelp/+bug/1404728
	apt-get autoremove

umask:
	@echo "Setting default umask to 077"
	sed -i -e "s/^UMASK.*$/UMASK\t\t077/" /etc/login.defs
	sed -i -e "s/^umask.*$/umask 077/" /etc/profile

umask-ubuntu: umask
	sed -i -e "s/#umask 022/#umask 077/" /etc/skel/.profile

usergroups:
	@echo "Enabling users group"
	sed -i -e "s/USERGROUPS_ENAB yes/USERGROUPS_ENAB no/" /etc/login.defs

usergroups-ubuntu: usergroups
	sed -i -e "s/^# GROUP=100/GROUP=100/" /etc/default/useradd
	usermod -g users $USER
	gpasswd -d $USER $USER
	delgroup $USER
	chmod -R g-w $HOME

ubuntu-xxx:
	@echo "TODO: change to use UPower and ConsoleKit services" 
	echo |                       (EDITOR="tee -a" visudo)
	echo "#Users can shutdown" | (EDITOR="tee -a" visudo)
	echo "%users ALL =NOPASSWD: /sbin/poweroff,/sbin/shutdown,/sbin/reboot" | (EDITOR="tee -a" visudo)

wheel:
	echo "%wheel ALL=(ALL) ALL" | (EDITOR="tee -a" visudo)
