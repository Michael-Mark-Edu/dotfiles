eval "$(oh-my-posh init zsh --config ~/.themes/p10k.toml)"
alias ls="ls --color=auto"

GPG_TTY=$(tty)
export GPG_TTY

if [[ $XDG_SESSION_TYPE == x11 ]] then
    xinput set-prop $(xinput | awk '$5 == "Touchpad" {print substr($6, 4)}') 346 1
fi

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
