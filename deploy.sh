#!/bin/bash
# run in MASTER_DIR
set -x
set -e

MESSAGE=$1

MASTER_DIR="$(pwd)"
GHPAGE_DIR="${MASTER_DIR}/gh-pages"
NOTE_NAME="docker-notes"

# build
gitbook build

# clean GHPAGE_DIR
if [ ! -d $GHPAGE_DIR  ];then
    git clone -b gh-pages https://github.com/huweihuang/${NOTE_NAME}.git gh-pages
fi
rm -fr ${GHPAGE_DIR}/*

# copy _book to GHPAGE_DIR
cp -fr ${MASTER_DIR}/_book/* ${GHPAGE_DIR}
cp -fr ${MASTER_DIR}/README.md ${GHPAGE_DIR}

# git commit
cd ${GHPAGE_DIR}
git add --all
git commit -m "${MESSAGE}"
git push origin gh-pages
