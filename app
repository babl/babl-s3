#!/bin/bash -x

file=$(mktemp)
cat > $file

if [[ $CONTENTTYPE && ${CONTENTTYPE-x} ]]; then
  contentType="--content-type $CONTENTTYPE"
fi

out=$(aws s3 cp --acl ${ACL-private} $contentType $file s3://$BUCKET$FILE)

exitcode=$?

if [ $exitcode -eq 0 ]; then
  echo $out | sed -r -e "s/.*s3:\/\/([^\/]+)(\/.*)$/https:\/\/\1.s3.amazonaws.com\2/"
fi

rm $file

exit $exitcode
