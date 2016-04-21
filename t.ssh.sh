#!/bin/sh
file_host=/Users/changxingyu/workspace/hosts/testin_online_hosts
file_key=/Users/changxingyu/workspace/keys/testinops/id_rsa

if [ -z "$1" ];then
	echo "例子："
	echo "t.ssh.sh list"
	echo "t.ssh.sh 192.168.1.100"
	echo "t.ssh.sh testin-web1"
	exit
fi
if [ "$1" = "list" ];then cat ${file_host};exit;fi

link=$(cat ${file_host} | grep $1 | sed 's/[ \t]*$//g' | sort | uniq)
link_num=$(echo "${link}" | wc -l)
if [ ${link_num} -ne 1 ];then
	echo "${link}"
	exit
fi
echo $link
username=$(echo "${link}" | grep -oE "ansible_ssh_user[^ ]*" | awk -F '=' '{print $2}')
ip=$(echo "${link}" | grep -oE "ansible_ssh_host[^ ]*" | awk -F '=' '{print $2}')
port=$(echo "${link}" | grep -oE "ansible_ssh_port[^ ]*" | awk -F '=' '{print $2}')
#echo $username $ip $port

#ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -i ${file_key} -p ${port} ${username}@${ip}
ssh -o StrictHostKeyChecking=no -i ${file_key} -p ${port} ${username}@${ip}
