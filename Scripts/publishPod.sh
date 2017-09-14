#!/bin/bash

# quit on error
set -e 

cd "${PROJECT_DIR}"

#
# make sure the pod lints
#

export LANG=en_US.UTF-8
pod lib lint --allow-warnings   

# pick the release version out of the podspec

VERSION=`cat FeedMedia.podspec | perl -n -e '/s.version\s*=\s*"(.*)"/ && print $1;'`

# confirm we haven't already deployed this version

if git tag | grep "v${VERSION}\$"; then
  echo "Code already tagged - you must create a new version"
  exit 1
fi

# confirm the release version matches the FeedMediaCore.h #define:

CHANGE=`grep "FEED_MEDIA_CLIENT_VERSION @\"${VERSION}\"" ${PROJECT_DIR}/../FeedMediaCore/Sources/FeedMediaCore.h`

if [[ $CHANGE = "" ]]; then
  echo "This release version (${VERSION}) does not match FeedMediaCore.h"
  exit 1
fi

# confirm the release version is in the CHANGELOG

CHANGE=`grep "v${VERSION}" "${PROJECT_DIR}/CHANGELOG.md"`
if [[ $CHANGE = "" ]]; then
  echo "This release version (${VERSION}) has no entry in the CHANGELOG"
  exit 1
fi

#
# confirm everything is checked in
#

STATUS=$(git status --porcelain 2> /dev/null)
if [[ "$STATUS" != "" ]]; then
  echo 'Project not checked in - unable to deploy!'
  exit 1
fi

cd ..

STATUS=$(git status --porcelain 2> /dev/null)
if [[ "$STATUS" != "" ]]; then
  echo 'Workspace not checked in - unable to deploy!'
  exit 1
fi

cd -

#
# Tag repo
#

git tag  -a -m "Release of version ${VERSION}" "v${VERSION}"

git push
git push --tags

#
# publish appledoc
#

ssh feed@static0.feed.fm "cd demo.feed.fm/sdk/docs/ios && rm -fr $VERSION && mkdir $VERSION && rm -f latest && ln -s $VERSION latest"
scp -r Docs/* feed@static0.feed.fm:demo.feed.fm/sdk/docs/ios/$VERSION

#
# Publish to CocoaPod repo
#

pod trunk push FeedMedia.podspec

