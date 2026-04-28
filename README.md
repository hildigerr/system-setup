# My System Setup and Maintenance Tools
This repository centralizes the configuration and maintenance scripts to automate and synchronize [Arch Linux](https://archlinux.org/) installations across multiple machines.

## System Setup
 1. Prepare the system and hardware as per the [installation guide](https://wiki.archlinux.org/title/Installation_guide#Pre-installation).
 2. For the installation step, my current **mirrorlist** is provided and a dummy **PKGBUILD** lists packages I find basically essential.
 3. The configuration step is automated by the **Makefile**.

### Mirrorlist
The mirrorlist is included to ensure it is updated consistency across all synchronized machines. It is interesting to compare which mirrors spring up or disappear, over time, around the world. However, only select mirrors are enabled, prioritizing educational institutions by reputation and geographic proximity.

### Makefile
The default target does the following: 

 1. Sets the default file creation mask to **077**, so files are only accessible to user by default.
 2. Enables the **users** group (as opposed to user private groups). These together enable fine grain control of privacy and collaboration.
 3. Configures the traditional **wheel** group for system admins.
 4. Sets the timezone. Override default with `TIMEZONE=/usr/share/zoneinfo/WHATEVER/Zone`.
 5. Sets the localization. Override with `LOCALE=whatever_LOCALE`. 
 6. Configures the network host name. Override with `HOSTNAME=Whatever`.
 7. Adds [my custom repository](https://hildigerr.github.io/arch-repo/) to the pacman configuration.
 8. Echos a reminder of next steps, which are: synchronize mirrors and update installed packages, set root password, setup the [boot loader](https://wiki.archlinux.org/title/Arch_boot_process#Boot_loader), dynamic host configuration, zeroconf discovery, and audio.

For setting up the boot loader, two make targets are available: `grub-efi` and `grub` . The selection of which to use depends upon the [firmware](https://wiki.archlinux.org/title/GRUB#UEFI_systems).

Make targets are available for the remaining steps:

| target                        | purpose                    |
| ----------------------------- | -------------------------- |
| `dhcp-start`                  | dynamic host configuration |
| `avahi-dns`                   | zeroconf discovery         |
| `audio-install`,`audio-start` | audio via pipewire         |

## Additional Configuration
Beyond basic setup, there are additional files and make targets for system configuration:

### Accessibility
| target     | file                  | purpose                                |
| ---------- | --------------------- | -------------------------------------- |
| mount-rule | 50-udisks-mount.rules | Enable `storage` group users to mount automatically |

### Monitor Setup
| target                  | file                | purpose                     |
| ----------------------- | ------------------- | --------------------------- |
| monitors                | 10-monitor.conf     | Setup dual monitors         |
| monitors-disable-timers | 10-serverflags.conf | Prevent monitors from automatically doing anything via timers |
| monitors-disable-dpms   | 10-extensions.conf  | Prevent monitors from automatically doing anything via graphics card signals |

### Residuals  
There are also some unused, leftover make targets.
| target              | purpose                                               |
| ------------------- | ----------------------------------------------------- |
| `numlock`           | Enable numlock automatically. Doesn't work            |
| `ubuntu`            | Add [my old ppa](https://launchpad.net/~moonsdad/+archive/ubuntu/ppa) and cleanup unnecessary packages, on Ubuntu |
| `umask-ubuntu`      | Prevent Ubuntu's skel profile from overriding the file creation mask |
| `usergroups-ubuntu` | Enable users group on Ubuntu                          |
| `ubtunu-xxx`        | Enable Ubuntu users to turn off the computer          |

## Application Launchers
The `apps` directory contains desktop files to enable various applications to appear in the menu or to be autostarted. It includes the PKGBUILD for the `app-menu-links` package, available in [my custom repo](https://hildigerr.github.io/arch-repo/).

## Tools
The `bin` directory contains various scripts, primarily for system maintenance.
| file           | purpose                                                    |
| -------------- | ---------------------------------------------------------- |
| `audit-deps`   | Audit an executable's dependencies for what should replace one that is deprecated |
| `audit-man`    | List all commands in the *$PATH* that do not have man pages |
| `get_ip`       | Extract the current IP address into a [Dropbox](https://www.dropbox.com/) file |
| `mount-gdrive` | Mount Google drive(s) via [Rclone](https://rclone.org/)    |
| `pacmaintain`  | [Audit installed packages](https://wiki.archlinux.org/title/Pacman/Tips_and_tricks) for [installation reason](https://wiki.archlinux.org/title/Pacman#Installation_reason), orphans, and becoming abandoned; also assist processing `pacnew` and `pacsave` files |
| `ripiso`       | Backup to ISO file                                         |
| `scan`         | Continuously scan a document from ADF and/or flatbed until done |
| `scrape`       | Retrieve all files with a specified extension from a target URL |

## Grub Themes
The `grub` directory contains grub themes:

### Victoria
A simple steampunk grub theme using the [Toroid](https://github.com/hildigerr/font-toroid) font, which is also available via [my custom repo](https://hildigerr.github.io/arch-repo/).
![Victoria Background Image](https://raw.githubusercontent.com/hildigerr/system-setup/refs/heads/master/grub/victoria/grub_bg.png)



