# linux下Git服务器的搭建（使用的是Centos）
## 安装git
1. git --version 查看是否已经安装了git 
2. 若已安装git版本为1.7一下建议卸载了重新安装，下载命令：yum remove git
3. 安装git：yum install git
4. 使用git --version查看是否安装成功
5. 创建git用户组: adduser git 
6. 创建git用户: useradd git -g git
7. 切换到git用户: su git
8. 创建目录: mkdir ~/.shh;sudo chmod 764 ~/.ssh/
9. 创建文件：touch ~/.ssh/authorized_keys;sudo chmod 764 ~/.ssh/*
10. 客户端机器生成公钥：ssh-keygen -t rsa -C “email@email.com”
11. 将客户端生成的id_rsa.pub文件的内容复制到第9步创建的文件内：cat id_rsa.pub ~/.ssh/authorized_keys
12. 退出git用户：exit
13. 创建git仓库：mkdir /srv/git;cd /srv/git;mkdir /srv/git/mavenssm.git;git init --bare mavenssm.git;chown -R git:git mavenssm.git
14. git clone git@192.168.0.111:/srv/git/mavenssm.git