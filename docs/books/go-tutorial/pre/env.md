# Linux golang 环境搭建

## 描述

* wsl: 
  * 因为做后端尽量熟悉使用 Linux 系统
  * wsl 编译和 git 比 windowns 更快
  * 方便使用科学上网
* docker: 
  * 方便运行各种应用

## wsl 安装

### 下载 wsl 并安装

可参考教程:

* 推荐直接官方文档: https://learn.microsoft.com/zh-cn/windows/wsl/install-on-server
* 史上最全的WSL安装教程, 知乎: https://zhuanlan.zhihu.com/p/386590591


### 使用 root 用户

如果是本地 wsl 或者私人服务器 **推荐** 你可以直接使用root开发, 可以解决很多后期权限问题

在宿主机 window 中打开命令行

```bash
$ wsl -l -v
  NAME                   STATE           VERSION
* Ubuntu-18.04           Running         1
  Ubuntu-20.04           Running         2
  docker-desktop-data    Running         2
  docker-desktop         Running         2
# cmd 设置 ubuntu 默认用户为 root (建议开发环境使用 root 用户并且可以跳过 sudoer 配置)
$ ubuntu1804.exe config --default-user root 
```

### 换源 apt

国外 apt 太慢了, 我们换成国内的源


查看版本号

```bash
 lsb_release -a
```


再下面的地址找到自己版本的镜像源
[https://mirrors.tuna.tsinghua.edu.cn/help/ubuntu/]()

备份原来的镜像源

```bash
sudo cp /etc/apt/sources.list /etc/apt/sources.list.bk
```

将原内容删除

```bash
sudo rm /etc/apt/sources.list 
```

替换为新的配置内容

```bash
sudo vim /etc/apt/sources.list 
```



```bash
# ubuntu20
# 默认注释了源码镜像以提高 apt update 速度，如有需要可自行取消注释
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-updates main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-updates main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-backports main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-backports main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-security main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-security main restricted universe multiverse

# 预发布软件源，不建议启用
# deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-proposed main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-proposed main restricted universe multiverse
```

刷新

```bash
sudo apt-get update 
```

### 安装常见工具

```bash
sudo apt install net-tools  -y
sudo apt install  git  -y
sudo apt install  make  -y
sudo apt install  automake  -y
sudo apt install  cmake -y
sudo apt install  telnet  -y
sudo apt install  gcc  -y 
sudo apt install  g++ -y
sudo apt install  libtool -y
sudo apt install  unzip -y
```

### 工作区

> 强烈推荐将所有的代码放到工作区里面, 这样可以方便代码的管理和后期的进行备份和迁移

```bash
mkdir -p ~/workspace
```

如果你新建一个 mynote 项目, 那么你可以这样做

```bash
mkdir -p ~/workspace/mynote
```


## git 安装

### git 安装

* 安装
* 配置邮箱用户名, 编辑器等

安装

```bash
sudo apt install git -y
```



或者手动安装安装高版本的git TODO:

配置

```bash
git config --global user.name "dengjiawen"    # 用户名改成自己的
git config --global user.email "dengjiawen8955@gmail.com"    # 邮箱改成自己的
git config --global credential.helper store    # 设置 Git，保存用户名和密码
git config --global core.longpaths true # 解决 Git 中 'Filename too long' 的错误
# 设置全局默认编辑器为 vim ,一开始默认是 nano
tee -a ~/.gitconfig<<'EOF'
[core]
editor=vim
EOF
```

其次，如果你觉得访问 github.com 太慢，可以通过国内 GitHub 镜像网站来访问，配置方法如下(这个镜像同步更新有1天的延时)：

```bash
#git config --global url."https://github.com.cnpmjs.org/".insteadOf "https://github.com/"
# 如果需要及时更新就把这个关闭
#git config --global --unset  url."https://github.com.cnpmjs.org/".insteadOf "https://github.com/"
# 看看成功没有
git config --list
```

最后，GitHub 限制最大只能克隆 100M 的单个文件，为了能够克隆大于 100M 的文件，我们还需要安装 Git Large File Storage，安装方式如下：

```bash
git lfs install --skip-repo
```

## golang 安装

### golang 安装

下载指定版本的go, 这里指定了版本 go1.18.2, 你可以自己指定版本, 需要将下面的版本号替换成你想要的版本号

```bash
mkdir -p ~/tmp
wget https://golang.google.cn/dl/go1.18.2.linux-amd64.tar.gz -O ~/tmp/go1.18.2.linux-amd64.tar.gz
```

解压和安装

```bash
mkdir -p $HOME/go
tar -xvzf ~/tmp/go1.18.2.linux-amd64.tar.gz -C $HOME/go
mv $HOME/go/go $HOME/go/go1.18.2
```

配置环境变量

```bash
tee -a $HOME/.bashrc <<'EOF'
# Go envs
export GOVERSION=go1.18.2 # Go 版本设置
export GOROOT=$HOME/go/$GOVERSION # GOROOT 设置
export GOPATH=$HOME/go # GOPATH 设置
export PATH=$GOROOT/bin:$GOPATH/bin:$PATH # 将 Go 语言自带的和通过 go install 安装的二进制文件加入到 PATH 路径中
export GO111MODULE="on" # 开启 Go moudles 特性
export GOPROXY=https://goproxy.cn,direct # 安装 Go 模块时，代理服务器设置
export GOPRIVATE=
export GOSUMDB=off # 关闭校验 Go 依赖包的哈希值
EOF

source ~/.bashrc
```
在使用模块的时候，`$GOPATH` 是无意义的，不过它还是会把下载的依赖储存在 `$GOPATH/pkg/mod` 目录中，也会把 go install 的二进制文件存放在 `$GOPATH/bin` 目录中。

另外，我们还要将`$GOPATH/bin`、`$GOROOT/bin` 加入到 Linux 可执行文件搜索路径中。这样一来，我们就可以直接在 bash shell 中执行 go 自带的命令，以及通过 go install 安装的命令。

### protobuf 安装

安装 protoc (可选, 如果没有学习 rpc 这个先不管)

(1) goctl 工具提供了一键安装的脚本
```bash
GOPROXY=https://goproxy.cn/,direct go install github.com/zeromicro/go-zero/tools/goctl@latest
goctl env check -i -f --verbose 
chmod +x $GOPATH/bin/protoc
```


(2) 或者手动安装 

```bash
# 下载(可以去https://github.com/protocolbuffers/protobuf/releases找最新的包)
wget  https://github.com/protocolbuffers/protobuf/releases/download/v3.20.1/protoc-3.20.1-linux-x86_64.zip -O/tmp/protoc-3.20.1-linux-x86_64.zip
# 解压
unzip /tmp/protoc-3.20.1-linux-x86_64.zip -d /tmp/protoc-3.20.1-linux-x86_64
# 移动
mv protoc-3.20.1-linux-x86_64/bin/protoc $GOPATH/bin/
```

安装 protoc-gen-go 和 protoc-gen-go-grpc
```bash
go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
```

参考
[protoc & protoc-gen-go安装 | go-zero](https://go-zero.dev/cn/docs/prepare/protoc-install/)

## vscode for golang

也许可以参考的教程

https://zhuanlan.zhihu.com/p/320343679


## ssh

### ssh 免密登录

如果你使用 ssh remote 开发模式, 服务器可以是 wsl 或者云服务器, 或者虚拟机

每次都要输入密码很麻烦, 这里介绍一下免密登录的方法

#### 客户端

生成ssh密钥(全部按 enter 默认值就行)

```bash
ssh-keygen
```

#### 服务器


安装openssh-server

```bash
sudo apt remove openssh-server -y
sudo apt install openssh-server -y
```

修改配置文件

```bash
sudo vim /etc/ssh/sshd_config
```

```bash
# 打开监听的端口和地址
Port 22
ListenAddress 0.0.0.0
# 支持公钥登录
PubkeyAuthentication yes
# 支持密码登录
PasswordAuthentication yes
```

生成ssh密钥(全部按 enter 默认值就行)

```bash
ssh-keygen
```

重启

```bash
sudo service ssh restart
```

将客户端的 id_rsa.pub 添加到  ~/.ssh/authorized_keys 中

```bash
vim ~/.ssh/authorized_keys 
```

修改文件权限

```bash
chmod 600 ~/.ssh/authorized_keys
```

### GitHub ssh 免密推送

将客户端的 id_rsa.pub 添加到 GitHub 的 ssh key 中

Settings -> SSH and GPG keys -> New SSH key

## docker

### 方法1 wsl 使用 docker-desktop


**如果使用 window + wsl 开发的话建议在 window 上安装 docker-desktop**

#### 下载软件

点击链接下下载安装: https://www.docker.com/products/docker-desktop/


#### 镜像加速

打开软件->设置->Docker Engine 添加镜像加速

```json
  "registry-mirrors": [
    "https://registry.docker-cn.com"
  ]
```

![docker-desktop镜像加速](https://image.bmft.tech/blog/2023/202303311554827.png)

当然你可以使用其他加速比如阿里云的, 自行搜索

#### 开启 wsl2

打开软件->设置->General->Use the WSL 2 based engine

![开启 wsl2](https://image.bmft.tech/blog/2023/202303311555192.png)

### 方法2: 直接安装


国内脚本一键安装

```bash
curl -sSL https://get.daocloud.io/docker | sudo sh
```


启动+自启

```bash
sudo service docker start
sudo systemctl enable docker
```



安装docker-compose

```bash
sudo apt install docker-compose -y
```

镜像加速

```bash
sudo tee -a /etc/default/docker << 'EOF'
# docker 加速镜像
DOCKER_OPTS="--registry-mirror=https://registry.docker-cn.com"
EOF

sudo service docker restart
```


参考

https://www.runoob.com/docker/ubuntu-docker-install.html

[Docker 镜像加速 | 菜鸟教程 (runoob.com)](https://www.runoob.com/docker/docker-mirror-acceleration.html)


### docker 常用脚本和命令

TODO:


