# ----------------------------------------------------------------------------
#
# Non-VCS-Workspace to GIT-VCS-Workspace Transformer
# Maintainer:   Daniel Bongartz <daniel.bongartz@gmail.com>
# Last Change:  2013 Juni
#
# ----------------------------------------------------------------------------

# run this script via `gitalizer.sh path_to_workspace path_to_repository` 

# This Script transforms your non-vcs workspace to a git-vcs workspace
# by executing the following tasks:
#  
# 1. creating a subfolder in path_to_repository for each subfolder in path_to_workspace 
# 2. backing up each subfolder in path_to_workspace to ~/Desktop/Backup/
# 3. deleting all subfolders in path_to_workspace
# 4. initialising a git bare repository for each folder in path_to_repository
# 5. cloning each repository in path_to_repository to path_to_workspace
# 6. copying backed project contents to corresponding cloned project in path_to_workspace
# 7. adding files to staging area, commit and push them
# 8. deleting Backup folder
#    You can enable/disable deleting the backup folder task by toggling the corresponding comment at the end

set -e
path_to_workspace=$1
path_to_repository=$2
date=$(date +"%Y%m%d%H%M%S")
backup_dir=~/Desktop/Backup_$date

if [ -z "$path_to_workspace" ] && [ -z "$path_to_repository" ]
then

        echo "[ERROR]: parameters not set"
        echo "run: gitalizer.sh path_to_workspace path_to_repository"
else
            
        # Loop over all {path_to_workspace} subfolders 
        # and create a folder for each subfolder in {path_to_repository}
        # and make a backup of {path_to_workspace} subfolders

        echo "### creating reporitory structure from workspace structure ###"

        mkdir $backup_dir

        for current_dir in "$path_to_workspace"/*; do
                
                if [[ -d "$current_dir" ]]
                then

                        projectname=`basename "$current_dir"`                

                        echo "creating repo folder $path_to_repository/$projectname"
                        mkdir "$path_to_repository/$projectname"

                        echo "creating backup of $current_dir in $backup_dir"                
                        echo "cp -r $current_dir $backup_dir"
                        cp -r "$current_dir" "$backup_dir"


                        echo "deleting $current_dir"
                        rm -rf "$current_dir" 

                        echo "### Cloning Repository Structure to Workspace ###"

                else                        
                        echo "[ERROR]: file is not a directory."
                        echo "File: "$current_dir""
                        echo "skipping..."
                fi                
        done


        # Loop over {path_to_repository} subfolders
        # and clone them into {path_to_workspace}        

        for current_dir in "$path_to_repository"/*; do   

                if [[ -d "$current_dir" ]]
                then

                        cd "$current_dir"

                        projectname=`basename "$current_dir"`

                        echo "creating bare repo in $current_dir"
                        git init --bare        

                        echo "cloning $current_dir to $path_to_workspace/$projectname"
                        git clone "$current_dir" "$path_to_workspace/$projectname"

                        cd ..
                        
                        echo "### copying backed project content to path_to_workspace subfolders ###"
                fi

        done


        # Loop over backed folders
        # and copy content to {path_to_workspace} subfolders        

        for current_dir in $backup_dir/*; do

                if [[ -d "$current_dir" ]]
                then
                               
                        cd "$current_dir"

                        projectname=`basename "$current_dir"`

                        echo "copying $current_dir to $path_to_workspace/$projectname"
                        cp -r * "$path_to_workspace/$projectname"      

                        echo "### add / commit new files to repository ###"
                fi
        done


        # Loop over brand new git repos 
        # add all files to staging area, commit and push them        

        for current_dir in $path_to_workspace/*; do

                if [[ -d "$current_dir" ]]
                then

                        cd "$current_dir"

                        echo "creating .gitignore file"
                        printf ".metadata/\n/bin\n/gen" > .gitignore

                        echo "show status of local repo"
                        git status
                        
                        echo "add files to staging area"
                        git add .
                        
                        echo "commit staged files"
                        git commit -m "initial commit"

                        echo "push to origin master"
                        git push origin master

                        cd ..
                fi
        done

        # enable only if you know what you're doing!
        # rm -rf $backup_dir

fi