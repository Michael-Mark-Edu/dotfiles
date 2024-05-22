# oh-my-zsh (somewhat) default configs
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="agnoster"
zstyle ':omz:update' mode reminder
plugins=(git)
source $ZSH/oh-my-zsh.sh
prompt_context() {} # This gets rid of username next to command entry

# System-specific configuration that is not saved in the repository
. "$HOME/.zshrc_local"

source ~/.zsh/catppuccin_mocha-zsh-syntax-highlighting.zsh
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
