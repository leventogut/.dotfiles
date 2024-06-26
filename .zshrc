################ Global non-sensitive env variables
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export ZSH="$HOME/.oh-my-zsh"
export GPG_TTY=$(tty)
export DOCKER_BUILDKIT=1
export UPDATE_ZSH_DAYS=1
export GOPATH=~/dev/go
export HOMEBREW_NO_ENV_HINTS=true
############################################################################### Paths
export PATH="$GOPATH/bin:/usr/local/go/bin:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.bin:$PATH"
export PATH="$HOME/.pulumi/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.asdf/bin:$PATH"
export PATH="$HOME/.arkade/bin/:$PATH"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

if [[ "$OSTYPE" == "darwin"* ]]; then
  export PATH="/Applications/Sublime Text.app/Contents/SharedSupport/bin:$PATH"
  export PATH="/opt/homebrew/opt/curl/bin:$PATH"
  export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
  export PATH="$HOME/Library/Python/3.9/bin:$PATH"
fi
############################################################################### ZSH Configuration
export ZSH_THEME="agnoster"
export DISABLE_UPDATE_PROMPT="true"
export ENABLE_CORRECTION="false"
export COMPLETION_WAITING_DOTS="true"
export DISABLE_UNTRACKED_FILES_DIRTY="true"
export HIST_STAMPS="yyyy-mm-dd"
############################################################################### ZSH plugins
plugins=(
  sudo
  common-aliases
  colorize
  copybuffer
  dotenv
  git
  direnv
  fzf
  autojump
  command-not-found
  zsh-autosuggestions
)
############################################################################### Editor
# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi
############################################################################### ssh-agent
# SSH Agent
if [ ! -f "$SSH_AUTH_SOCK" ]; then
  eval "$(ssh-agent)"
  ssh-add
  ssh-add -l
fi
############################################################################### Functions
listening() {
  if [ $# -eq 0 ]; then
    sudo lsof -iTCP -sTCP:LISTEN -n -P
  elif [ $# -eq 1 ]; then
    sudo lsof -iTCP -sTCP:LISTEN -n -P | grep -i --color "$1"
  else
    echo "Usage: listening [pattern]"
  fi
}

############################################################################### Source statetments
#
if [ -f "$HOME/$ZSH/oh-my-zsh.sh" ]; then . "$HOME/$ZSH/oh-my-zsh.sh"; fi
if [ -f "$HOME/.aliases" ]; then . "$HOME/.aliases"; fi
if [ -f "$HOME/.kubectl_aliases" ]; then . "$HOME/.kubectl_aliases"; fi
if [ -f "$HOME/.asdf/asdf.sh" ]; then . "$HOME/.asdf/asdf.sh"; fi

if [ "$(command -v kube_ps1)" ]; then PS1="$(kube_ps1)"$PS1; fi
if [ "$(command -v direnv)" ]; then eval "$(direnv hook zsh)"; fi

if [[ "$OSTYPE" == "darwin"* ]]; then
  if [ "$(command -v brew)" ]; then eval "$(/opt/homebrew/bin/brew shellenv)"; fi
fi

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  if [ "$(command -v brew)" ]; then eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"; fi
fi
if [ "$(command -v starship)" ]; then eval "$(starship init zsh)"; fi # Starship prompt: https://starship.rs/
