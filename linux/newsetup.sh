# ~/.bash_aliases
alias runmobsf='sudo docker run -it -p 8000:8000 -v MobSFData:/root/.MobSF opensecurity/mobile-security-framework-mobsf:latest'
alias editmobsf='sudo docker run -it --entrypoint /bin/bash -v MobSFData:/root/.MobSF opensecurity/mobile-security-framework-mobsf:latest'
