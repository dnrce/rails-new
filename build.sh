#!/bin/bash
set -e
app_name=test-app
version=$(echo $release_link | grep -oE '[^\/]+$')
branch=v$version
gem install rails -v $version
git checkout --orphan $branch
git rm -rf .
rails new $app_name
shopt -s dotglob
mv $app_name/* .
rmdir $app_name
git add .
git commit -m '`rails new $app_name`'
git push https://$GITHUB_USER:$GITHUB_TOKEN@github.com/dnrce/railsnew.git $branch 2>&1 | grep -v https
