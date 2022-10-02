#!/bin/bash

# Merge multiple branchs
if [ $# -eq 0 ]
  then
    echo "Usage as ./combineBranch.sh branch1 branch2 branchN"
else
  git co develop
  git pull origin develop --rebase

  for branchCombined in "$@"
  do
      git co $branchCombined
      git rebase develop
  done

  git branch -D COMBINED_$(whoami)
  git co -b COMBINED_$(whoami)
  git cherry-pick "$@"
fi