#! /bin/bash -

############################################################
# リダイレクト
#   > /dev/null : 結果の破棄
#   > /dev/tty  : 結果の実際の端末へのリダイレクト
echo "##### redirect ##############################"
# read pass < /dev/tty
# ここでユーザー入力
# echo $pass    # ユーザー入力結果が入る

# make 1> results.txt 2> err.txt    # make の標準出力は results.txt に、エラーは err.txt に出力
# make > results.txt 2>&1    # make の標準出力と標準エラー出力を results.txt に出力

# echo "##### exec ##############################"
# exec 2> ./$0_error.log    # 標準エラー出力の書き出し先を変更
# exec ls -l    # 同じプロセスで別処理を起動

# echo "##### set -C ##############################"
# set -C    # > での上書き禁止( >> での追記はできる)
# # line 22: re_test.txt: cannot overwrite existing file
# echo "no_clobber" > re_test.txt

echo "##### here document ##############################"
# ヒアドキュメント
cat <<- EOF
test_test
EOF

# 変数に入れるには
tmp=$(cat <<- EOF
test_test
EOF
)
echo "$tmp"
