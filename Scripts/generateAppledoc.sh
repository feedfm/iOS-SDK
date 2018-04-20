#/bin/bash

# Documentation generation script. https://github.com/tomaz/appledoc

type appledoc >/dev/null 2>&1 || { 
  echo >&2 "I require appledoc but it's not installed. Please visit https://github.com/tomaz/appledoc follow installation instructions";
  exit 0; 
}

PROJECT_TITLE="FeedMedia iOS SDK"
DOCS_DIR="${PROJECT_DIR}/Docs"
company="Feed Media";
companyID="fm.feed";
companyURL="http://feed.fm";
target="iphoneos";

mkdir -p ${DOCS_DIR}

/usr/local/bin/appledoc \
  --project-name "${PROJECT_TITLE}" \
  --project-company "${company}" \
  --company-id "${companyID}" \
  --output "${DOCS_DIR}" \
  --create-html \
  --no-install-docset \
  --no-create-docset \
  --no-install-docset \
  --no-publish-docset \
  --keep-intermediate-files \
  --docset-platform-family "${target}" \
  --logformat xcode \
  --no-repeat-first-par \
  --explicit-crossref \
  --search-undocumented-doc \
  --ignore "*.m" \
  --ignore "FeedMedia.h" \
  --exit-threshold 2 \
  --verbose 5 \
  "${PROJECT_DIR}/Core" "${PROJECT_DIR}/Sources" \
  2> >(grep -v CWStatusBar)

if [ $? -eq 0 ]; then
  echo 'success!'
else
  exit 2;
fi
