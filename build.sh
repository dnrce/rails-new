#!/bin/bash
version=$(echo $release_link | grep -oE '[^\/]+$')
branch=v$version
gem install rails -v $version
git checkout --orphan $branch
git rm -rf .
rails new test-app
git add .
git commit -m '`rails new test-app`'
git push origin $branch
