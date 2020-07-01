#!/bin/bash
echo
echo -e " \033[1;32m===== <<gdutils project deployment script requirements and instructions>> =====\033[0m "
echo -e "\033[1;32m---------------[ v2.1 by oneking ]---------------\033[0m"
echo -e " \033[32m 1.\033[0m This script is a one-click deployment script for the TG Great God @viegg's gdutils project; "
echo -e " \033[32m 2.\033[0m The script includes two parts: " Query Dump Deployment on TD Disk VPS" and "Telegram Robot Deployment "
echo -e " \033[32m 3.\033[0m This script adapts to CentOS/Debian/Ubuntu three operating systems, automatically recognizes and automatically selects the corresponding branch for one-click installation and deployment "
echo -e " \033[32m 4.\033[0m can be deployed in three steps: upload the script to VPS → set script execution permissions → run "
echo -e " \033[32m 5.\033[0m Register the robot on TG and obtain and record the robot token "
echo -e " \033[32m 6.\033[0m has a domain name bound to cloudflare to resolve to the server IP where the robot is located "
echo -e "\033[1;32m------------------------------------------------\033[0m"
read -s -n1 -p " ★★★ If you have already prepared [5/6] above or do not need to install Telegram robot, please press any key to start deployment, if you are not ready, please press "Ctrl+c" to terminate the script ★ ★★ "
echo
echo -e "\033[1;32m------------------------------------------------\033[0m"

# Identify the operating system
aNAME="`uname -a`"
bNAME="`cat /proc/version`"
cNAME="`lsb_release -a`"
if [ -f "/etc/redhat-release" ];then
	if [[ `cat /etc/redhat-release` =~ "CentOS" ]];then
		os="CentOS"
	be
elif [ "$aNAME"=~"Debian" -o "$bNAME"=~"Debian"  -o "$cNAME"=~"Debian" ];then os="Debian"
elif [ "$aNAME"=~"Ubuntu" -o "$bNAME"=~"Ubuntu"  -o "$cNAME"=~"Ubuntu" ];then os="Debian"
elif [ "$aNAME"=~"CentOS" -o "$bNAME"=~"CentOS"  -o "$cNAME"=~"CentOS" ];then os="CentOS"
elif [ "$aNAME"=~"Darwin" -o "$bNAME"=~"Darwin"  -o "$cNAME"=~"Darwin" ];then os="mac"
else os="$bNAME"
be

# Software tools need to be installed and dependence
insofts=(epel-release update upgrade wget curl git unzip zip sudo python3-distutils python3 python3-pip)

#Set variables according to operating system
if [[ "$os" = "Debian" ]];then
    = cmd_install " APT-GET "  # install command
    cmd_install_rely= " build-essential "  # c++ compilation environment
    nodejs_curl= " https://deb.nodesource.com/setup_10.x "  # nodejs download link
    cmd_install_rpm_build="" #安装rpm-build
    nginx_conf= " /etc/nginx/sites-enabled/ "  # nginx configuration file storage path
    rm_nginx_default="rm -f /etc/nginx/sites-enabled/default" #删除default
    echo
    echo -e " \033[1;32m★★★★★ Your operating system is Debian, the gdutils project will be deployed for you soon ★★★★★\033[0m "
elif [[ "$os" = "Ubuntu" ]];then
    cmd_install="sudo apt-get"
    cmd_install_rely="build-essential"
    nodejs_curl="https://deb.nodesource.com/setup_10.x"
    cmd_install_rpm_build=""
    nginx_conf="/etc/nginx/sites-enabled/"
    rm_nginx_default="rm -f /etc/nginx/sites-enabled/default"
    rm_
    echo
    echo -e " \033[1;32m★★★★★ Your operating system is Ubuntu, and the gdutils project will be deployed for you soon ★★★★★\033[0m "
elif [[ "$os" = "CentOS" ]];then
    cmd_install="yum"
    cmd_install_rely="gcc-c++ make"
    nodejs_curl="https://rpm.nodesource.com/setup_10.x"
    cmd_install_rpm_build="yum install rpm-build -y"
    nginx_conf="/etc/nginx/conf.d/"
    rm_nginx_default=""
    echo
    echo -e " \033[1;32m★★★★★ Your operating system is Centos and will soon start deploying gdutils project for you ★★★★★\033[0m "
elif [[ "$os" = "mac" ]];then
    echo
    echo -e " \033[1;32m★★★★★ Your operating system is MacOS, please install it manually on the graphical interface ★★★★★\033[0m "
    exit
    echo
    echo
else
    echo
    echo -e "\033[1;32m unknow os $OS, exit! \033[0m"
    exit
    echo
    echo
be

echo
echo -e " \033[1;32m===== <<Upgrade system/update software/installation tools/installation dependencies>> =====\033[0m "
echo

for(( aloop=0;aloop<${#insofts[@]};aloop++ )) do
    if [ ${insofts[$aloop]} = "update" -o ${insofts[$aloop]} = "upgrade" ];then
        echo -e " \033[1;32m" ${insofts[$aloop]} "Start installation...\033[0m "
        $cmd_install ${insofts[$aloop]} -y
        echo -e "\033[1;32m------------------------------------------------\033[0m"
    else
        echo -e " \033[1;32m" ${insofts[$aloop]} "Start installation...\033[0m "
        $cmd_install install ${insofts[$aloop]} -y
        echo -e "\033[1;32m------------------------------------------------\033[0m"
    be
done

echo
echo -e " \033[1;32m===== <<Install gdutils dependency-nodejs and npm/install configuration gdutils>> =====\033[0m "
echo
$cmd_install install $cmd_install_rely -y
curl -sL $nodejs_curl | bash -
$cmd_install install nodejs -y
$cmd_install_rpm_build
git clone https://github.com/iwestlin/gd-utils && cd gd-utils
npm config set unsafe-perm=true
asl

echo
echo -e " \033[1;32m★★★ Congratulations! The gdutils statistical dump system has been installed correctly, please upload sa to the "./gd-utils/sa/" directory to complete the final deployment ★★★\ 033[0m "
echo

#################################################################################################

echo -e "\033[1;32m----------------------------------------------------------\033[0m"
read -s -n1 -p " ★★★ The Telegram robot will be deployed below, please make sure that the required conditions are ready, press any key to start deploying the robot; if you are not ready, press "Ctrl+c" to terminate the deployment robot ★ ★★ "
echo
echo -e "\033[1;32m----------------------------------------------------------\033[0m"

echo
echo -e " \033[1;32m ===== <<Start to deploy gdutils query and dump TG robot>> ===== \033[0m "
echo

# Type "robot token / telegram account name / WEB Service Name / URL"
read -p " " " Please enter the robot token and press Enter
    Your Bot Token =>:""" YOUR_BOT_TOKEN
# Judge token is entered correctly
while [[ "${#YOUR_BOT_TOKEN}" != 46 ]]
    do
    echo -e " \033[1;32m★★★ The robot TOKEN input is incorrect, please re-enter or press "Ctrl+C" to end the installation! ★★★\033[0m "
    read -p " " " Please enter the robot token and press Enter
    Your Bot Token =>:""" YOUR_BOT_TOKEN
    done 

read -p " " " Please enter the URL set on cloudflare (fill in your complete domain name, format: https://bot.abc.com) and press Enter
    Your Website =>:""" YOUR_WEBSITE
#Determine whether the URL is entered correctly
until [[ "$YOUR_WEBSITE" =~ "https://" ]]
    do
    echo -e " \033[1;32m★★★ The URL format is entered incorrectly, the URL should contain "http://", please re-enter or press "Ctrl+C" to end the installation! ★★★\033[0m "
    read -p " " " Please enter the URL set on cloudflare (fill in your complete domain name, format: https://bot.abc.com) and press Enter
    Your Website =>:""" YOUR_WEBSITE
    done 

read -p " " " Please set a name for the WEB service (fill in your domain name, format: bot.abc.com) and press Enter
    Your Bot Server Name =>:""" YOUR_BOT_SERVER_NAME
#Determine whether the WEB service name is entered correctly
until [[ "$YOUR_WEBSITE" =~ "$YOUR_BOT_SERVER_NAME" ]]
    do
    echo -e " \033[1;32m★★★ "Your Bot Server Name" is entered incorrectly, you should enter the domain name you resolved on cloudflare and does not contain "http", please re-enter or press "Ctrl+C" to end the installation ！ ★★★\033[0m "
    read -p " " " Please set a name for the WEB service (fill in your domain name, format: bot.abc.com) and press Enter
    Your Bot Server Name =>:""" YOUR_BOT_SERVER_NAME
    done 

read -p " " " Please enter the telegram account name of the robot (the part behind "@") and press Enter
    Your Telegram Name =>:""" YOUR_TELEGRAM_NAME

cd ~ && 
sed -i "s/bot_token/$YOUR_BOT_TOKEN/g" ./gd-utils/config.js
sed -i "s/your_tg_username/$YOUR_TELEGRAM_NAME/g" ./gd-utils/config.js
echo -e "\033[1;32m----------------------------------------------------------\033[0m"

echo -e " \033[1;32m "process daemon pm2" starts installation...\033[0m "
cd /root/gd-utils && 
npm i pm2 -g && pm2 l
echo -e " \033[1;32m starts the daemon...\033[0m "
pm2 start server.js
echo -e "\033[1;32m----------------------------------------------------------\033[0m"

echo -e " \033[1;32m "nginx" to start the installation...\033[0m "
cd ~ && 
$cmd_install install nginx -y
echo   
echo -e " \033[1;32m===== <<Configure nginx service>> ===== \033[0m "
echo
echo -e " \033[1;32m "nginx" starts a web service...\033[0m "

cd $nginx_conf
echo "server {
listen 80;
server_name $YOUR_BOT_SERVER_NAME;
location / {
    proxy_pass http://127.0.0.1:23333/;
}
}" > ${nginx_conf}gdutilsbot.conf && 
$rm_nginx_default

ls && 
nginx -t &&  
nginx -c /etc/nginx/nginx.conf && 
nginx -s reload && 
netstat tulips
echo -e "\033[1;32m----------------------------------------------------------\033[0m"

echo -e " \033[1;32m"Check if the website is successfully deployed"...\033[0m "
curl $YOUR_WEBSITE/api/gdurl/count\?fid=124pjM5LggSuwI1n40bcD5tQ13wS0M6wg
echo
echo -e " \033[1;32m set Webhook service...\033[0m "
print_webhook=`curl -F "url=$YOUR_WEBSITE/api/gdurl/tgbot" "https://api.telegram.org/bot$YOUR_BOT_TOKEN/setWebhook"`
echo

#Determine whether the reverse proxy is successfully deployed
if [[ $print_webhook =~ "true" ]];then
    echo -e " \033[1;32m★★★ Congratulations! GoogleDrive query and transfer robot deployment is successful, please return to the TG interface to send a "/help" to the bot to get help ★★★\033[0m "
else
    echo -e " \033[32m★★★ Unfortunately! Robot setup failed, please go back to check if the website is successfully deployed, and repeat this installation process ★★★\033[0m " , exit !
be
nginx -t && nginx -s reload
echo
echo

cd ~
rm -f gdutilsinstall_other.sh

# #########################gdutilsFeature suggestion#################### ##############
# This section is recommended for gdutils project because I mainly use the search function so the following is recommended only involves inquiry
# 1- Put the following parameters in the configuration file settings: sa storage path
# 2- Change sa "random" use to "sequential" group use;
# 3- Increase the output mode, you can use the command line with parameters to choose, the specific mode is recommended:
#    ① According to the first or second folder display the number size
#    ②Can count multiple disks at one time and output the number and size of files on a single disk and the sum of several disks
#    ③ Get the folder name corresponding to the id or the disk to save the database, and give a command to query the historical record summary or the specified summary
# 4-During the query process, the output method should not be output every time, but can be fixed + number change
# 5- Command parameters can be added before or after the ID, if it is necessary to fix one, it is added before the ID
# 6- The command line is also changed to the default sa mode
############################################################################
