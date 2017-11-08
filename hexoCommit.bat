cd c:\dev\blog\src
git add --all
git commit -m "블로그 소스 반영(%date%)"
git push -u origin master
hexo deploy --generate
