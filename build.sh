#!/bin/bash
set -ev

# Work on the master branch
git checkout master

# Determine release info from build parameters
version=$(echo $release_link | grep -oE '[^\/]+$')
timestamp=$release_updated

# Install Rails
gem install rails -v $version

# Create a new Rails app in the repository root
rails new rails-new --skip-bundle
mv rails-new $version

# Commit and push
git add $version
git commit --date=$timestamp -m "Rails $version"
git push https://$GITHUB_USER:$GITHUB_TOKEN@github.com/dnrce/rails-new.git master 2>&1 | grep -v https
