# echo is like puts for bash (bash is the program running in your terminal)
echo -e "\nO brave new world that has such people in it. Let's start at once.\n" 

# $VARIABLE will render before the rest of the command is executed
echo -e "Loading ~/.bash_profile."
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

# Load git completions
git_completion_script=/usr/local/etc/bash_completion.d/git-completion.bash
test -s $git_completion_script && source $git_completion_script

# A more colorful prompt
# \[\e[0m\] resets the color to default color
c_reset='\[\e[0m\]'
#  \e[0;31m\ sets the color to red
c_path='\[\e[0;31m\]'
# \e[0;32m\ sets the color to green
c_git_clean='\[\e[0;32m\]'
# \e[0;31m\ sets the color to red
c_git_dirty='\[\e[0;31m\]'

# PS1 is the variable for the prompt you see everytime you hit enter
if [ $OSTYPE == 'darwin15' ] && ! [ $ITERM_SESSION_ID ]
then
  PROMPT_COMMAND=$PROMPT_COMMAND'; PS1="${c_path}\W${c_reset}$(git_prompt) :> "'
else
  PROMPT_COMMAND=$PROMPT_COMMAND' PS1="${c_path}\W${c_reset}$(git_prompt) :> "'
fi

# determines if the git branch you are on is clean or dirty
git_prompt ()
{
  # Is this a git directory?
  if ! git rev-parse --git-dir > /dev/null 2>&1; then
    return 0
  fi
  # Grab working branch name
  git_branch=$(git branch 2>/dev/null| sed -n '/^\*/s/^\* //p')
  # Clean or dirty branch
  if git diff --quiet 2>/dev/null >&2; then
    git_color="${c_git_clean}"
  else
    git_color=${c_git_dirty}
  fi
  echo " [$git_color$git_branch${c_reset}]"
}

# Colors ls should use for folders, files, symlinks etc, see `man ls` and
# search for LSCOLORS
export LSCOLORS=ExGxFxdxCxDxDxaccxaeex

# Force grep to always use the color option and show line numbers
export GREP_OPTIONS='--color=always'

# Set code as the default editor
which -s code && export EDITOR="code --wait"

# Useful aliases

# Force ls to use colors (G) and use humanized file sizes (h)
alias ls='ls -Ghalp'

alias e="code"
alias be="bundle exec"
alias chrome="open -a 'Google Chrome'"
alias safe='open -a Google\ Chrome --args --unsafely-treat-insecure-origin-as-secure="http://395-cnd4234brj.kaplaninc.com" --user-data-dir=/Users/andre/test'
alias cred="rails credentials:edit"
alias mobile-server="rails s -b 192.168.0.5"
alias ip="ipconfig getifaddr en0"

echo -e "Aliases:"
echo -e ""
echo -e "e = code"
echo -e "be = bundle exec"
echo -e "chrome = open -a 'Google Chrome'"
echo -e "cred = rails credentials:edit"
echo -e "mobile-server = rails s -b 192.168.0.5"
echo -e "ip = ipconfig getifaddr en0"
echo -e ""

# If there is a bashrc file, execute it.
if [ -f ~/.bashrc ]; then . ~/.bashrc; fi

cd rails/big_dumb_web_dev