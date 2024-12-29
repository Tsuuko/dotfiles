# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk


zinit ice depth=1; zinit light romkatv/powerlevel10k

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh



# PATH
typeset -U path
path+=(
  "/mnt/c/Windows/System32/Wbem"
  "/mnt/c/Windows/System32/WindowsPowerShell/v1.0/"
  "/mnt/c/WINDOWS/system32"
  "/mnt/c/WINDOWS"
  "/mnt/c/WINDOWS/System32/WindowsPowerShell/v1.0/"
  "/mnt/c/Users/Tsuuko/AppData/Local/Programs/Microsoft VS Code/bin"
  "/mnt/c/Windows/System32/OpenSSH/"
)



###############
# ヒストリ関連
###############
# 履歴ファイルの保存先
export HISTFILE=${HOME}/.zsh-history
# メモリに保存される履歴の件数
export HISTSIZE=1000
# 履歴ファイルに保存される履歴の件数
export SAVEHIST=100000

## コマンドラインの先頭がスペースで始まる場合ヒストリに追加しない
setopt hist_ignore_space
## history (fc -l) コマンドをヒストリリストから取り除く。
setopt hist_no_store
## 直前と同じコマンドをヒストリに追加しない
setopt hist_ignore_dups
## ヒストリを呼び出してから実行する間に一旦編集
setopt hist_verify
## zsh の開始, 終了時刻をヒストリファイルに書き込む
setopt extended_history
## 余分な空白は詰めて記録
setopt hist_reduce_blanks
## 古いコマンドと同じものは無視
setopt hist_save_no_dups
## ヒストリに追加されるコマンド行が古いものと同じなら古いものを削除
setopt hist_ignore_all_dups
## 補完時にヒストリを自動的に展開
setopt hist_expand

## Screenでのコマンド共有用
## シェルを横断して.zshhistoryに記録
setopt inc_append_history
## ヒストリを共有
setopt share_history


###################
# ディレクトリ変更
###################
## ディレクトリ名だけで cd
setopt auto_cd
## cd 時に自動で push
setopt auto_pushd
## 同じディレクトリを pushd しない
setopt pushd_ignore_dups

############
# 補間関連
############
## 補完機能の有効
# autoload -U compinit
# compinit

# cygwinでのエラー回避
# zsh compinit: insecure directories, run compaudit for list.
# http://d.hatena.ne.jp/ywatase/20071103
autoload -Uz compinit
compinit -u

## TAB で順に補完候補を切り替える
setopt auto_menu
## サスペンド中のプロセスと同じコマンド名を実行した場合はリジューム
setopt auto_resume
## 補完候補を一覧表示
setopt auto_list
## カッコの対応などを自動的に補完
setopt auto_param_keys
## ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt auto_param_slash
## 補完候補のカーソル選択を有効に
zstyle ':completion:*:default' menu select=1
## 補完候補の色づけ
eval `dircolors`
export ZLS_COLORS=$LS_COLORS
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
## 補完候補一覧でファイルの種別をマーク表示
setopt list_types
## 補完候補を詰めて表示
setopt list_packed

#########
# グロブ
#########
## 拡張グロブを使用
## ファイル名で #, ~, ^ の 3 文字を正規表現として扱う
setopt extended_glob
## =command を command のパス名に展開する
setopt equals
## --prefix=/usr などの = 以降も補完
setopt magic_equal_subst
## ファイル名の展開で辞書順ではなく数値的にソート
setopt numeric_glob_sort

##########
# 入出力
##########
## 出力時8ビットを通す
setopt print_eight_bit
## スペルチェック。間違うと訂正してくれる
setopt correct
## 出力の文字列末尾に改行コードが無い場合でも表示
unsetopt promptcr
## {a-c} を a b c に展開する機能を使えるようにする
setopt brace_ccl
## Ctrl+S/Ctrl+Q によるフロー制御を使わないようにする
setopt NO_flow_control
## コマンドラインでも # 以降をコメントと見なす
setopt interactive_comments
## ファイル名の展開でディレクトリにマッチした場合末尾に / を付加する
setopt mark_dirs
## 最後のスラッシュを自動的に削除しない
setopt noautoremoveslash

##################
# プロンプト関連
##################
# 色有効
# autoload -U colors
# ## 色を使う
# setopt prompt_subst

# # 色を定義
# local GREEN=$'%{\e[1;32m%}'
# local ORANGE=$'%{\e[1;33m%}'
# local DEFAULT=$'%{\e[1;m%}'

# if [ "$EMACS" ];then
#     PROMPT='[%n]%# '
#     # Emacs の shell では右プロンプトを表示しない
#     RPROMPT=""
# else
#     PROMPT=$ORANGE'[%n]%# '$WHITE

#     # 右側のプロンプト。ここでカレントディレクトリを出す。
#     RPROMPT=$DEFAULT'[%~]'$WHITE
#     setopt transient_rprompt
# fi
##############
# ジョブ制御
##############
## 内部コマンド jobs の出力をデフォルトで jobs -l にする
setopt long_list_jobs


#################
# その他・未分類
#################
## コアダンプサイズを制限
# limit coredumpsize 102400

## ビープを鳴らさない
setopt nobeep

###############
# Environment
###############
export LANG=ja_JP.UTF-8


###############
# alias
###############
alias ls='ls --color=auto'
alias ll='ls -l --color=auto'
alias la='ls -al --color=auto'


###############
# Plugins
###############

# zsh-fzf-history-search
# https://github.com/joshskidmore/zsh-fzf-history-search
zinit ice wait'!0'; zinit light joshskidmore/zsh-fzf-history-search
ZSH_FZF_HISTORY_SEARCH_REMOVE_DUPLICATES="DATE_INSEARCH"
ZSH_FZF_HISTORY_SEARCH_DATES_IN_SEARCH="0"
ZSH_FZF_HISTORY_SEARCH_EVENT_NUMBERS="0"
ZSH_FZF_HISTORY_SEARCH_END_OF_LINE="1"

zinit ice wait'!0'; zinit light olets/zsh-abbr
zinit ice wait'!0'; zinit light zsh-users/zsh-syntax-highlighting
zinit ice wait'!0'; zinit light zsh-users/zsh-autosuggestions
zinit ice wait'!0'; zinit light wfxr/forgit
zinit ice wait'!0'; zinit light hlissner/zsh-autopair
