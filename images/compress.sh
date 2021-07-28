#/usr/bin/env bash

if ! command -v jpegoptim &>/dev/null; then
  echo 'Install jpegoptim: sudo apt install jpegoptim -y'
  exit 1
fi

if ! command -v convert &>/dev/null; then
  echo 'Install imagemagick: sudo apt install imagemagick -y'
  exit 1
fi

NEW_WIDTH=2500

find . -type f -name "*.jpg" -not -name "*_compressed.jpg" -print0 | while read -d $'\0' file
do
    FILE_HEIGHT=$(identify -format "%h" $1)
    FILENAME="${file%.*}"
    OUT="${FILENAME}_compressed.jpg"
    convert $file -resize "${NEW_WIDTH}x${FILE_HEIGHT}"\> $OUT
    jpegoptim $OUT --max=90 --strip-all
done
