#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

export DENO_INSTALL="/home/miguel/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"
uwufetch

alias logusage="sudo journalctl --disk-usage"
alias logclean="sudo rm -rf /var/run/log && rm -rf /run/log && rm -rf /run/systemd/journal"

alias dev="cd /home/miguel/Documents/Projects/frontendmentor/audiophile-ecommerce"
alias rundev="npm run dev & firefox --private 'localhost:3000' --new-window && fg"
alias rundevInspect="npm run devInspect & firefox --private 'localhost:3000' --new-window && fg"
alias killdev="kill -9 (lsof -i tcp:3000)[0]"

alias rmcache="sudo rm -rf /var/cache/ && rm -rf /home/miguel/.cache/"

alias jcompdir="javac -d . $1"
alias jrmcomp="find . -name "*.class" -print | xargs rm"

export NODE_OPTIONS=--max-old-space-size=400
. "$HOME/.cargo/env"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
