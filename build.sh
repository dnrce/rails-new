#!/bin/bash
set -e
app_name=test-app
version=$(echo $release_link | grep -oE '[^\/]+$')
branch=v$version
gem install rails -v $version
git checkout --orphan $branch
git rm -rf .
rails new $app_name
mv $app_name/* .
mv $app_name/.* .
rmdir $app_name
git add .
git commit -m '`rails new $app_name`'
git remote set-url --push origin https://$GITHUB_USER:$GITHUB_TOKEN@github.com/dnrce/railsnew.git
git push origin $branch
