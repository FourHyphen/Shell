#! /bin/bash -

############################################################
# stty: 端末の設定変更
#   stty -echo : 入力された文字の自動 echo の防止

############################################################
# less : ページャー / 1画面ごとに区切って表示

############################################################
# select : [bash 専用] 対話型のメニューに便利
echo "##### select ##############################"
PS3="select...  "
# select を途中で抜けるには Ctrl + d
select term in aaa bbb ccc ddd
do
    if [ -n "$term" ] ; then
        echo "selected $term"
        break
    else
        echo "wrong"
    fi
done

