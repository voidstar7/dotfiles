source /opt/homebrew/opt/chruby/share/chruby/chruby.sh
source /opt/homebrew/opt/chruby/share/chruby/auto.sh
chruby ruby-3.3.5 # run chruby to see actual version

# aliases
alias nv="nvim"
alias tt="taskwarrior-tui"
alias ti="timew"
alias tp="toggle_prompt"

# terminal colors 
# https://geoff.greer.fm/lscolors/
export CLICOLOR=1
#export LSCOLORS=ExFxCxDxaxExExAxAxAxXx
export LSCOLORS=Exfxcxdxbxegedabagacad

# prompt
# https://gist.github.com/reinvanoyen/05bcfe95ca9cb5041a4eafd29309ff29
function parse_git_branch() {
    git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/ [\1]/p'
}
setopt PROMPT_SUBST
export PROMPT='%B%F{4}%~%f$(parse_git_branch) ❯%b '
function parse_git_branch() {
    git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/ [\1]/p'
}
setopt PROMPT_SUBST
export PROMPT='%B%F{4}%~%f$(parse_git_branch) ❯%b '

# Define a variable to keep track of the prompt state
PROMPT_STATE="default"

# Function to toggle the prompt
toggle_prompt() {
  if [ "$PROMPT_STATE" = "default" ]; then
    export PROMPT='❯ '
    PROMPT_STATE="custom"
  else
		export PROMPT='%B%F{4}%~%f$(parse_git_branch) ❯%b '
    PROMPT_STATE="default"
  fi
}

# keybinds
bindkey '^k' fzf-history-widget
#bindkey '^h' clear-screen

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# ignores ctrl-d which closes terminal
setopt ignoreeof
