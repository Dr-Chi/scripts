#!/bin/bash
#
# https://github.com/Dr-Chi/scripts/master/linux/newsetup.sh
#
# Copyright (c) 2019 DrChi. Released under the MIT License.
#
# One-liner to call this script from terminal:
# wget https://raw.githubusercontent.com/Dr-Chi/scripts/master/linux/newsetup.sh -O newsetup.sh && bash newsetup.sh && rm newsetup.sh

# Add aliases and functions to bashrc
	grep -q "[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases" ~/.bashrc || echo -e '\n[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases' >> ~/.bashrc
	grep -q "[[ -f ~/.bash_functions ]] && . ~/.bash_functions" ~/.bashrc || echo -e '\n[[ -f ~/.bash_functions ]] && . ~/.bash_functions' >> ~/.bashrc

# Add to ~/.bash_aliases
	#Notes:
	#Use the following to use a ' in arrays:
	# '"'"'

	toGrepAliases=(
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
		"alias meminfo"
		"alias psmem10"
		"alias wget"
		"alias df"
		"alias hs"
		"alias bashreload"
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
		'alias meminfo='"'"'free -m -l -t'"'"''
		'alias psmem10='"'"'ps auxf | sort -nr -k 4 | head -10'"'"''
		# -c equal continue download
		'alias wget='"'"'wget -c'"'"''
		'alias df='"'"'df -H'"'"''
		'alias hs='"'"'history | grep'"'"''
		'alias bashreload='"'"'source ~/.bashrc && echo Bash config reloaded'"'"''
	)

	#for ((i=0;i<${#toGrepAliases[@]};i++))  #this works but I prefer "for i in"
	for i in $(echo ${!toGrepAliases[@]});
	do
	    grep -q "${toGrepAliases[$i]}" ~/.bash_aliases || echo ${aliases[$i]} >> ~/.bash_aliases;
	done

# Add to ~/.bash_functions
	#Notes:
	#Use the following to use a ' in arrays:
	# '"'"'

	toGrepFunctions=(
		"mkcd()"
	)
	functions=(
		#Make a directory then cd into it\n \
		mkcd() { mkdir -p $1; cd $1 }
	)
	
	for i in $(echo ${!toGrepFunctions[@]});
	do
	    grep -q "${toGrepFunctions[$i]}" ~/.bash_functions || echo -e ${functions[$i]} >> ~/.bash_functions;
	done
