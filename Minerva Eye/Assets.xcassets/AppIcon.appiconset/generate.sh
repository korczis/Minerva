#! /usr/bin/env sh

APP_ICON_SOURCE="../../../Assets/logo/minerva.png"
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
   APP_ICON_NAME=AppIcon-${icon_size}.png
   echo "Generating ${APP_ICON_NAME}"
   convert ${APP_ICON_SOURCE} -background black -alpha remove -resize ${icon_size} ${APP_ICON_NAME}
done

