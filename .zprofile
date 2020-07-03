# echo is like puts for bash (bash is the program running in your terminal)
echo -e "\nO brave new world that has such people in it. Let's start at once.\n" 

# $VARIABLE will render before the rest of the command is executed
echo -e "Loading ~/.zprofile."
echo -e "You are logged in as $USER at $(hostname)\n"

# Path changes are made non-destructive with PATH=new_path;$PATH
# This is like A=A+B so we preserve the old path. In cases where
# we prepend path, it adds it to the end.

# Path order matters, putting /usr/local/bin before /usr/bin
# ensures brew programs will be seen and used before another program
# of the same name is called

# Path for brew
test -d /usr/local/bin && export PATH="/usr/local/bin:/usr/local/sbin:~/bin:$PATH"
# Path for Heroku
test -d /usr/local/heroku/ && export PATH="$PATH:/usr/local/heroku/bin"
# Rbenv autocomplete and shims
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
# $(rbenv init -) adds the shim directory at the beginning of your PATH (https://github.com/rbenv/rbenv#understanding-shims)
# Path for RBENV
test -d "$HOME/.rbenv/" && PATH="$PATH:$HOME/.rbenv/bin"

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# pyenv enable shims and autocompletion
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# Set code as the default editor
export EDITOR="code --wait"

# Useful aliases
alias be="bundle exec"
alias chrome="open -a 'Google Chrome'"
alias safe='open -a Google\ Chrome --args --unsafely-treat-insecure-origin-as-secure="http://395-cnd4234brj.kaplaninc.com" --user-data-dir=/Users/andre/test'
alias cred="rails credentials:edit"
alias mobile-server="rails s -b 192.168.0.5"
alias ip="ipconfig getifaddr en0"
alias pg_start="launchctl load ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist"
alias pg_stop="launchctl unload ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist"
alias bcd="git difftool --dir-diff HEAD"
alias ls='ls -Ghalp'

echo -e "Aliases:"
echo -e ""
echo -e "be = bundle exec"
echo -e "chrome = open -a 'Google Chrome'"
echo -e "cred = rails credentials:edit"
echo -e "mobile-server = rails s -b 192.168.0.5"
echo -e "ip = ipconfig getifaddr en0"
echo -e "pg_start = start postgres"
echo -e "pg_stop = stop postgres"
echo -e "bcd = git difftool --dir-diff HEAD"
echo -e "ls = 'ls -Ghalp'"
echo -e ""

# If there is a bashrc file, execute it.
if [ -f ~/.zshrc ]; then . ~/.zshrc; fi

# start in nigeria-prs repo
cd Desktop/work/nigeria-prs