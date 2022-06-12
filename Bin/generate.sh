#!/bin/sh

#  run.sh
#  TheosTempelete
#
#  Created by zhz on 2022/6/12.
#  

plistpath=`pwd`/../theostemplate.plist
tweakrc_path=`pwd`/../tweakrc.plist
makefile_path=`pwd`/../Makefile
control_path=`pwd`/../control

function fixup() {
    echo "  [-]"$*
    item=$1
    replace_string=$2
    file_path=$3
    `which sed` -ig "s/${replace_string}/${item}/" $file_path
    #显示最后命令的退出状态。0表示没有错误，其他任何值表明有错误。
    if [[ $? == 0 ]]; then
        echo "  [-] fixup ${replace_string} suceesss"
    else
        echo "  [-] fixup ${replace_string} fail !!!!!!!"
    fi
}

function fixupBundleId() {
    echo "  [-] "$1
    bundleid=$1
#    echo $# > /dev/null #参数数量
#    echo $*  #所有参数list
    replace_string="__replace_bundleid__"
    fixup $1 $replace_string $plistpath
}

function fixupProject() {
    echo "  [-]"$1
    project=$1
    replace_string="TheosTempelete"
    replace_lower_string=`echo ${replace_string} | tr A-Z a-z`
    echo $replace_string $replace_lower_string

#tweak name: theostemplate

}

function fixupProcess() {
    echo "  [-]"$1
    process=$1
    replace_string="__Process__"
    fixup $1 $replace_string $makefile_path
}

function fixupAuthor() {
    echo "  [-]"$1
    author=$1
    replace_string="__Author__"
    fixup $1 $replace_string $control_path
}



function main() {
#1. 获取配置
    echo "[+] 1. 读取配置文件"
    /usr/libexec/PlistBuddy -c 'Print' $tweakrc_path
#1.1 target_bundle_id
    target_bundle_id=`/usr/libexec/PlistBuddy -c 'Print :target_bundle_id' $tweakrc_path`
    if [[ -z $target_bundle_id ]];
    then
        echo "error!!!! must set target_bundle_id!!!!"
        exit
    else
        echo "[+] 1.1. 读取target_bundle_id完成: "$target_bundle_id
        fixupBundleId $target_bundle_id
    fi
#1.2 project
    project=`/usr/libexec/PlistBuddy -c 'Print :project' $tweakrc_path`
    if [[ -z $project ]];
    then
        echo "error!!!! must set project!!!!"
        exit
    else
        echo "[+] 1.2. 读取project完成: "$project
        fixupProject $project
    fi
#1.3 target_process
    target_process=`/usr/libexec/PlistBuddy -c 'Print :target_process' $tweakrc_path`
    if [[ -z $target_process ]];
    then
        echo "error!!!! must set target_process!!!!"
        exit
    else
        echo "[+] 1.3. 读取target_process完成: "$target_process
        fixupProcess $target_process
    fi
#1.4 author
    author=`/usr/libexec/PlistBuddy -c 'Print :author' $tweakrc_path`
    if [[ -z $author ]];
    then
        echo "error!!!! must set author!!!!"
        exit
    else
        echo "[+] 1.4. 读取author完成: "$author
        fixupAuthor $author
    fi
}
# 程序入口
main



#有两个预先定义的变量，OPTARG表示选项值，OPTIND表示参数索引位置，类似于$1。
#n后面有:，表示该选项需要参数，而h后面没有:，表示不需要参数
#最开始的一个冒号，表示出现错误时保持静默，并抑制正常的错误消息
#while getopts ":n:b:h" optname
#do
#    case "$optname" in
#      "n")
#        echo "get option -n,value is $OPTARG"
#        ;;
#      "b")
#        echo "get bundle id -n,value is $OPTARG"
#        fixupBundleId $OPTARG
#        ;;
#      "h")
#        echo "get help: \nexample: \nsh run.sh -n 钉钉 -b com.dingding.ding"
#        ;;
#    esac
##    echo "option index is $OPTIND"
#done
