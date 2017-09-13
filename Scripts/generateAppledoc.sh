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
  --docset-atom-filename "${PROJECT_NAME}.atom" \
  --docset-bundle-filename "${PROJECT_NAME}.docset" \
  --docset-feed-url "${companyURL}/${company}/%DOCSETATOMFILENAME" \
  --output "${DOCS_DIR}" \
  --no-install-docset \
  --create-docset \
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
  "${PROJECT_DIR}/Core" "${PROJECT_DIR}/Sources"

if [ $? -eq 0 ]; then
  rm -fr "${DOCS_DIR}/${PROJECT_NAME}.iOS.SDK.docset"
  mv -f "${DOCS_DIR}/docset" "${DOCS_DIR}/${PROJECT_NAME}.iOS.SDK.docset"
else
  exit 2;
fi
