#!/bin/bash
set -u
set -o pipefail

CUR=$(cd `dirname $0`;pwd)

# 当前目录下的other，可以放一些非官方源的rpm

# 自定义的repo文件 即 rpm包的下载源
yum_config=${CUR}/aliyun.repo
#yum_config=${CUR}/local.repo
# 待下载的rpm包
rpmlist=${CUR}/rpmlist.txt

# 下载路径
sysroot=${CUR}/centos/7.6.1810

