# !/bin/bash

# TheosTemplate="TheosTemplate"

echo `pwd`

#1. 读取配置
read -p "Enter target app bundle id[com.xx.xx]: " targetbundleid
read -p "Enter target process[SpringBoard]: " targetprocess
read -p "Enter deb name[xxcrack]: " debname
read -p "Enter deb autor[zhz]: " autor

# targetbundleid="com.emo.zab"
# targetprocess="EmoSpeedup"
# debname="emoCrack"
# autor="zhz"
if [ -z $targetbundleid ] || [ -z $debname ]; then
    echo "input targetbundleid debname!!!!"
    exit 0
fi
if [ -z $targetprocess ]; then
    targetprocess="SpringBoard"
fi
if [ -z $autor ]; then
    autor="zhz"
fi
echo "------------------"
echo "$targetbundleid; $targetprocess; $debname; $autor"
echo "------------------"

#2. clone模板
if [ ! -d "./TheosTemplate" ]; then
    rm -rf ./TheosTemplate
fi
git clone git@github.com:zhzDeveloper/TheosTemplate.git

#3. change name
pbxprojPath=`pwd`"/TheosTemplate/TheosTemplate.xcodeproj/project.pbxproj"
if [ ! -f $pbxprojPath ]; then
    echo pbxproj not found!!!
    exit 0
fi
MakefilePath=`pwd`"/TheosTemplate/Makefile"
if [ ! -f $MakefilePath ]; then
    echo Makefile not found!!!
    exit 0
fi
TweakxiPath=`pwd`"/TheosTemplate/Tweak.xi"
if [ ! -f $TweakxiPath ]; then
    echo TweakxiPath not found!!!
    exit 0
fi

# rename pbxproject/Makefile/Tweak name
sed -i '' 's/TheosTemplate/'${debname}'/g' $pbxprojPath
sed -i '' 's/TheosTemplate/'${debname}'/g' $MakefilePath
sed -i '' 's/TheosTemplate/'${debname}'/g' $TweakxiPath

mv ./TheosTemplate ./${debname}
mv ./${debname}/TheosTemplate.plist     ./${debname}/${debname}.plist
mv ./${debname}/TheosTemplate.xcodeproj ./${debname}/${debname}.xcodeproj

#4. 根据配置设置theos
sed -i '' 's/__replace_bundleid__/'${targetbundleid}'/g'    ./${debname}/${debname}.plist
sed -i '' 's/__Process__/'${targetprocess}'/g'              ./${debname}/Makefile
sed -i '' 's/__Author__/'${autor}'/g'                       ./${debname}/control
sed -i '' 's/TheosTemplate/'${debname}'/g'                  ./${debname}/control

echo "finished !!!!"
# end
open ./${debname}/${debname}.xcodeproj
