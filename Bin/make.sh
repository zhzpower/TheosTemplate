#!/bin/sh

#  make.sh
#  TheosTempelete
#
#  Created by zhz on 2022/6/12.
#  


export THEOS=/opt/theos
echo $THEOS
echo $SRCROOT


echo "1. make package..."
make clean && make && make package

# 2. make auto install; dependy `expect`
# 2.1 install expect by `brew install --build-from-source expect`
echo "2. auto install..."
if [[ ! -n $(brew list --formula | grep expect) ]] ; then
    echo "2.1 install expect..."
    brew install --build-from-source expec
fi

echo "2.2 make install..."
expect `pwd`/Bin/iphone.expect #&& make install

