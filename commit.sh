#! /bin/bash

if [ $# -ne 1 ]; then
 echo "Usage: $0 your_image_name"
 exit 1
fi

image=${1}
tmp_image=${image#*\/}
gen_image=${tmp_image//[\/:]/-}

git checkout .
git pull 
echo "From ${image}" > Dockerfile
echo "====== Dockerfile has changed to ======"
cat Dockerfile
echo "======================================="
echo "start to commit change for image [${image}]"
git add .
git commit -m "add images '${image}'"
git tag release-v${gen_image}
git push --tags
if [ $? -eq 0 ]; then
 echo -e "success\n"
else
 echo -e "fail\n"
fi
