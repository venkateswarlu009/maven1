#!/bin/bash

#cloning the remote repo of halIos
git clone https://code.devops.fds.com/stores/halIos.git

# 1.0.0, 1.5.2, etc.
versionLabel=$1

# establish branch
devBranch=DEV
masterBranch=master
releaseBranch=RELEASE/$versionLabel

#navigating into halIos
cd halIos

#getting the current branch
branch=$(git symbolic-ref HEAD | sed -e 's,.*/\(.*\),\1,')
echo $branch


#merging dev branch into master
git checkout master
git merge devBranch

# file in which to update version number
cd HAL-iOS/
versionFile="Info.plist"
 

# create the release branch from the -develop branch
git checkout -b $releaseBranch

#checking out into the newly created release branch
echo $branch
git checkout RELEASE/$versionLabel

# find version number assignment ("= 1.5.5" for example)
# and replace it with release specified version number
sed -i.backup -E "s/[0-9][0-9].[0-9][0-9].[0-9][0-9]/$versionLabel.01/g" $versionFile

# remove backup file created by sed command
rm $versionFile.backup
 
# commit version number increment
echo $(git commit -am "[ci-skip] pushing new versions back to git")


#Updating Dev branch with new version change.
cd halIos
git add .
git commit -m "ci-skip"
git checkout DEV
echo $branch

# find version number assignment ("= 1.5.5" for example)
# and replace it with newly specified version number


#script to generate new verison number for dev branch
majorversion="$(cut -d'.' -f1 <<< $versionLabel)"
minorversion="$(cut -d'.' -f2 <<< $versionLabel)"
newVersionLabel=00.00.00

if [ $minorversion -lt 12 ]
then
 if [ ${minorversion:0:1} == 0 ]
 then
  minorversion=$(( ${minorversion:1:1} + 1 ))
  newVersionLabel=$majorversion.$minorversion
 else
  minorversion=$(( $minorversion + 1 ))
  newVersionLabel=$majorversion.$minorversion
 fi 
else
 majorversion=$(( $majorversion + 1 ))
 newVersionLabel=$majorversion.01
fi

echo $branch
sed -i.backup -E "s/[0-9][0-9].[0-9][0-9].[0-9][0-9]/$newVersionLabel.01/g" $versionFile
rm $versionFile.backup

# commit version number increment
echo $branch
echo $(git commit -am "[ci-skip] pushing new versions back to git")
