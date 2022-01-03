#!/bin/bash -x

ROOT=$(git rev-parse --show-toplevel)
TMPD=$(mktemp -d /tmp/latexdiff.XXXXXXXXXX)
HERE=$(realpath --relative-to=$ROOT $(pwd))

mkdir -p $TMPD

OLD_REPO=$TMPD/old

git clone $ROOT $OLD_REPO

cd $OLD_REPO
git checkout $1

NEWD=$ROOT/$HERE
OLDD=$OLD_REPO/$HERE

cd $OLDD
make
latexdiff --flatten main.tex $NEWD/main.tex > diff.tex

make DOC=diff.tex
cp -f diff.pdf $NEWD/diff.pdf