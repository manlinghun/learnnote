echo " 同步当前文件到gitee "
git pull origin master
echo "pull success"
git add .
echo "add success"
git commit -m "RC"
echo "commit success"
git push origin master
echo "push success"



npx markmap-cli 考试/软考-高项/知识图谱.md -o G:\\github_project\\manlinghun\\exam\\rkgx\\知识图谱_mind.html
cd G:\\github_project\\manlinghun

echo " 同步当前文件到github "
git pull origin master
echo "pull success"
git add .
echo "add success"
git commit -m "RC"
echo "commit success"
git push origin master
echo "push success"