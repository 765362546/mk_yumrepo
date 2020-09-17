#!/bin/bash

# 读取定义的变量
source env.sh

if [ ! -f ${yum_config}  ];then
    echo '${yum_config} 不存在!'
    exit 0
fi
if [ ! -f $rpmlist ];then
    echo "$rpmlist 不存在!"
fi


install_createrepo (){
  echo "安装createrepo工具"
  yum install createrepo -y -c ${yum_config}
}

down_rpms(){
mkdir ${sysroot}/tmp &>/dev/null
mkdir -p ${sysroot}/Packages/{a..z} &>/dev/null
echo '下载rpm包'
cat ${rpmlist} |xargs |xargs yum -c ${yum_config} --installroot="${sysroot}" --downloadonly --downloaddir="${sysroot}/tmp/" -y install 
echo '调整文件位置'
for name in {a..z};do
    mv ${sysroot}/tmp/${name}*.rpm ${sysroot}/Packages/${name}/ &>/dev/null
done
mv ${sysroot}/tmp/* ${sysroot}/Packages/ &>/dev/null  
rm -rf ${sysroot}/tmp &>/dev/null 
rm -rf ${sysroot}/var &>/dev/null
echo ""
}

add_other_rpm(){
echo "拷贝other下的rpms"
for name in {a..z};do
    cp ${CUR}/other/${name}*.rpm ${sysroot}/Packages/${name}/ &>/dev/null
    #下面是将大写开头的也拷贝到小写字母开头的目录
    cp ${CUR}/other/${name^^}*.rpm ${sysroot}/Packages/${name}/ &>/dev/null
done
  
}


create_repo(){
echo "制作yum源"
  createrepo ${sysroot}/
}

main(){
install_createrepo
down_rpms
add_other_rpm
create_repo
}
main
