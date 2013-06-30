Gitalizer
=========

A non-VCS-Workspace to GIT-VCS-Workspace Transformer.   

Ever wanted to put all your project under GIT-Version control?
But having to many projects kept you off from doing it manually?
You don't have to do it manually... just let this script do the work for you. 

run `gitalizer.sh path_to_workspace path_to_repository`

- **path_to_workspace** the folder which includes your projects
- **path_to_repository** the path where your repository will be created

### This Script transforms your non-vcs workspace to a git-vcs workspace by executing the following tasks:
  
1. Creating a sub-folder in **path_to_repository** for each sub-folder in **path_to_workspace**
2. Backing up each sub-folder in **path_to_workspace** to **~/Desktop/Backup_timestamp/**
3. Deleting all sub-folders in **path_to_workspace**
4. Initializing a git bare repository for each folder in **path_to_repository**
5. Cloning each repository in **path_to_repository** to **path_to_workspace**
6. Copying backed project contents to corresponding cloned project in **path_to_workspace**
7. Adding files of each project to staging area, commit and push them
8. Deleting Backup folder. (You can enable/disable this by toggling the corresponding comment at the end)

### Non-VCS-Workspace (before)
![alt text](https://raw.github.com/dbon/gitalizer/master/non-vcs.png "Non-VCS Workspace")

If your project structure looks like the image above you have to run `gitalizer.sh path_to_workspace/CSharp path_to_repository/CSharp` and `gitalizer.sh path_to_workspace/Java path_to_repository/Java`

### GIT-VCS-Workspace (after)
![alt text](https://raw.github.com/dbon/gitalizer/master/git-vcs.png "GIT-VCS Workspace")

### Your repository will be created like that:
![alt text](https://raw.github.com/dbon/gitalizer/master/repo.png "Repository")

**Note:** I successfully tested this script with various project folders. If you find a bug please contact me via daniel.bongartz@gmail.com. Run this script at your own risk. I do not accept responsibility for any loss or damage that you suffer as a result of using this script.