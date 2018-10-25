#! /bin/zsh

#
# .zshrc
# 
# Author: Marcel Lippmann
# Date:   Fri Jun 16 17:04:06 CEST 2006
#
# Based on the version presented at the Linux Info Tag 2005 in Dresden.
#
#
# Updated to fit personal needs: Stephan Boehme
# Last update: 2016-04-03
#
# This file is in a GIT repo on my NAS, cloned to '~/Documents/GIT/InitFiles/zshrc'
# Put only the following line into your .zshrc at '~/':
# on the MacBook: 'source ~/Documents/GIT/InitFiles/zshrc'
# on root@Diski:  'source /volume1/homes/sb/GIT/InitFiles/zshrc'
# on root@Diski-chroot: 'source /home/zshrc'

#
# Important environment variables
#

case $(uname -s) in
    Darwin) export DEBUG="Case1";;
    Linux)  export DEBUG="Case2";;
    *)      export DEBUG="Case3";;
esac



# SHELL
export SHELL="/usr/local/bin/zsh"

# OS
export OS=$(uname -s)

# Perl
#export PERL5LIB="/users/lat/lippmann/.perl/lib/perl5/"
#export LD_LIBRARY_PATH="/users/lat/lippmann/.perl/lib/:$LD_LIBRARY_PATH"

# LaTeX
case $(uname -s) in
    Darwin) export PATH=/usr/local/texlive/2017/bin/universal-darwin:/usr/local/texlive/2013/bin/x86_64-darwin:/opt/local/bin:$PATH ;;
    Linux) export PATH=/usr/local/texlive/2018/bin/x86_64-linux:$PATH ;;
esac
#export TEXINPUTS=".:/users/lat/lippmann/Documents/LaTeXInputs/:"
#export BIBINPUTS=".:/users/lat/lippmann/Documents/LaTeXInputs/:"
#export BSTINPUTS=".:/users/lat/lippmann/Documents/LaTeXInputs/:"

# Terminal
#export TERM=xterm-256color

# switch to home by inputting 'cd'
export CDPATH="" #.:..:$HOME

# temp directory in home
#export TMPDIR=$HOME/.tmp

# gcc is standard compiler
export CC=gcc

# set color
export COLORTERM=yes
#bei Diski urspruenglish auskommentiert

# set editor, browser and pager
export EDITOR=emacs
export PAGER=less
export BROWSER=firefox
export TEXTBROWSER=links

# less options: skipscreenwhensearching,clear,ic,longprompt
#export LESS=aCiM
#export LESS=

# set language to English
export LC_C=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

# 30 directories can be pushed onto the stack. After every
# 'cd' the current directory is pushed onto the stack.
# The option 'auto_cd' should be set in order to get this
# performed.
#
# Show the directories with 'd' (alias to 'dirs -v'),
# change direcotry with 'cd +number'.
DIRSTACKSIZE=30

# History
  
  # size of history
  HISTSIZE=2000
  # maximal amount of entries to save
  SAVEHIST=2000
  # save history in:
  HISTFILE=~/.zsh_history


# Colors used bei 'ls' and completions
export LS_COLORS='no=0:fi=0:di=32:ln=36:or=1;40:mi=1;40:pi=31:so=33:bd=44;37:cd=44;37:ex=35:*.jpg=1;32:*.jpeg=1;32:*.JPG=1;32:*.gif=1;32:*.png=1;32:*.jpeg=1;32:*.ppm=1;32:*.pgm=1;32:*.pbm=1;32:*.c=1;33:*.C=1;33:*.h=1;33:*.cc=1;33:*.awk=1;33:*.pl=1;33:*.bz2=1;35:*.gz=1;31:*.tar=1;31:*.zip=1;31:*.lha=1;31:*.lzh=1;31:*.arj=1;31:*.tgz=1;31:*.taz=1;31:*.html=1;34:*.htm=1;34:*.doc=1;34:*.txt=1;34:*.o=1;36:*.a=1;36:*.php3=1;31'


#
# Functions and their aliases
#

#  # Wikipedia
#  function wikipedia () { $TEXTBROWSER "http://de.wikipedia.org/wiki/Spezial:Search/$*" ; }
#  function wikipediaen () { $TEXTBROWSER "http://en.wikipedia.org/wiki/Special:Search/$*" ; }
#  alias wiki=wikipedia
#  alias wikien=wikipediaen
#
#  # Google
#  function google () { $BROWSER "http://www.google.de/search?q=$*"; }

#
# functions for xterm title
#
  
# check whether the $TERM is an xterm or Eterm
case $TERM in
    xterm*|Eterm|rxvt*)
	precmd () { print -Pn "\e]0;${USER}@${HOST}: %4~\a" }
	preexec () { print -Pn "\e]0;${USER}@${HOST}: $1\a" }
	;;
esac

#
# Options
#

setopt \
NO_all_export \
   always_last_prompt \
NO_always_to_end \
   append_history \
   auto_cd \
   auto_list \
   auto_menu \
NO_auto_name_dirs \
   auto_param_keys \
   auto_param_slash \
   auto_pushd \
   auto_remove_slash \
NO_auto_resume \
   bad_pattern \
   bang_hist \
NO_beep \
   brace_ccl \
NO_bsd_echo \
   cdable_vars \
NO_chase_links \
NO_clobber \
   combining_chars \
   complete_aliases \
   complete_in_word \
   correct \
   correct_all \
   csh_junkie_history \
NO_csh_junkie_loops \
NO_csh_junkie_quotes \
NO_csh_null_glob \
NO_dvorak \
   equals \
   extended_glob \
   extended_history \
   function_argzero \
   glob \
NO_glob_assign \
   glob_complete \
   glob_dots \
   hash_cmds \
   hash_dirs \
   hash_list_all \
   hist_allow_clobber \
   hist_beep \
   hist_ignore_dups \
   hist_ignore_space \
NO_hist_no_store \
NO_hist_save_no_dups \
   hist_verify \
NO_hup \
NO_ignore_braces \
NO_ignore_eof \
   interactive_comments \
NO_list_ambiguous \
NO_list_beep \
   list_types \
   long_list_jobs \
   magic_equal_subst \
NO_mail_warning \
NO_mark_dirs \
NO_menu_complete \
   multios \
NO_nomatch \
   notify \
NO_null_glob \
   numeric_glob_sort \
NO_overstrike \
   path_dirs \
NO_posix_builtins \
NO_print_exit_value \
   prompt_cr \
   prompt_subst \
   pushd_ignore_dups \
NO_pushd_minus \
NO_pushd_silent \
   pushd_to_home \
   rc_expand_param \
NO_rc_quotes \
NO_rm_star_silent \
NO_sh_file_expansion \
   sh_option_letters \
   short_loops \
NO_sh_word_split \
NO_share_history \
NO_single_line_zle \
NO_sun_keyboard_hack \
   unset \
NO_verbose \
NO_xtrace \
   zle


#
# 'alias' pwnz!
#

# shortcuts of 'alias' and 'unalias' -- ought to be useful ^^
alias a=alias
alias ua=unalias

# showing the CPU temperature
#  alias cputemp='cat /proc/acpi/thermal_zone/THM/temperature'

# job control (1): bring fast to foreground
alias  1='fg %1'
alias  2='fg %2'
alias  3='fg %3'
alias  4='fg %4'
alias  5='fg %5'
alias  6='fg %6'

# job control (2): bring fast to background
alias 11='bg %1'
alias 22='bg %2'
alias 33='bg %3'
alias 44='bg %4'
alias 55='bg %5'
alias 66='bg %6'

# show all jobs
alias  j='jobs -l'
  
# show all processes as tree -- bsd syntax
alias px='ps aufx'

# change directory upwards very fast -- very useful
alias    ..='cd ..'
alias   ...='cd ../..'
alias  ....='cd ../../..'
alias .....='cd ../../../..'

# show directory stack
alias d='dirs -v'

# list the last ten new files/directories
alias lsnew='ls -rtl *(.) | tail'
alias lsnewdir='ls -rtl | tail'
  
# list the last ten old files/directories
alias lsold='ls  -tl *(.) | tail'
alias lsolddir='ls  -tl | tail'

# change rights -- secure!
alias rwx='chmod 700'
alias rw-='chmod 600'
alias r-x='chmod 500'
alias r--='chmod 400'

# important 'ls' shortcuts -- very, very useful!
  
  # use $LS_COLORS with 'ls'
  case $(uname -s) in
      Darwin)  alias ls='ls -F -G';;
      Linux)   alias ls='ls -F --color=auto';;
  esac

  # show all - with dotfiles and human readable
  alias la='ls -lah'

  # show contents as list and human readable
  alias ll='ls -lh'
  
  # show directory and not contents
  alias lsd='ls -d'
  
  # show direcory and not contents as list
  alias lld='ll -d'

  # show disk usage
  alias esu='du --max-depth=1 | sort -n | sed "s/^.*\t//"'
  alias use='du -h --max-depth=0 `esu`'

# grep -- very, very often used!

  # show matches red and search case insensitively
  alias grep='grep -i --color=auto'
  alias fgrep='fgrep -i --color=auto'
  alias egrep='egrep -i --color=auto'

# clear screen
alias cl='clear'

# burn iso
alias burn-iso='cdrecord -v -dao dev=0,1,0 speed=24'

# make directory (includes parent(s), no errors)
alias md='mkdir -p'

# .zshrc aliases -- wow!

  # edit .zshrc
  alias  __='$EDITOR ~/.zshrc'

  # use new .zshrc
  alias ___='source  ~/.zshrc'

# sudo/man fix
alias sudo='nocorrect sudo'
alias man='nocorrect man'
alias pass='nocorrect pass'

# my new aliases

alias speedtest='wget -O /dev/null http://speedtest.wdc01.softlayer.com/downloads/test10.zip'
alias findDuplicates='find . ! -readable -prune -not -empty -type f -printf "%s\n" | sort -rn | uniq -d | xargs -I{} -n1 find -type f -size {}c -print0 | xargs -0 md5sum | sort | uniq -w32 --all-repeated=separate'
alias emacs='emacs -nw'

case $(uname -s) in
    Darwin)
	# aliases to show/hide hidden files in MacOS finder 
	alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES;
                         killall Finder /System/Library/CoreServices/Finder.app'
	alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO;
                         killall Finder /System/Library/CoreServices/Finder.app'
	alias speedtest='wget -O /dev/null http://speedtest.wdc01.softlayer.com/downloads/test10.zip'
	alias protege='/Applications/Protege_5.0_beta/run.command'
	function finde () {tree --prune -aP $*;}
	;;
    Linux)
	case $OSTYPE in
	    linux-gnueabi)
		# alias to enter Debian-chroot at Diski
		alias deb='/var/packages/debian-chroot/scripts/start-stop-status chroot .'
		alias cd-chroothome='/volume1/@appstore/debian-chroot/var/chroottarget/home'
		alias update-zshrc='(cd /volume1/homes/sb/GIT/InitFiles; git pull)'
		alias openvpn-log='tail -f /var/log/openvpn.log'
		alias kontakte='psql -U postgres caldav -c "select vcard_text from addressbook_object"'
		;;
	    linux-gnueabihf)
		alias password-backup='/volume1/homes/sb/.scripts/password-backup.sh'
		alias update-zshrc='(cd /volume1/homes/sb/GIT/InitFiles; git pull)'
		alias ssh-start='/etc/init.d/ssh start'
		alias ssh-status='/etc/init.d/ssh status'
		;;
	    linux-androideabi)
		alias update-zshrc='(cd /storage/3665-6533/Android/data/com.termux/files/InitFiles; git pull)'
	esac
	;;
esac

   

#
# Modules
#

  # init prompt and completions (prompt is coloured)
  autoload -U compinit promptinit
  compinit
  promptinit

  #prompt suse
  case $OSTYPE in
      linux-gnueabihf)
	  export PS1='%(?::%F{red}[%?] )%F{green}[%*] %F{cyan}%n@%m-chroot %4~> %f'
	  ;;
      linux-androideabi)
	  export PS1='%(?::%F{red}[%?] )%F{green}[%T]%F{cyan} %1~> %f'
	  ;;
      *)
	  export PS1='%(?::%F{red}[%?] )%F{green}[%*] %F{cyan}%n@%m %4~> %f'
	  ;;
  esac
  
#
# Completions
#

  # Completion colorful
  zmodload -i zsh/complist

#  # ignore these file endings by completing.
#  fignore=( .BAK .bak .old .swp \~)

  # Make: Completion for all usual actions.
  compile=(install clean remove uninstall deinstall)
  compctl -k compile make

  # Old compctl completion -- Syntax:
  # compctl -g globstring + -g globstring2 program1 program2 progrmm3

#  # xine hack
#  compctl -g 'dvd://' + -g '*' xine

  # cd & co.: show only directories
  compctl -g '*(-/)' + -g '.*(/)' cd chdir dirs pushd rmdir
  
  # tar & co.: show only archive files and directories
  compctl -g '*.(gz|z|Z|t[agp]z|tarZ|tz)' + -g '*(-/)' gunzip gzcat zcat
  
  # audio: show only sound and playlist files and directories 
  # compctl -g '*.(mp3|MP3|ogg|OGG|temp|TEMP|m3u|pls)' + -g '*(-/)'  xmms mplayer
  
#  # browser: only html and directories
#  compctl -g "*.html *.htm" + -g "*(-/) .*(-/)" + -H 0 '' lynx links
#  
#  # pdf viewer and converter: only pdf files and directories.
#  compctl -g '*.(pdf|PDF)' + -g '*(-/)'  xpdf pdf2ps gpdf acroread pdf2dsc pdftotext pdftosrc pdftops
#
#  # image viewer: only images and directories
#  compctl -g '*.(jpg|JPG|jpeg|JPEG|gif|GIF|png|PNG|bmp)' + -g '*(-/)' gimp display qiv xnview

  # xdvi: only dvi files and directories
  compctl -g '*.dvi' + -g '*(-/)' dvips xdvi
  
  # gv: only ps or pdf files and directories
  compctl -g '*.(ps|PS|pdf|PDF)' + -g '*(-/)' gv evince

 # zstyle - new completion -- Syntax:
 # zstyle 'completion:function:completer:command:argument:tag' property value[s]

  # show original string as completion possibility
  zstyle ':completion:*:correct:*' original true

  # insert unambigous
  zstyle ':completion:*:correct:*' insert-unambiguous true

  # functions used for completion:
  zstyle ':completion:*' completer _complete _correct _approximate

  # globbing
  zstyle ':completion:*' glob true

  # verbose
  zstyle ':completion:*' verbose yes

  # format of corrections, warnings etc.
  zstyle ':completion:*:corrections' format $'%{\e[0;31m%}%d (errors: %e)%{\e[0m%}'
  zstyle ':completion:*:descriptions' format $'%{\e[0;31m%}%d%{\e[0m%}'
  zstyle ':completion:*:messages' format $'%{\e[0;31m%}%d%{\e[0m%}'
  zstyle ':completion:*:warnings' format $'%{\e[0;31m%}No matches for: %d%{\e[0m%}'
  zstyle ':completion:*' group-name ''
  zstyle -e ':completion:*:approximate:*' max-errors \
      'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'

  # colored completion - uses $LS_COLORS
  zstyle ':completion:*' list-colors ''
  zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

  # completion: menu with inverse active elements
  zstyle ':completion:*' menu yes=long-list
  zstyle ':completion:*' menu select=2

  # completions for some programs:

  
  # ssh: first user, then host
  zstyle ':completion:*:ssh:*' group-order 'users' 'hosts'
  
  # rm: first backup files
  zstyle ':completion:*:*:rm:*' file-patterns '(*~|\\#*\\#):backup-files' \
    '*.zwc:zsh\ bytecompiled\ files' 'core(|.*):core\ files' '*:all-files'

  # kill: unbelievable completions
  zstyle ':completion:*:kill:*' command 'ps xf -u $USER -o pid,%cpu,tty,cputime,cmd'
  zstyle ':completion:*:kill:*' insert-ids single
  zstyle ':completion:*:*:kill:*' menu yes select
  zstyle ':completion:*:kill:*' force-list always
  
  # less: extensive menu
  zstyle ':completion:*:*:less:*' menu yes select


#
# Keybindings.
#
 
  # vi keybinding
  bindkey -v 
  
  # navigation in completion menu 
  bindkey -M menuselect 'h' vi-backward-char      
  bindkey -M menuselect 'j' vi-down-line-or-history
  bindkey -M menuselect 'k' vi-up-line-or-history  
  bindkey -M menuselect 'l' vi-forward-char         
  
  # keep menu for further completion
  bindkey -M menuselect 'i' accept-and-menu-complete
  
  # show further possible completions
  bindkey -M menuselect 'o' accept-and-infer-next-history

#
# umask
#

umask 027

#. /etc/zsh_command_notfound
