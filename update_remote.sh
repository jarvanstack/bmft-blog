#!/usr/bin/expect -f
set timeout 
set cmd1 "cd /root/app/bmft-blog && git pull origin master:master"
# 使用公钥登录不需要密码
spawn ssh -p 22 root@djv2.bmft.tech
expect {
    # 发送更新命令
    "*#" {send "$cmd1\r"}
}
interact
