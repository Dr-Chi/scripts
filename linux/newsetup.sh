#!/bin/bash
#
# https://github.com/Dr-Chi/scripts/master/linux/newsetup.sh
#
# Copyright (c) 2019 DrChi. Released under the MIT License.
#
# One-liner to call this script from terminal:
# wget https://raw.githubusercontent.com/Dr-Chi/scripts/master/linux/newsetup.sh -O newsetup.sh && bash newsetup.sh

# Add to ~/.bash_aliases

#cat <<EOT >> ~/.bash_aliases
#alias runmobsf='sudo docker run -it -p 8000:8000 -v MobSFData:/root/.MobSF opensecurity/mobile-security-framework-mobsf:latest'
#alias editmobsf='sudo docker run -it --entrypoint /bin/bash -v MobSFData:/root/.MobSF opensecurity/mobile-security-framework-mobsf:latest'
#alias screenscale='xrandr --output eDP-1 --scale 1.4x1.4 --panning 3584x2016+0+0'
#EOT
grep -qxF 'alias runmobsf"' ~/.bash_aliases || echo alias runmobsf=\'sudo docker run -it -p 8000:8000 -v MobSFData:/root/.MobSF opensecurity/mobile-security-framework-mobsf:latest\' >> ~/.bash_aliases
