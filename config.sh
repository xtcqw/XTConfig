#!/bin/bash
projectPath=$1
if [[ ! -n $projectPath ]]; then
  echo 'project path is null'
  exit
fi

if [[ ! -d $projectPath ]]; then
  echo 'project path not exists'
  exit
fi

mkdir $projectPath/Classes

cp -v ./LICENSE ./README.md ./.gitignore ./upload.sh $projectPath

projectName=${projectPath##*/}
cp -v ./PROJECT.podspec $projectPath/$projectName.podspec

sed -i "" "s/PROJECT/$projectName/g" $projectPath/README.md
sed -i "" "s/PROJECT/$projectName/g" $projectPath/$projectName.podspec
sed -i "" "s/PROJECT/$projectName/g" $projectPath/upload.sh

read -p 'project repository:' projectRepository
if [[ ! -n $projectRepository ]]; then
  echo 'project repository is null'
  exit
fi
sed -i "" "s~REPOSITORY~$projectRepository~g" $projectPath/$projectName.podspec

cd $projectPath
git init
git remote add origin $projectRepository
