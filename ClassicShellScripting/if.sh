#! /bin/bash -

############################################################
# if
echo "##### if ##############################"
if grep -E -e "not_match" re_test.txt > /dev/null
then
    echo "matching"
else
    echo "not match"    # こっち通る
fi

# 否定は ! で表現できる
if ! grep -E -e "not_match" re_test.txt > /dev/null
then
    echo "not match"    # ここ通る
fi

# セミコロン使えば then を 1 行にまとめられる
if ! grep -E -e "not_match" re_test.txt > /dev/null ; then
    echo "not match"    # ここ通る
fi

# test コマンド = [ ] での表現
## 文字列比較
tmp="aa"
tmp2="aa"
if [ "$tmp" = "$tmp2" ] ; then
    echo "equal 1"
fi

## 数値比較
tmp=10
tmp2=10
if [ $tmp -eq $tmp2 ] ; then
    echo "equal 2"
fi

## 他の表現
tmp="./command.sh"
if [ -f "$tmp" ] ; then
    echo "file"
fi

if [ -x "$tmp" ] ; then
    echo "can execute"
fi

if [ -d "./" ] ; then
    echo "directory"
fi

# if [ -d "$tmp" ]
# then
#     # nop    この書き方は中身がないのでNG
# else
#     echo "not directory 1"
# fi

if [ ! -d "$tmp" ] ; then
    echo "not directory 2"
fi

if [ -f "$tmp" ] && [ -d "./" ] ; then
    echo "and"
fi

if [ -f "./" ] ; then
    echo "not executing"
elif [ -d "./" ] ; then
    echo "elif"
fi
