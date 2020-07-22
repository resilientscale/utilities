#!/bin/bash

usage() {
  echo " "
  echo "Changes git repository default branch from master to main. The script will use "
  echo "`git remote get-url --all origin` to select the owner and repository name."
  echo " "
  echo "** BE SURE to run this from the root of the local clone of the repository **"
  echo " "
  echo "Usage: "
  echo "  $0 <path-to-local-clone>"
  echo " " 
  echo "Options: "
  echo " "
  echo "  <path-to-local-clone>: The "
  echo "  --help: display this usage message"
  echo " "
}

migrate() {
  
  local clone=$1

  pushd $clone
    local remote=$(git remote get-url --all origin)
    if [[ -z "$remote" ]]; then
      echo "ERROR: Could not find remote. Did you run this "
      usage
      exit
    fi
    owner_and_repo=$(get_owner_and_repo "$remote")
    #echo "Creating moving to main branch"
    git branch -m master main
    #echo "Pushing main to origin"
    git push -u origin main

    curl -X PATCH https://api.github.com/repos/${owner_and_repo} \
        -u "${GITHUB_USERNAME}:${GITHUB_PASSWORD}" \
        -d '{"default_branch": "main"}' 
    
    git push -d origin master
    git remote set-head origin main
  popd
}

if [ "$#" -ne 1 ] || [ "--help" == "$1" ]; then
  usage
  exit 
fi

if [ ! -d $1 ]; then
  echo " "
  echo "ERROR path to local clone does not exist: $1"
  usage
  exit
fi

if [ -z "$GITHUB_USERNAME" ] || [ -z "$GITHUB_PASSWORD" ]; then 
  echo " "
  echo "ERROR: You must set the GITHUB_USERNAME and GITHUB_PASSWORD environment variables"
  usage
  exit
fi
 
this_directory=`dirname "$0"`
source $this_directory/utilities.bash
migrate "$1"
