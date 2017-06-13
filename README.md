# test
my first test demo

文件说明：
apisrv: web服务器
webui: 页面存放目录
doc：文档目录
----------------------------
代码提交：
0、初始化
mkdir git 
cd git 
git clone https://gitlab.com/male-puppies/game_v1.0.git
cd ads
0、切换到自己的代码分支
   git checkout develop_tmp
1、准备提交代码前，先更新git目录代码(非常重要)
    git pull --rebase origin develop
2、使用beyond compare合并开发代码到git目录
3、查看文件的 增加、删除和修改
   git status
4、修改文件权限，一般只要把可执行权限去掉
   chmod -x xxx 
5、确认后加入提交列表 
   git add xxx 
6、提交到本地分支
   git commit -m "message"
7、提交到自己的分支
   git push origin  develop_tmp
-------------------------------------------------
合并到主分支：进入develop分支： git merge develop_tmp
