#! /bin/bash -

############################################################
# grep: ファイルから行をヒットさせる
# 通常は BRE 正規表現エンジン / -E で ERE 正規表現エンジンモード
# -E の方が他言語での正規表現文字列と同じように書けそう
#   -i : 大文字小文字を区別しない
#   -e : 検索パターン, "" でくくること
#   -f : 検索パターンをファイルから読む
#   -l : マッチした行ではなく、マッチした行を含むファイルを表示
#   -q : マッチした/しなかったのステータスだけ返す、何も表示しない
#   -v : マッチしなかった行を出力
#
# BRE エンジン
echo "##### grep ##############################"
cat re_test.txt | grep -e "\(why\).*\1"       # 後方参照は有効
echo "----"
cat re_test.txt | grep -e "\(why\).+\1"       # + が無効、何もマッチしない
echo "----"
cat re_test.txt | grep -e "b\{5\}"            # 出現回数の制約は有効
echo "----"
cat re_test.txt | grep -e '^w.*y$'            # 行頭^ は有効、行末$ は働かない？

# ERE
echo "========"
cat re_test.txt | grep -E -e "(why).*\1"      # 後方参照はこれでできてる
echo "========"
cat re_test.txt | grep -E -e "why.*a+"        # + は有効
echo "========"
cat re_test.txt | grep -E -e '^w.*y$'         # 行頭^ は有効、行末$ は働かない？
echo "========"
cat re_test.txt | grep -E -e 't[[:alpha:]]*y' # アルファベットにマッチ？

############################################################
# head / tail
echo "##### head / tail ##############################"
head -n 3 re_test.txt
echo "----"
tail -n 3 re_test.txt

############################################################
# dd : データコピー
echo "##### dd ##############################"
cat re_test.txt | dd bs=10

############################################################
# file : ファイルの形式や文字コードの推測
echo "##### file ##############################"
file re_test.txt    # re_test.txt: ASCII text, with CRLF line terminators

############################################################
# find : 強力なファイル検索
# find ./ -type f -print | xargs grep "tmp"
#   -name 'pattern' : ワイルドカード検索(シェルに解釈させないよう''括り)
#   -type           : 検索対象ファイル種類の指定、d=ディレクトリ / f=file
#   -prune          : 再帰探索しない
#   -print          : かつてはこれ指定しないと出力されなかった


############################################################
# xargs : 標準入力から空白 or 改行区切りの引数のリストを受け取る
#         それらを指定されたコマンドに渡す
# find ./ -type f | xargs grep "aaaaa" = grep "aaaaa" $(find ./ -type f)


############################################################
# basename / dirname
echo "##### basename / dirname ##############################"
tmp="$0"
now_dir="$(cd $(dirname $tmp); pwd)"
script_full_path=$(echo $tmp | sed "s;./;$now_dir/;g")
echo "\$0              : $0"
echo "./              : $now_dir"
echo "script_full_path: $script_full_path"
echo "basename        : $(basename $script_full_path)"
echo "dirname         : $(dirname $script_full_path)"


############################################################
# ls
#   -1 : 1 行に 1 つずつ出力(数字の1)
#   -r : 通常とは逆順に表示
#   -R : サブディレクトリも再帰探索
#   -t : 最終更新日時でソート
#   .* : 隠しファイルにマッチ
echo "##### ls ##############################"
ls -1 | od -a -b     # 8進表示
ls .*    # 隠しファイルにマッチさせる

############################################################
# touch : ファイルの最終更新日時を更新
echo "##### touch ##############################"
touch "./command.sh"
# touch "./empty_file"    # 空ファイルの作成に使われる / ロックを示すファイル等、ファイルの有無と更新日時だけが重要な場合

############################################################
# df : ファイルシステムの利用状況出力
#   -k: KB 表示
#   -h: 簡略表示(GB単位ならこっちの方が見やすいかも)
echo "##### df ##############################"
df

############################################################
# du : ディレクトリのディスク利用状況出力
# あるディレクトリ以下の利用状況出力例(これはMB単位で使ってるもの限定)
# du -h /mnt/c/ | grep -E '^[^0][0-9]*M' | sort

############################################################
# iconv : 汎用の文字コード変換ツール

############################################################
# cmp : ファイル比較

############################################################
# diff : ファイル比較
# patch : diff の結果から片方のファイルを復元する(パッチ適用)
# echo "##### diff / patch ##############################"
# diff -c re_test.txt re_test2.txt > diff.dif
# patch < diff.dif
# cat re_test.txt

############################################################
# strings : ファイル内の印刷可能文字を標準出力に出力 / バイナリデータの探索に便利らしい

############################################################
# pr : ファイルを印刷に適した形式に加工して標準出力に出力
# echo "##### pr ##############################"
# cat re_test.txt | pr

