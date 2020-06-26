#! /usr/bin/env sh

APP_ICON_SOURCE="AppIcon.png"
APP_ICON_SIZES=(\
    "20x20" \
    "29x29" \
    "40x40" \
    "58x58" \
    "60x60" \
    "76x76" \
    "80x80" \
    "87x87" \
    "120x120" \
    "152x152" \
    "167x167" \
    "180x180" \
    "1024x1024"
)

for icon_size in "${APP_ICON_SIZES[@]}"
do
   :
   convert ${APP_ICON_SOURCE} -resize ${icon_size} AppIcon-${icon_size}.png
done

