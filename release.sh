#!/bin/bash

#cloning the remote repo of halIos
git clone https://github.com/venkateswarlu009/maven1.git

# 1.0.0, 1.5.2, etc.
versionLabel=$1

# establish branch
devBranch=DEV
masterBranch=master
releaseBranch=RELEASE/$versionLabel

#navigating into halIos
cd maven1

#getting the current branch
branch=$(git symbolic-ref HEAD | sed -e 's,.*/\(.*\),\1,')
echo $branch


#merging dev branch into master
git checkout master
git merge -m "ci-skip" $devBranch
 

 # create the release branch from the -master branch
 git checkout -b $releaseBranch
 echo $(git branch | grep \* | cut -d ' ' -f2)
 #checking out into the newly created release branch
 #git checkout $releaseBranch
 #echo $(git branch | grep \* | cut -d ' ' -f2)
 # file in which to update version number
 #cd maven1/
 versionFile="Info.plist"

 # find version number assignment ("= 19.06" for example)
 # and replace it with release specified version number
 sed -i.backup -E "s/[0-9][0-9].[0-9][0-9].[0-9][0-9]/$versionLabel.01/g" $versionFile

 # remove backup file created by sed command
 rm $versionFile.backup
  
  # commit version number increment
  #echo $(git commit -am "[ci-skip] pushing new versions back to git")


  #Updating Dev branch with new version change.
  #cd halIos
  echo $(git commit -am "[ci-skip] pushing new versions back to git")
  git checkout DEV

  # find version number assignment ("= 1.5.5" for example)
  # and replace it with newly specified version number


  #script to generate new verison number for dev branch
  majorversion="$(cut -d'.' -f1 <<< $versionLabel)"
  minorversion="$(cut -d'.' -f2 <<< $versionLabel)"
  newVersionLabel=00.00.00

  temp=${minorversion:1:1}
  if [ $minorversion -lt 12 ]
  then
   if [ ${minorversion:0:1} == 0 ]
    then
      minorversion=$(( ${minorversion:1:1} + 1 ))  
        if [ $temp -lt 9 ]
	  then
	     newVersionLabel=$majorversion.0$minorversion
	       else
	          newVersionLabel=$majorversion.$minorversion
		    fi  
		     else
		       minorversion=$(( $minorversion + 1 ))
		         newVersionLabel=$majorversion.$minorversion
			  fi 
			  else
			   majorversion=$(( $majorversion + 1 ))
			    newVersionLabel=$majorversion.01
			    fi

			    sed -i.backup -E "s/[0-9][0-9].[0-9][0-9].[0-9][0-9]/$newVersionLabel.01/g" $versionFile
			    rm $versionFile.backup

			    # commit version number increment
			    echo $(git commit -am "[ci-skip] pushing new versions back to git")

