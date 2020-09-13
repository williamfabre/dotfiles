# vim:ts=4:sw=4:ai:foldmethod=marker:foldlevel=0:
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="ys"
#ZSH_THEME="typewritten"
ZSH_THEME="avit"

HIST_STAMPS="yyyy-mm-dd" # All hail ISO 8601
export HISTTIMEFORMAT="%y-%m-%d %T "

plugins=(
	z
	git
	sudo
	battery
	aws
	poetry
	shell-aws-autoprofile
	zsh-autosuggestions
	zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

export PRIV_KEY_WITH_PASSPHRASE="$HOME/.ssh/PUT_SSH_KEY_HERE"

export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"

## PATH EXPORTS
export PATH="/usr/lib/postgresql/11/bin:$PATH"

export PATH="$HOME/.pyenv/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$HOME/.plenv/bin:$PATH"
export PATH="$HOME/.jenv/bin:$PATH"

export PATH="$HOME/.poetry/bin:$PATH"
export PATH=$(go env GOPATH)/bin:$PATH

## ALIASES LOADING
if [ -f "$HOME/.zsh_aliases" ]; then
	source "$HOME/.zsh_aliases"
fi

## MISC GLOBAL VARS
export EDITOR='vim'
export TERM='xterm-256color' # Necessary when through SSH
export GPG_TTY=$(tty)
if command -v brew 2>&1 >/dev/null; then
	export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
	export HOMEBREW_CASK_OPTS=--require-sha
	# Disable auto update auto update completely when set to 1
	export HOMEBREW_NO_AUTO_UPDATE=0
	# Time before autoupdate, default:60 sec
	export HOMEBREW_AUTO_UPDATE_SECS=259200 # = 3*24*3600 = 3 days
fi
## MISC PROGS EVALS
if command -v tilix 2>&1 >/dev/null && [ $TILIX_ID ] || [ $VTE_VERSION ]; then
	# https://gnunn1.github.io/tilix-web/manual/vteconfig/
	source /etc/profile.d/vte.sh
fi
if command -v thefuck 2>&1 >/dev/null; then
	eval $(thefuck --alias)
fi
# This *is* the nicest interface for managing scripting languages
if command -v pyenv 2>&1 >/dev/null; then
	export PYENV_ROOT="$HOME/.pyenv"
	eval "$(pyenv init - zsh)"
fi
if command -v rbenv 2>&1 >/dev/null; then
	eval "$(rbenv init - zsh)"
fi
if command -v plenv 2>&1 >/dev/null; then
	eval "$(plenv init - zsh)"
fi
if command -v jenv 2>&1 >/dev/null; then
	export JENV_ROOT="/usr/local/opt/jenv"
	eval "$(jenv init - zsh)"
fi
## MISC GLOBAL VARS (post evals)

# Adds the currently used python exec's sitepackage path to the PYTHONPATH, necessarry for jedi-vim
py3_sitepackage=$(python3 -c "import site; print(site.getsitepackages()[0])")
if [ -d $py3_sitepackage ]; then
	export PYTHONPATH="$py3_sitepackage:$PYTHONPATH"
fi
if command -v /usr/libexec/java_home 2>&1 >/dev/null; then
	current_java_version=$(java -version 2>&1 | gsed -E '1!d; s/.*"(.*)"$/\1/g')
	export JAVA_HOME=$(/usr/libexec/java_home -v $current_java_version)
fi
if command -v aws 2>&1 >/dev/null; then
	export AWS_TEST_PROFILE="edfx-poc-euw1"
	export SAM_CLI_TELEMETRY=0
fi

## MOTD LOADING
if [ -f "$HOME/.zsh_motd" ]; then
	bash "$HOME/.zsh_motd"
fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/opt/google-cloud-sdk/path.zsh.inc' ]; then . '/opt/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/opt/google-cloud-sdk/completion.zsh.inc' ]; then . '/opt/google-cloud-sdk/completion.zsh.inc'; fi
