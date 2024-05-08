# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi


export SHELL=/bin/zsh
# export PATH=$HOME/bin:$PATH
exec /bin/zsh -l

# User specific environment and startup programs
. "$HOME/.cargo/env"
