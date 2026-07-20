# /etc/skel/.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !
if [[ -z "$TMUX" ]] && [[ -n "$SSH_TTY" ]]; then
    exec tmux new-session -A -s work@y470
fi

# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

source /usr/share/bash-completion/completions/fzf
source /usr/share/fzf/key-bindings.bash
# Put your fun stuff here.
#
#
#
# 基础 ls 替代：自动颜色 + 图标
alias ls='eza -lg --smart-group --icons --color=auto --group-directories-first'

# 长列表，显示几乎所有文件，人类可读大小，按修改时间由新到旧
alias ll='eza -lhag --smart-group --icons --group-directories-first --sort=modified --reverse --time-style=long-iso'

# 显示所有文件（包括隐藏），不显示 . 和 ..
alias la='eza -a --icons --group-directories-first'

# 单列输出，适合管道
alias l='eza -1g --smart-group --icons --group-directories-first --sort=modified --time-style=long-iso'

# 目录树（2 层）
alias tree='eza --tree --level=2 --icons --group-directories-first'

# 
# ==================== Git别名 =======================================
# 基础缩写
#" 
alias g='git'
alias gs='git status'
alias gd='git diff'
alias gds='git diff --staged'      # 查看暂存区的变更
alias ga='git add'
# alias gaa='git add --all'           # 添加所有变更
alias gc='git commit'
alias gcm='git commit -m'
alias gca='git commit --amend'      # 修改最后一次提交
#
# 日志与历史（带图形化输出）
#
#
alias gl='git log --oneline --graph --decorate --all'   # 极简版
alias gll='git log --oneline --graph --decorate --all --date=short'  # 带日期
#
#
#
# 颜色代码: lightblue：浅蓝色，柔和

# yellow：亮黄色，很清晰

# white：纯白色，百搭

# magenta：紫红色，醒目
export EZA_COLORS="da=cyan"


_doas_complete() {
    local cur prev words cword
    _init_completion || return
    COMPREPLY=($(compgen -W "$(compgen -c | sort -u)" -- "$cur"))
} &> /dev/null
complete -F _doas_complete doas

complete -cf doas

# ======================== 多终端历史记录 =====================
# 1. 设置内存中历史条目数（当前会话）和文件中历史条目数（持久化）
export HISTSIZE=100000          # 内存中保留的命令数
export HISTFILESIZE=100000      # ~/.bash_history 文件中的最大行数

# 2. 记录时间戳（便于追溯何时执行）
export HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S  "

# 3. 忽略重复命令和以空格开头的命令（可选）
export HISTCONTROL=ignoreboth   # ignorespace + ignoredups

# 4. 多个终端会话时追加而不是覆盖历史文件
shopt -s histappend

# 5. 立即将当前会话的命令追加到历史文件（而不是退出时再写）
#    这样可以防止多个会话间的丢失。
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"




# JAVA RUNTIME 参数
export JAVA_HOME=/usr/lib/jvm/jbr_jcef-25.0.3-linux-x64-b508.16
export PATH=$JAVA_HOME/bin:$PATH
eval "$(fzf --bash)"



# =========================== CVSROOT环境变量设置 ===============
export CVSROOT=/usr/local/repository
