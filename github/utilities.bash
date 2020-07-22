#!/bin/bash

get_owner_and_repo() {
  local repo_url=$1
  local gh="https://github.com/"
  local dot_git=".git"

  echo $repo_url | sed "s|$gh||g" | sed "s|$dot_git||g"
}