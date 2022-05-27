#! /bin/bash -

############################################################
# 関数
echo "##### func ##############################"
func_test () {
    echo "$1"
    return 11
}

# result=$(func_test "call func") の書き方は不可(値が入らない)
func_test "call func"
result=$?
echo "$result"
