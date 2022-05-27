#! /bin/bash -

############################################################
# trap : 終了時に処理を仕掛ける
# 注意点: trap で仕掛けた処理実行後、exit されないなら実行中の場所に戻ってきて処理を継続する
#         なので、trap の処理実行後に終了したいなら exit する
# 参考: https://qiita.com/tamanobi/items/7fa17ac4647ee62e3c3f
echo "##### trap ##############################"
# trap -l    # trap を仕掛けられる終了ステータス一覧

func_when_error () {
    echo "func_when_error called."
    exit 1
}

clear () {
    echo "clear called."
    ls -l /not_found
}

# trap func_when_error 2    # 2 = SIGINT = Ctrl + C
# trap clear EXIT     # 正常終了したときにも仕掛けられる
# exit 1              # これでちゃんと clear が呼ばれる
# # exit 11    # ちゃんと exit 1 の時点で終了してくれる
trap "clear 2> /dev/null" EXIT    # /dev/null へのリダイレクトが効く
exit 2    # ちゃんと echo $? で 2 になる
