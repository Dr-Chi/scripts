#!/bin/bash
#
# https://github.com/Dr-Chi/scripts/master/linux/newsetup.sh
#
# Copyright (c) 2019 DrChi. Released under the MIT License.
#
# One-liner to call this script from terminal:
# wget https://raw.githubusercontent.com/Dr-Chi/scripts/master/linux/newsetup.sh -O newsetup.sh && bash newsetup.sh && rm newsetup.sh
#
#
# Notes:
# Use the following to use a ' in arrays:
# '"'"'
# All queries with double pipes (||) are there to ensure duplicates aren't created, the arrays help with this search and for iteration
# Why not just replace the whole bashrc with a custom file?  Various distros often throw custom stuff in the bashrc, this is a less destructive way to customize it

# Change the history to not include duplicate commands
sed -i 's/.*HISTCONTROL.*/HISTCONTROL=ignoreboth:erasedups/' .bashrc

# Add aliases and functions to bashrc
	grep -q "[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases" ~/.bashrc || echo -e '\n[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases' >> ~/.bashrc
	grep -q "[[ -f ~/.bash_functions ]] && . ~/.bash_functions" ~/.bashrc || echo -e '\n[[ -f ~/.bash_functions ]] && . ~/.bash_functions' >> ~/.bashrc

# Add to ~/.bash_aliases
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
		"alias speedtest"
		"alias extip"
		"alias cpwd"
		"alias recall"
		"alias ff"
		"alias fd"
		"alias path"
		"alias now"
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
		'alias hs='"'"'HISTTIMEFORMAT='"'"'%F_%T  '"'"' history |grep'"'"''
		'alias bashreload='"'"'source ~/.bashrc && echo Bash config reloaded'"'"''
		# get internet speed
		'alias speedtest='"'"'wget -O /dev/null http://speedtest.wdc01.softlayer.com/downloads/test500.zip'"'"''
		# get external ip
		'alias extip='"'"'curl icanhazip.com'"'"''
		# copy the current working directory to the clipboard
		'alias cpwd='"'"'pwd | xclip -selection clipboard'"'"''
		# go to the last directory you were in
		'alias recall='"'"'cd $OLDPWD'"'"''
		# quickly find files and directory
		'alias ff='"'"'find . -type f -name'"'"''
		'alias fd='"'"'find . -type d -name'"'"''
		# print the path with each directory separated by a newline
		'alias path='"'"'echo -e ${PATH//:/\\n}'"'"''
		# print the current time
		'alias now='"'"'date +%T'"'"''
	)

	#for ((i=0;i<${#toGrepAliases[@]};i++))  #this works but I prefer "for i in"
	for i in $(echo ${!toGrepAliases[@]});
	do
	    grep -q "${toGrepAliases[$i]}" ~/.bash_aliases || echo ${aliases[$i]} >> ~/.bash_aliases;
	done

# Add to ~/.bash_functions
	toGrepFunctions=(
		"mkcd()"
		"copyfile()"
		"editbash()"
	)
	# All functions need that ending semicolon before the last curly!
	functions=(
		'#Make a directory then cd into it\nmkcd() { mkdir -p $1; cd $1; }'
		'#Copy a file to the clipboard from the command line\ncopyfile() { cat $1 | xclip -selection clipboard; }'
		'#Edits one of the bash files, use with editbash a or f for aliases or functions\neditbash() { [[ "$1" == "a" ]] && nano ~/.bash_aliases || { [[ "$1" == "f" ]] && nano ~/.bash_functions || nano ~/.bashrc; }; }'
	)
	
	for i in $(echo ${!toGrepFunctions[@]});
	do
	    grep -q "${toGrepFunctions[$i]}" ~/.bash_functions || echo -e ${functions[$i]} >> ~/.bash_functions;
	done
