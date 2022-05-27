#! /bin/bash -

############################################################
# 環境
# echo $PATH
# echo $LANG    # C.UTF-8
echo $LC_ALL
# find ./ | LC_ALL=C sort    # ロケールに基づいて sort されるため、環境の差異をなくす

# set -x : トレース = 実行コマンドも合わせて表示
# set +x : トレースの解除
set -x
echo test    # + echo test と test が表示される
set +x       # + set +x が表示される

# shopt: [bash 専用] set の他のオプション設定方法

# export: 環境に変数を追加したり上書き
# export PATH    # 環境値を設定

# export -p : 環境変数値を表示
# declare -x HOME="/home/nf"
# declare -x HOSTTYPE="x86_64"
# declare -x LANG="C.UTF-8"
export -p | head -n 3

# env: 環境内の変数の削除とか一時的な値のセット

echo ${0}    # ./command.sh    # シェルのプログラム名
echo $$      # プロセスID

############################################################
# bash の挙動
# ファイルへの登録
# .profile : ログイン時に毎回実行される

# echo $0    # ログインシェルの確認、ssh 等で別ホストにコマンド実行させる場合はログインシェル以外のが動くこともある
# ログインシェルとして bash が起動された場合の処理
# [ -r /etc/profile ] && . /etc/profile
# if [ -r $HOME/.bash_profile ] ; then
#     . $HOME/.bash_profile
# elif [ -r $HOME/.bash_login ] ; then
#     . $HOME/.bash_login
# elif [ -r $HOME/.profile ] ; then
#     . $HOME/.profile
# fi

if [ -r $HOME/.bash_profile ] ; then
    echo "exist: $HOME/.bash_profile"
fi
if [ -r $HOME/.bash_login ] ; then
    echo "exist: $HOME/.bash_login"
fi
if [ -r $HOME/.profile ] ; then
    echo "exist: $HOME/.profile"
fi

# ログインシェルとして bash が起動された場合の終了時処理
# [ -r $HOME/.bash_logout ] && . $HOME/.bash_logout

# ログインシェルではない場合に読まれる bash 初期設定ファイル
# (この場合 上記ログイン用のは読まれない)
# [ -r $HOME/.bashrc ] && . $HOME/.bashrc

# 対話的でないシェルとして bash が起動されている場合に読まれるファイル
# (この場合 上記のログイン用や .bashrc は読まれない)
# [ -r "$BASH_ENV" ] && . "$BASH_ENV"

############################################################
# type : PATH 環境変数の中からコマンドの格納場所を調べる
type docker    # docker is /usr/bin/docker
