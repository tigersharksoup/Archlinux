#!/bin/bash
# Variable (you can change any of these to your liking)
real_wall_dir=~/Pictures
temp_wall_dir=/tmp/wallpaper_interfacelift
expire_wall_date=30
url_wall_link=http://interfacelift.com/wallpaper/downloads/random/wide_16:9/1920x1080/

# create folders
mkdir -p $real_wall_dir	
mkdir -p $temp_wall_dir

cd $temp_wall_dir

# download wallpapers from site
wget -U "Mozilla/5.0" $(lynx --dump $url_wall_link | awk '/7yz4ma1/ && /jpg/ && !/html/ {print $2}')

# delete any file under 50k in size (to avoid shitty thumnbails or crap quality)
find . -type f -iname "*.jp*g" -size -50k -exec rm {} \;

# change the downloaded wallpaper metadata (modified date to todays date)
#  this makes it easy to see which files are older to delete later on
find . -type f -iname "*.jp*g" -exec touch -m {} \;

# now that everything is cleaned and filter
#  send the downloaded images to the wallpaper folder 
find . -type f -iname "*.jp*g" -exec mv {} $real_wall_dir \;

#  delete wallpaper image older then X days and remove temp folder
rm -rf $temp_wall_dir
find $real_wall_dir -mtime +$expire_wall_date -exec rm {} \;
