#! /bin/bash -

############################################################
# for / while
echo "##### for ##############################"
for line in *.txt
do
    echo "$line"    # re_test.txt
done

echo "----"
for line in $(cat /etc/passwd | head -n 3)
do
    echo "$line"
done

echo "----"
while IFS=: read -r user
do
    echo "$user"
done < /etc/passwd

echo "----"
for line in $(cat /etc/passwd | head -n 3)
do
    for_tmp=$(echo "$line" | sed -e "s;\:.*;;g")
    if [ "$for_tmp" = "daemon" ]
    then
        break
    fi

    echo "$line"
done

# bash や ksh なら
echo "----"
limit=3
for ((i = 1; i <= limit; i += 1)) ; do
    echo "${i}"
done

echo "----"
for line in $(ls) ; do
    echo "$line"
    continue
    echo "$line"    # for とかに continue がある
done
