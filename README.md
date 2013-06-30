Gitalizer
=========

A non-VCS-Workspace to GIT-VCS-Workspace Transformer.    

run `gitalizer.sh path_to_workspace path_to_repository`

### This Script transforms your non-vcs workspace to a git-vcs workspace by executing the following tasks:
  
1. Creating a subfolder in **path_to_repository** for each subfolder in **path_to_workspace**
2. Backing up each subfolder in **path_to_workspace** to **~/Desktop/Backup/**
3. Deleting all subfolders in **path_to_workspace**
4. Initialising a git bare repository for each folder in **path_to_repository**
5. Cloning each repository in **path_to_repository** to **path_to_workspace**
6. Copying backed project contents to corresponding cloned project in **path_to_workspace**
7. Adding files to staging area, commit and push them
8. Deleting Backup folder
   You can enable/disable deleting the backup folder task by toggling the corresponding comment at the end

### Before
![alt text](https://raw.github.com/dbon/gitalizer/master/non-vcs.png "Non-VCS Workspace")

### After
![alt text](https://raw.github.com/dbon/gitalizer/master/git-vcs.png "GIT-VCS Workspace")
