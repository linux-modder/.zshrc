# TOC
#   Defaults etc...             M0TZLS
#   Environment                 7RS56S
#   Aliases                     RJ706I
#   Functions                   ZGC5QQ

# uname should be readable in $uname 
sestatus | grep -Ei "current mode"
upower -m -d |grep percentage | sort | uniq -f 1
 if [ -f `which powerline-daemon` ]; then
  powerline-daemon -q
  POWERLINE_BASH_CONTINUATION=1
  POWERLINE_BASH_SELECT=1
  . /usr/share/powerline/bash/powerline.sh
 fi
#####   Defaults etc...             M0TZLS  #####

# This is based on zshrc which came with Debian (Third option in wizard for new users.)

# Save history
export HISTSIZE=99999
export SAVEHIST=$HISTSIZE
setopt hist_ignore_all_dups
export HISTFILE=~/.zsh_history
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
## Homebrew |* Linuxbrew *
export PATH="$HOME/.linuxbrew/bin:$PATH"
export MANPATH="$HOME/.linuxbrew/share/man:$MANPATH"
export INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH"


# Set up the prompt

# Green for normal user and red for root and show exit status
# if it's not 0. Thank you nyuszika7h
autoload -Uz vcs_info
autoload -Uz colors && colors
setopt PROMPT_SUBST
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' enable git svn bzr hg
zstyle ':vcs_info:*' formats '%b '
precmd() { vcs_info }

PS1="%B%(!.%F{red}.%F{green})%n@%M ://:%D{%a, %d %B %T %Z} %~
$? %f %b"


# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
if [[ $UNAME != Linux ]]; then
    eval "$(dircolors -b)"
fi
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# Show the hostname, uptime and users logged in on shell start
(hostname&)
(uptime&)
(echo "")

if [[ $UNAME != Darwin  ]] then;
    (who -H -w -u|head -n10&)
    (echo "")
    (last -10 -w -x&)
fi

if [[ $UNAME = Darwin ]]; then
    (who -H -u|head -n10&)
    (echo "")
    (last -10&)
fi

#####   Environment                 7RS56S  #####
# Environment should be placed to .environment or .zsh_environment (or .zshenv).

# Source before mentioned locations if they exist.

# .environment
if [ -f ~/.environment ]; then
    source ~/.environment
fi

# .zsh_environment
if [ -f ~/.zsh_environment ]; then
    source ~/.zsh_environment
fi

# .zshenv (Yes, I know that this is sourced by every zsh session even if this isn't here, but I just want to write it).
if [ -f ~/.zshenv ]; then
    source ~/.zshenv
fi

# Enable core files.
(ulimit -c unlimited&)


#More colours 
if [[ $TERM == 'xterm' ]]; then
export TERM=xterm-256color
fi

if [[ $TERM == 'screen' ]]; then             
export TERM=screen-256color              
fi

# Sets the default editor.
export EDITOR=vim # LINUXMODDER_GREP # LINUXMODDER_GREP_ENVIRONMENT

# Sets locale. You can get list of locales with "locale -a" command. This should be something which ends to .utf8
export LC_ALL=en_US.UTF-8 # LINUXMODDER_GREP # LINUXMODDER_GREP_ENVIRONMENT

# Sets your timezone. Set in format <Region/City>, or just timezone like UTC.
export TZ="America/New_York" # LINUXMODDER_GREP # LINUXMODDER_GREP_ENVIRONMENT

# Sets PATH. To add another path, add :</path/to/new/path> to string below. 
PATH=$HOME/.local/bin:$HOME/.local/sbin:$HOME/bin:$HOME/sbin:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin:$PATH

# Add RubyGems to PATH
if hash ruby 2>/dev/null; then
    PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH"
fi

# Removes duplicates from $PATH. Copied from http://unix.stackexchange.com/a/14896
#PATH=$(echo "$PATH" | awk -v RS=':' -v ORS=":" '!a[$1]++{if (NR > 1) printf ORS; printf $a[$1]}')

# "Changes" home directory without root. Uncomment both lines below this.
export HOME=/home/ameridea
cd

# Colours to less
# Copied from http://nion.modprobe.de/blog/archives/572-less-colors-for-man-pages.html
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# Sets environment variable CPUARCH to output of "uname -p" and UNAME to "uname"
CPUARCH=$(uname -p)

# Copied from http://homepages.see.leeds.ac.uk/~eeaol/notes/2012/03/how_to_only_type_ssh_passphrase_once/
export SSH_AUTH_SOCK=/tmp/$USER.agent
ssh-agent -a /tmp/$USER.agent > /dev/null 2>&1

# If we are on Linux, enable apt progress bar and colours
if [[ $USER = "root" ]]; then
    mkdir -p /etc/dnf/dnf.conf.d/
    echo 'dnf::Progress-Fancy "1";' > /etc/dnf/dnf.conf.d/99progressbar
    echo 'dnfPM::Progress-Fancy "1";' >> /etc/dnf/dnf.conf.d/99progressbar
    echo 'DNF::Color "1";' > /etc/dnf/dnf.conf.d/99color
fi

# In our series useless/weird environment variables, beep
export beep=
export BEEP=

# OS X ls colours (copied from https://apple.stackexchange.com/questions/33677/
export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

# make
alias maken="make -j$NPROC"

# Ensure that pkg-config paths are found
export PKG_CONFIG_PATH=$(which pkg-config)

#####   Aliases                     RJ706I  #####

# To get sudo work with aliases.
alias sudo="sudo "

# Moving between directories:
alias ..="cd .."

# Use htop instead of top, it's better. Requires htop.
alias top="htop" # LINUXMODDER_GREP LINUXMODDER_GREP_ALIAS

# Add title to youtube-dl & make yle-dl Windows-friendly
alias youtube-dl="youtube-dl -t"
alias yle-dl="yle-dl --vfat"

# git specific. This is the command which I use when git asks me to commit something and says that I have modified files, even when I haven't.
alias gdrop="git stash && git stash drop"

# Show compilation date of WeeChat.
#alias weechat-version="weechat --help|head -n2"

#NMAP specific. All nmap things should be run as root, so it's probably best to copy these aliases to root's .zshrc. Things which don't run without root ask for sudo password.
alias nmap-intense="nmap -T4 -A -v -PE -PS22,25,80 -PA21,23,80,3389 "
alias nmap-intense-udp="sudo nmap -sS -sU -T4 -A -v -PE -PS22,25,80 -PA21,23,80,3389 "
alias nmap-intense-all-tcp="nmap -p 1-65535 -T4 -A -v -PE -PS22,25,80 -PA21,23,80,3389 "
alias nmap-intense-no-ping="nmap -T4 -A -v -PN "
alias nmap-ping="nmap -sP -PE -PA21,23,80,3389 "
alias nmap-quick="nmap -T4 -F "
alias nmap-quick-plus="sudo nmap -sV -T4 -O -F --version-light "
alias nmap-traceroute="sudo nmap -sP -PE -PS22,25,80 -PA21,23,80,3389 -PU -PO --traceroute "
alias nmap-regular="nmap "
alias nmap-comprehensive="sudo nmap -sS -sU -T4 -A -v -PE -PP -PS21,22,23,25,80,113,31339 -PA80,113,443,10042 -PO --script all " 
# Little "safer" scan as connecting to only HTTP and HTTPS ports doesn't look so attacking. Copy-paste to .zsh_custom and remove  " -p 80,443" if you want to scan all ports which nmap scans by default.
alias nmap-osscan="sudo nmap -p 80,443 -O -v --osscan-guess --fuzzy "

# Downloads folder over SSH. Usage: rdownload <host>:<remotefolder> <local_destination> | TIP: use ~/ssh/config to configure hosts.
alias rdownload="rsync -h --progress -avz "
alias rscp='rsync -h --progress -avz '
alias rscpr='rsync -h --progress -azvv '

# TMUX specific
alias tmux="tmux -2u"
alias attach="tmux attach-session"
alias detach="tmux detach"

# I am always typoing "aptitude" with my phone...
alias yum="dnf "

# The Battle for Wesnoth specific, http://wesnoth.org/
# It seems to be an good idea to have debug logs on terminal with svn version.
#alias wesnoth="wesnoth --debug"

# Auto extension things, ( modified from https://wiki.archlinux.org/index.php/Zsh#Advanced_.zshrc_files )
#alias -s html=$BROWSER
#alias -s org=$BROWSER
#alias -s php=$BROWSER
#alias -s com=$BROWSER
#alias -s net=$BROWSER
#alias -s png="eog"
#alias -s jpg="eog"
#alias -s gif="eog"
#alias -s sxw="libreoffice --writer"
#alias -s doc="libreoffice --writer"
#alias -s gz='tar -xzvf'
#alias -s bz2='tar -xjvf'
#alias -s java=$EDITOR
#alias -s txt=$EDITOR
#alias -s PKGBUILD=$EDITOR

# For copy-pasting directly from somewhere
alias %=" "
alias \#=" "

# Supybot specifig. Why to write long command, if you can write short command?
#alias supybot-config-reload="killall -HUP supybot "
#alias supybot-owner-quit="killall -INT supybot "
# Translating plugins in Limnoria
#alias supybot-generate-messages.pot="pygettext --docstrings config.py plugin.py"
#alias supybot-check-plugin-trans="sandbox/check_trans.py plugins/"
#alias supybot-check-core-trans="sandbox/check_trans.py --core"
#alias supybot-generate-messages.pot-mass="find . -type d -exec sh -c '(cd {} && pygettext --docstrings config.py plugin.py)' ';'"

# ZSH specific.
# I think that "theme" is more describing than "prompt".
alias theme="prompt "

## -- Start of aliases which are saved from Ubuntu default bashrc. --

# enable color support of ls and also add handy aliases
if [[ $UNAME != Darwin ]]; then
    alias ls='ls --color=always'
fi
alias dir='dir --color=always'
alias vdir='vdir --color=always'
alias grep='grep -i --color=always'
alias fgrep='fgrep -i --color=always'
alias egrep='egrep -i --color=always'
# some more ls aliases
if [[ "$UNAME" != "Darwin" ]]; then
    alias ll='ls -ALFH --color=always' && alias la='ls -A --color=always' && alias l='ls -CF --color=always'
fi

if [[ $UNAME = Darwin ]]; then
    alias ls="ls -Gp"
    alias ll="ls -alFHGp"
    alias l="ls -CFGp"
    alias ssh-add="\ssh-add -D && \ssh-add -K"
fi

# Add an "alert" alias for long running commands.  Use like so:
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
                        
## -- End of aliases which are saved from Ubuntu default bashrc. --

# Copying command in Supybot (Internet.DNS)
alias dns="nslookup "
alias dns6="nslookup -type=AAAA "
alias nslookup6="nslookup -type=AAAA "

# If I have nslookup6...
alias dig6="dig AAAA "

# SSHGuard specific
alias sshguard-show-bans="sudo iptables -L sshguard --line-numbers"
# Enter ban number as arguement. You can see ban numbers with previous command.
alias sshguard-unban="sudo iptables -D sshguard "

# This needs something which makes it easy to remember.
alias KILL="killall -KILL "

# For locally rsync copying folder1 to folder2.
alias rsync-folder="rsync -h --progress -azvv "

# SSHGuard seems to prefer users to run this always when connecting with keys in ssh-agent...
if [[ $UNAME != Darwin ]]; then
    alias ssh-add="\ssh-add -D && \ssh-add "
fi

# Use GPG2 instead of GPG!
alias gpg=gpg2
compdef gpg2=gpg
export KEYBASE_GPG=gpg2
alias gpg-fix-tty='export GPG_TTY=$(tty)'

# ZSH doesn't currently include automatic completion for GPG2, 
# so use the GPG one, which works with GPG2 too. This is in aliases, 
# because that above alias needs this and this will disappear when zsh 
# gets GPG2 completion. See 
# http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=666755
compdef gpg2=gpg # LINUXMODDER_GREP LINUXMODDER_GREP_ALIAS

# Allow custom aliases to be put in .aliases or .zsh_aliases .

# Secure cat
alias scat="gpg --decrypt "

# To check are keys, which apt uses changed
alias gpg-key-refresh-keys="gpg --recv-keys --keyserver keys.fedoraproject.org --refresh-keys"

# To see which mirror http://mirrors.fedoraproject.org puts you to. The file which has the latest update time is the mirror which you are using.
#alias http.fedoraproject.org="curl -sL http://http.mirrors.fedoraproject.org/pub|pandoc -f html -t markdown"

# Amount of keys in GPG keyring.
alias gpg-key-amount="gpg --list-keys|grep '^pub'|wc -l"
alias gpg-key-count="gpg --export -a|gpg --import"

alias follow="tail -F"

#myip shows current IP. This was a function.
alias myip4="dig +short myip.opendns.com A @208.67.222.222"
alias myip6="dig +short myip.opendns.com AAAA @2620:0:ccc::2"
alias myip="myip4 && myip6"

# Update groups without logging out. Requires entering password. Source: http://blog.edwards-research.com/2010/10/linux-refresh-group-membership-without-logging-out/
alias refreshgroups="exec su -l $USER"

# Get public key lenght of (public) SSH key
alias ssh-pubkey-length="ssh-keygen -lf "

# MSDOS commands. MSDOS is after every alias line to get these lines easily by grepping.
alias cls=clear # MSDOS
alias help=man # MSDOS
alias ipconfig=ifconfig # MSDOS
alias copy=cp # MSDOS
alias move=mv # MSDOS

# List git committers of repository
alias git-committers="git shortlog -s"
alias git-changelog="git log --oneline --decorate"
alias git-changelog-color="git log --oneline --decorate --color"

alias unixle="flip -ub "
alias msdosle="flip -mb "

# Making .iso bootable from CD/DVD/USB. Cat it to /dev/<DEVICE>
# MaKe Hybrid ISO
alias mkhiso=isohybrid

# DNF
alias dnf-unlock="rm -rf /var/run/dnf.pid"
alias dnf-rm-timedhosts="rm /var/cache/dnf/$CPUARCH/17/timedhost*"
alias dupy="sudo dnf update --ref -y "
alias dup="sudo dnf update "
alias dugy="sudo dnf upgrade --ref -y "
alias dug="sudo dnf upgrade -y

# Archiving and extracting with tar
# This is tartar to avoid conflict with tar
alias tartar="tar cfv "
alias targz="tar cfvz "
alias tarbz2="tar cfvj "
# ex-tartar and ex-tar, because there is alias tartar and command tar
alias ex-tar="tar xfv "
alias ex-tartar="tar xfv "
alias ex-targz="tar xfvz "
alias ex-tarbz2="tar xfvj "

# systemd runlevels/targets
alias currenttargets="systemctl list-units --type=target"
alias telsystemd="systemctl isolate "
alias defaulttarget="systemctl enable "

# For getting timestamps in history
alias history="history -i "

# To have less handle ls colours
alias less="less -R "

# "su -" with/without sudo
alias ssu="sudo su -"
alias suu="su -"

# ReSet Screen rss
alias rss=reset

# FINEID
alias ssh-add-sc="ssh-add -s $(find /usr/*lib -name 'opensc-pkcs11.so')"
alias ssh-add-sc-pub="\ssh-add -L"

# Same as the previous, but for yum --> dnf

if [ -f /usr/bin/dnf ]; then
    alias yum=dnf
fi

# Simple HTTPd with Python.
alias python2-httpd="python2 -m SimpleHTTPServer"
alias python3-httpd="python3 -m http.server"

# Resetting different desktop environments
alias reset-kde="rm -rf ~/.kde4 ~/.kde"
alias reset-xfce4="rm -rf ~/.config/xfce4"
alias reset-matepanel="mate-panel --reset"

# Show date in ISO 8601 format
#alias isodate='date -Is'
#alias isodateu='date -uIs'
#alias isodatea='date "+%Y-%m-%dT%H:%M:%S%z"'
alias isodateua='date -u "+%Y-%m-%dT%H:%M:%S%z"'

# Show information on PEM file.
alias peminfo="openssl x509 -text -in"

# tmux emergency attach
alias tmuxeattach="/proc/$(pgrep -o tmux)/exe attach"

# Copy-paste mtr output more easily
alias mtrp="mtr -rwc 10"
alias mtrp4="mtr -rw4c 10"
alias mtrp6="mtr -rw6c 10"

# pip
alias pip="python -m pip"
alias pip2="python2 -m pip"
alias pip3="python3 -m pip"
alias pippypy="pypy -m pip"
alias pippypy2="pypy2 -m pip"
alias pippypy3="pypy3 -m pip"
alias pypypip=pippypy
alias pypypip2=pippypy2
alias pypypip3=pippypy3

# apg with small letters, capital letters and numbers. I don't usually use
# special characters as they sometimes have difficulties with some systems
# and cross-platform operating systems.
# APG IS LIMITED TO 255 CHARACTERS SO IT'S REPLACED WITH PWGEN!
# Usage: apt-random <minimum length>
alias apg-random="pwgen -s"

# cp/mv using rsync. rcp appears to be link to scp in my system, so I can
# safely use this alias.
alias rcp="rsync -a --progress"
alias rmv="rsync -a --progress --remove-source-files"


# Accept all cookies with Lynx, makes browsing easier and
# every other browser does this too.
alias lynx="lynx -accept_all_cookies"
alias links="links -g"
# Cat multiple files preserving filenames
# via http://stackoverflow.com/a/7816490
alias multicat='tail -n +1'

# Getting SSIDs and keys from connmann (Jolla)
alias connman-wlans='grep -E "Name|Passphrase" /var/lib/connman/wifi*/settings --no-filename'


# ex command. Copied from zshrc of bioterror ( http://ricecows.org/configs/zsh/.zshrc ). Original comment below:
## for unit193 ;)
## use command "ex" to extract any archive files.
## "ex package.zip" for example
function ex ()

{
if [ -f "$1" ] ; then
case "$1" in
      *.tar)                tar xvf $1          ;;
      *.tar.bz2 | *.tbz2 )  tar xjvf $1         ;;
      *.tar.gz | *.tgz )    tar xzvf $1         ;;
      *.bz2)                bunzip2 $1          ;;
      *.rar)                unrar x $1          ;;
      *.gz)                 gunzip $1           ;;
      *.zip)                unzip $1            ;;
      *.Z)                  uncompress $1       ;;
      *.7z)                 7z x $1             ;;
      *.xz)                 tar xJvf $1         ;;
      *.deb)
         DIR=${1%%_*.deb}
         ar xv $1
         mkdir ${DIR}
         tar -C ${DIR} -xzvf data.tar.gz        ;;
      *.rpm)               rpm2cpio $1 | cpio -vid  ;;
      *)   echo ""${1}" cannot be extracted via extract()"
;;
    esac
   else
    echo ""${1}" is not a valid file"
fi
}

# Given by nyuszika7h. Shortens GitHub URLs with git.io
function gitio() {
    curl -s -i http://git.io -F "url=$1" | grep --color=never -P '^Location: ' | awk '{ print $2 }'
}

# This function will install/upgrade shell-things.

function shell-things {

export SHELL_THINGS_REPO=$HOME/.shell-things

# Check if ~/.shell-things exists and cd and pull.
if [ -d $SHELL_THINGS_REPO ]; then
    echo "shell-things: $SHELL_THINGS_REPO exists, git pulling..."
    echo ""
    cd $SHELL_THINGS_REPO
    git remote set-url origin https://github.com/Mikaela/shell-things.git
    git pull
    echo ""
    echo "shell-things: Installing/Upgrading..."
    echo ""
# If it doesn't exist...
else
    echo ""
    echo "shell-things: $SHELL_THINGS_REPO doesn't exist, cloning..."
    echo ""
    git clone https://github.com/Mikaela/shell-things.git $SHELL_THINGS_REPO
    cd $SHELL_THINGS_REPO
    echo ""
    echo "shell-things: Installing/Upgrading..."
    echo ""
fi

# Installing...
bash -x ./install
echo ""
echo "shell-things: Installing finished."
echo ""

echo ""
echo "shell-things: Everthing is now done :)"
echo ""

cd

}

#This function removes and regenerates ssh host keys.

ssh-regen-host-keys () {
        rm /etc/ssh/ssh_host_*
        ssh-keygen -t dsa -N "" -C "linux.ameridea_dsa" -f /etc/ssh/ssh_host_dsa_key
        ssh-keygen -t rsa -N "" -C "linux.ameridea_rsa" -f /etc/ssh/ssh_host_rsa_key
        ssh-keygen -t ecdsa -N "" -C "linux.ameridea_ecdsa" -f /etc/ssh/ssh_host_ecdsa_key
        ssh-keygen -t ed25519 -N "" -C "linux.ameridea_ed25519" -f /etc/ssh/ssh_host_ed25519_key
}



# Use clang if installed. It seems interesting and this is probably good
# way to test it. This might not be a function, but I don't have any better
# place for this.
if hash clang 2>/dev/null; then
    export CC=clang
fi

if hash clang++ 2>/dev/null; then
    export CXX=clang++
fi

# Add GitHub pull requests to fetched things via http://git.io/-C-0oQ
github-add-pulls() {
    git config --add remote.origin.fetch '+refs/pull/*/head:refs/remotes/origin/pr/*'
    git config --add remote.upstream.fetch '+refs/pull/*/head:refs/remotes/upstream/-pr/*'
    git config --global user.email linux-modder@users.no-reply.github.com
    git config --global user.signingkey 0x5A88E539
    git config --global user.name "Corey 'linuxmodder'  Sheldon"
    git config --global gpg.program gpg2
}

# Get server SSL certificate fingerprint in MD5, SHA1 and SHA256.
# Note that OpenSSL doesn't support IPv6 at time of writing (2015-01-13).
serversslcertfp () {
    SSSLCFFN=$(openssl s_client -showcerts -connect $1 < /dev/null)
    # To see all validity information
    echo $SSSLCFFN
    # For getting the fingerprints
    echo $SSSLCFFN | openssl x509 -md5 -fingerprint -noout
    echo $SSSLCFFN | openssl x509 -sha1 -fingerprint -noout
    echo $SSSLCFFN | openssl x509 -sha256 -fingerprint -noout
    unset SSSLCFFN
}

# The same for local certificate file
sslcertfp () {
    cat $1 | openssl x509 -md5 -fingerprint -noout
    cat $1 | openssl x509 -sha1 -fingerprint -noout
    cat $1 | openssl x509 -sha256 -fingerprint -noout
}

# Usage: serversslciphers hostname port
serversslciphers() {
    nmap -Pn $1 -p $2 --script +ssl-enum-ciphers
}

# Generate SSL certificate
sslgenpem () {
    openssl req -nodes -newkey rsa:4096 -keyout $1.pem -x509 -days 3650 -out $1.pem -subj "/CN=$2"
}
xscreensaver &

