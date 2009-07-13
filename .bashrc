export PS1="\W \$ "
export PATH=~/.bin:~/.cabal/bin:/usr/local/bin:$PATH

export GIT_EDITOR="mvim -f"
export SVN_EDITOR="mvim -f"

alias gst="git status"
alias ga="git add"
alias gc="git commit"
alias gca="git commit -a"
alias gcd="git commit -v"
alias gcad="git commit -a -v"
alias gps="git push"
alias gpl="git pull"
alias gb="git branch"
alias gco="git checkout"
alias gd="gitvimdiff"

alias pacman="pacman-color"

alias grep="grep --color"

alias apache2ctl="sudo /opt/local/apache2/bin/apachectl"
alias mysqlstart='sudo /opt/local/bin/mysqld_safe5 &'
alias mysqlstop='/opt/local/bin/mysqladmin5 -S /tmp/mysql.sock -u root shutdown'

alias iphone_convert="handbrake -Z \"iPhone & iPod Touch\""
alias update_chyrp_docs="/home/alex/Documents/Documentation/NaturalDocs/naturaldocs -ro -i /srv/http/chyrp -xi /srv/http/chyrp/modules/ -xi /srv/http/chyrp/feathers/ -xi /srv/http/chyrp/themes/ -xi /srv/http/chyrp/includes/lib/ -p /home/alex/Documents/Documentation/ChyrpProject/ -o HTML /home/alex/Documents/Documentation/ChyrpOutput/"
alias tg="ssh toogeneric.com -l root"

export BREAK_CHARS="\"#'(),;\`\\|!?[]{}"
alias rsbcl="rlwrap -b \$BREAK_CHARS sbcl"
alias sb="sbcl --script"
alias mzscheme="rlwrap -b \$BREAK_CHARS mzscheme"

if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
