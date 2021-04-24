#!/bin/sh

#  import_frameworks.sh
#  Pods
#
#  Created by Julien Grand-Chavin on 24/04/2021.
#  


echo "${PODS_TARGET_SRCROOT}"
echo "$CONFIGURATION"


rm -rf "${PODS_TARGET_SRCROOT}/LofeltHaptics.framework"


cp -R "${PODS_TARGET_SRCROOT}/Environements/$CONFIGURATION/LofeltHaptics.framework" "${PODS_TARGET_SRCROOT}"
