#!/usr/bin/env bash
set -e

NAME="$1"
SAFE_NAME="$2"

if [ -z "$NAME" ] || [ -z "$SAFE_NAME" ]; then
	echo "Usage: ./scripts/change_template.sh PluginName plugin_func_name"
	exit 1
fi

echo "Changing plugin to $NAME ($SAFE_NAME)"

mv iOSPluginTemplate "$NAME"
mv iOSPluginTemplate.xcodeproj "$NAME.xcodeproj"

for FILE in $(find "$NAME" -type f); do
	sed -i tmp "s/iOSPluginTemplate/$NAME/" "$FILE"
	sed -i tmp "s/ios_plugin_template/$SAFE_NAME/" "$FILE"
	mv "$FILE" $(echo "$FILE" | sed s/iOSPluginTemplate/$NAME/)
done

for FILE in $(find "$NAME.xcodeproj" -type f); do
	sed -i tmp "s/iOSPluginTemplate/$NAME/" "$FILE"
	sed -i tmp "s/ios_plugin_template/$SAFE_NAME/" "$FILE"
	mv "$FILE" $(echo "$FILE" | sed s/iOSPluginTemplate/$NAME/)
done

