#!/bin/bash
#
# https://github.com/Dr-Chi/scripts/master/linux/newsetup.sh
#
# Copyright (c) 2019 DrChi. Released under the MIT License.
#
# One-liner to call this script from terminal:
# wget https://raw.githubusercontent.com/Dr-Chi/scripts/master/linux/newsetup.sh -O newsetup.sh && bash newsetup.sh && rm newsetup.sh

# Add to ~/.bash_aliases
	#Notes:
	#Use the following to use a ' in arrays:
	# '"'"'

	toGrep=(
		"alias screenscale"
		"alias runmobsf"
		"alias editmobsf"
		"alias mount"
		"alias ports"
		"alias rm"
		"alias mv"
		"alias cp"
		"alias ln"
		"alias reboot"
	)
	aliases=(
		'alias screenscale='"'"'xrandr --output eDP-1 --scale 1.4x1.4 --panning 3584x2016+0+0'"'"''
		'alias runmobsf='"'"'sudo docker run -it -p 8000:8000 -v MobSFData:/root/.MobSF opensecurity/mobile-security-framework-mobsf:latest'"'"''
		'alias editmobsf='"'"'sudo docker run -it --entrypoint /bin/bash -v MobSFData:/root/.MobSF opensecurity/mobile-security-framework-mobsf:latest'"'"''
		'alias mount='"'"'mount |column -t'"'"''
		'alias ports='"'"'netstat -tulanp'"'"''
		# do not delete / or prompt if deleting more than 3 files at a time #
		'alias rm='"'"'rm -I --preserve-root'"'"''
		# confirmation #
		'alias mv='"'"'mv -i'"'"''
		'alias cp='"'"'cp -i'"'"''
		'alias ln='"'"'ln -i'"'"''
		'alias reboot='"'"'shurdown -r now'"'"''
	)

	#for ((i=0;i<${#toGrep[@]};i++))  #this works but I prefer "for i in"
	for i in $(echo ${!toGrep[@]});
	do
	    grep -q "${toGrep[$i]}" ~/.bash_aliases || echo ${aliases[$i]} >> ~/.bash_aliases;
	done
