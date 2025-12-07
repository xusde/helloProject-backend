#! /bin/sh
# 镜像名称，从脚本参数第1个传入
imageName=$1
# 构建版本号，从脚本参数第2个传入
build_number=$2

# 查找所有容器（包括停止的），名字中完全匹配镜像名的容器ID（第一列）
containerStr=`docker ps -a | grep -w ${imageName} | awk '{print $1}'`
# 查找镜像列表中名字完全匹配的镜像ID（第三列）
imageStr=`docker images | grep -w $imageName  | awk '{print $3}'`

echo "container id:$containerStr"
echo "image id:$imageStr"

# 判断是否存在镜像ID（即镜像是否存在）
if [ "$imageStr" !=  "" ] ; then
  # 判断是否存在对应容器
  if [ "$containerStr" !=  "" ] ; then
    # 如果存在容器，先停止这些容器
    docker stop `docker ps -a | grep -w ${imageName}  | awk '{print $1}'`

    # 停止后删除这些容器
    docker rm `docker ps -a | grep -w ${imageName}  | awk '{print $1}'`

    # 删除镜像，排除当前build_number版本的镜像（v开头的标签）
    docker rmi -f $(docker images | grep $imageName | grep -v v$build_number | awk '{print $3}')
  else
    # 如果没有容器，则直接删除所有除了当前build_number版本以外的镜像
    docker rmi -f $(docker images | grep $imageName | grep -v v$build_number | awk '{print $3}')
  fi
fi