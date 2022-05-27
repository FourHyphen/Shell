#! /bin/bash -
#
############################################################
# P207 ～ P240 複数ホストでパッケージを並列ビルドするスクリプトの解説
# 
# - 動作
#   - 環境変数として指定されたパスに対して、ファイル名 or これを表すパターンを使って探索
#   - 指定なし
#     - 最初に発見したファイル名の完全なパス名を標準出力に出力
#     - ファイルがなければ標準エラー出力にメッセージ出力
# - return
#   - 見つからなかったファイルの個数
# - usage
#   - `pathfind [--all] [--?] [--help] [--version] envvar pattern(s)`
# - 例
#   - ```
#     $ pathfind -a PATH ls
#     /usr/bin/ls
#     /bin/ls
#     $ pathfind PATH '?sh'
#     /usr/bin/rsh
# - 出所
#   - 詳解シェルスクリプト chapter 8

# IFS書き換え攻撃への対策
IFS=' 	
'

# 信頼できる場所に置かれたプログラムのみ実行するための処置
OLDPATH="$PATH"
PATH=/bin:/usr/bin
export PATH

usage() {
    echo "usage: $PROGRAM [--all] [--?] [--help] [--version] envvar pattern(s)"
}

usage_and_exit() {
    usage
    exit $1
}

version() {
    echo "$PROGRAM version $VERSION"
}

warning() {
    echo "$@" 1>&2
    EXITCODE=`expr $EXITCODE + 1`    # = EXITCODE=$((EXITCODE + 1))
}

error() {
    echo "$@" 1>&2      # 引数を標準エラー出力に出力
    usage_and_exit 1
}

# 命名慣例: 1関数やメインのみ使用 -> 小文字 / PG 全体で使用 -> 大文字
all=no
envvar=
EXITCODE=0
PROGRAM='basename $0'    # 完全なパス名からファイル名を取り出す
VERSION=1.0

# 引数の残り個数 > 0 なら続行
while test $# -gt 0
do
    case $1 in
        --all | --al | --a | -all | -al | -a )
            all=yes
            ;;
        --help | --hel | --he | --h | '--?' | -help | -hel | -he | -h | '-?' )
            usage_and_exit 0
            ;;
        --version | --v | -version | -v )
            version
            exit 0
            ;;
        -*)
            error "wrong option: $1"
            ;;
        *)
            break
            ;;
    esac

    # 先頭の引数を捨てて $n の番号を左にずらす(これにより while で全引数を処理する)
    shift
done

# 引数には変数の名前と探索ファイル名が残っている
envvar="$1"    # 環境変数名(PATH とか SHELL とか)
test $# -gt 0 && shift

# この時点で残りの引数には探索ファイル名があるが、ファイル名にスペースを含む場合の対応のため file="$@" とはしない

# 環境変数が PATH だった場合はもともとの値を使用
# (頭に x(慣例) を書くことで、先頭が - の場合にコマンドの引数と解釈されることを防ぐ)
test "x$envvar" = "xPATH" && envvar=OLDPATH

# 環境変数名を変数として解釈して展開、":" を " " に変換、エラー出力は不要なので /dev/null 行き
dirpath=`eval echo '${'"$envvar"'}' 2>/dev/null | tr : ' ' `

# 入力値のチェック
if [ -z "$envvar" ] ; then
    error 環境変数が存在しないか、値が空です
elif [ "x$dirpath" = "x$envvar" ] ; then
    error "shプログラムが正しく機能していません。$envvar を展開できません"
elif [ -z "$dirpath" ] ; then
    error 探索パスが空です
elif [ $# -eq 0 ] ; then
    exit 0
fi

for pattern in "$@"
do
    result=
    for dir in $dirpath
    do
        for file in $dir/$pattern
        do
            if [ -f "$file" ] ; then
                result="$file"
                echo $result
                [ "$all" = "no" ] && break 2
            fi
        done
    done

    [ -z "$result" ] && warning "$pattern: 見つかりません"
done

# ユーザープログラムは 0 ~ 125 までを返してよいので 126 以上を 125 にする
[ $EXITCODE -gt 125 ] && EXITCODE=125

exit $EXITCODE

