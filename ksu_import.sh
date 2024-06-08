#!/bin/bash

echo Importing KSU...

KSU_DIR=drivers/staging/kernelsu
if [ -d "$KSU_DIR" ]; then
    echo "$KSU_DIR directory exists. Removing it!"
    rm -rf drivers/staging/kernelsu
    echo "Commit changes and re-run the script"
else
    if git ls-remote --exit-code kernelsu; then
        echo "kernelsu remote exists. Fetching..."
        git fetch kernelsu
    else
        echo "Adding kernelsu remote..."
        git remote add kernelsu https://github.com/balgxmr/KernelSU.git
        git fetch kernelsu
    fi

    if git ls-remote --heads kernelsu yes; then
        git read-tree --prefix=drivers/staging/kernelsu/ -u kernelsu/yes
        echo "Done. Now commit changes."
    else
        echo "Error: Branch 'yes' does not exist in remote 'kernelsu'."
    fi
fi

