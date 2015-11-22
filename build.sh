#!/bin/bash
set -e
version=$(echo $release_link | grep -oE '[^\/]+$')
branch=v$version
gem install rails -v $version
git checkout --orphan $branch
git rm -rf .
rails new test-app
git add .
git commit -m '`rails new test-app`'
git remote set-url --push origin https://$GITHUB_USER:$GITHUB_TOKEN@github.com/dnrce/railsnew.git
git push origin $branch
