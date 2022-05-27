#! /bin/bash -

############################################################
# 変数(文字列)
echo "##### var(str) ##############################"
tmp=10
echo $tmp
echo ${tmp}    # 基本こっちが良い(変数名の区切りがはっきりする)

# 変数が存在する/しない場合
echo "----"
echo ${tmp:-100}          # 10
echo ${not_exist:-100}    # 100

# ${tmp:=20}

# 変数が存在しない場合に終了させる
# ${not_exist:?"undefined!"}

echo "----"
tmp_path="/home/tolstoy/mem/long.file.name"
#                        # /home/tolstoy/mem/long.file.name
echo "${tmp_path#/*/}"     #       tolstoy/mem/long.file.name
echo "${tmp_path##/*/}"    #                   long.file.name
echo "${tmp_path%.*}"      # /home/tolstoy/mem/long.file
echo "${tmp_path%%.*}"     # /home/tolstoy/mem/long
echo "${#tmp_path}"        # 32 (= 文字数)

# 変数を readonly にできる
echo "----"
readonly read_only_str="read_only"
read_only_str="error?"    # ./command.sh: line 198: read_only_str: readonly variable 
echo "${read_only_str}"   # read_only

############################################################
# 変数(数値)
echo "##### var(num) ##############################"
tmp=10
# tmp2=$((tmp + 1))    # これでいける
# echo ${tmp2}         # 11

# # bash や ksh なら
# let "tmp2 = tmp + 5"
# echo "${tmp2}"    # 15
# ((tmp2 = tmp + 10))
# echo "${tmp2}"    # 20
$((tmp++)) 2> /dev/null    # 10: command not found になるが計算はできる
echo "${tmp}"

############################################################
# 配列
echo "##### array ##############################"
array=(aaa bbb ccc)
# echo "$array[0]"      # 間違い、"aaa[0]" となった
echo "${array[1]}"    # 正解、"bbb"
echo "${array[3]}"    # 特にエラーはしない、何もない扱いとなった
array[10]=zzz
echo "${array[*]}"    # 配列の全要素を半角スペース区切りで出力、添え字 2 ～ 9 は存在しない！
echo "${#array[*]}"   # 配列の要素数 = 4
