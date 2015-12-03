#!/bin/bash
set -ev

# Initialize variables
app_name=test-app
version=$(echo $release_link | grep -oE '[^\/]+$')
branch=v$version

# Install Rails
gem install rails -v $version

# Create an empty branch
git checkout --orphan $branch
git rm -rf .

# Create a new Rails app in the repository root
rails new $app_name
shopt -s dotglob
mv $app_name/* .
rmdir $app_name

# Commit and push
git add .
git commit -m "New Rails $version app \"$app_name\""
git tag $version
git push https://$GITHUB_USER:$GITHUB_TOKEN@github.com/dnrce/railsnew.git $branch 2>&1 | grep -v https
