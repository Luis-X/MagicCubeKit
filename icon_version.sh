#!/bin/sh
export PATH=/opt/local/bin/:/opt/local/sbin:$PATH:/usr/local/bin:

convertPath=`which convert`
gsPath=`which gs`

if [[ ! -f ${convertPath} || -z ${convertPath} ]]; then
convertValidation=true;
else
convertValidation=false;
fi

if [[ ! -f ${gsPath} || -z ${gsPath} ]]; then
gsValidation=true;
else
gsValidation=false;
fi

if [[ "$convertValidation" = true || "$gsValidation" = true ]]; then
echo "提示: 如需icon版本化，请使用brew安装ImageMagick和ghostscript字体"

if [[ "$convertValidation" = true ]]; then
echo "安装命令: brew install imagemagick"
fi
if [[ "$gsValidation" = true ]]; then
echo "安装命令: brew install ghostscript"
fi
exit 0;
fi

# 说明
# commit     git-提交哈希值
# branch     git-分支名
# version    app-版本号
# build_num  app-构建版本号

version=`/usr/libexec/PlistBuddy -c "Print CFBundleShortVersionString" "${CONFIGURATION_BUILD_DIR}/${INFOPLIST_PATH}"`
build_num=`/usr/libexec/PlistBuddy -c "Print CFBundleVersion" "${CONFIGURATION_BUILD_DIR}/${INFOPLIST_PATH}"`

# 检查当前所处Git分支
if [ -d .git ] || git rev-parse --git-dir > /dev/null 2>&1; then
commit=`git rev-parse --short HEAD`
branch=`git rev-parse --abbrev-ref HEAD`
else
commit=`hg identify -i`
branch=`hg identify -b`
fi;


shopt -s extglob
build_num="${build_num##*( )}"
shopt -u extglob
caption="${version}($build_num)\n${branch}\n${commit}"
echo $caption

function abspath() { pushd . > /dev/null; if [ -d "$1" ]; then cd "$1"; dirs -l +0; else cd "`dirname \"$1\"`"; cur_dir=`dirs -l +0`; if [ "$cur_dir" == "/" ]; then echo "$cur_dir`basename \"$1\"`"; else echo "$cur_dir/`basename \"$1\"`"; fi; fi; popd > /dev/null; }

function processIcon() {
base_file=$1

cd "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
base_path=`find . -name ${base_file}`

real_path=$( abspath "${base_path}" )
echo "base path ${real_path}"

if [[ ! -f ${base_path} || -z ${base_path} ]]; then
return;
fi

# TODO: if they are the same we need to fix it by introducing temp
target_file=`basename $base_path`
target_path="${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/${target_file}"

base_tmp_normalizedFileName="${base_file%.*}-normalized.${base_file##*.}"
base_tmp_path=`dirname $base_path`
base_tmp_normalizedFilePath="${base_tmp_path}/${base_tmp_normalizedFileName}"

stored_original_file="${base_tmp_normalizedFilePath}-tmp"
if [[ -f ${stored_original_file} ]]; then
echo "found previous file at path ${stored_original_file}, using it as base"
mv "${stored_original_file}" "${base_path}"
fi

# Release不执行
if [ $CONFIGURATION = "Release" ]; then
cp "${base_path}" "$target_path"
return 0;
fi

echo "Reverting optimized PNG to normal"
# 命名规范
echo "xcrun -sdk iphoneos pngcrush -revert-iphone-optimizations -q ${base_path} ${base_tmp_normalizedFilePath}"
xcrun -sdk iphoneos pngcrush -revert-iphone-optimizations -q "${base_path}" "${base_tmp_normalizedFilePath}"

# 将原图移动到空文件
echo "moving pngcrushed png file at ${base_path} to ${stored_original_file}"
#rm "$base_path"
mv "$base_path" "${stored_original_file}"

# 将原图按照命名规范重命名
echo "Moving normalized png file to original one ${base_tmp_normalizedFilePath} to ${base_path}"
mv "${base_tmp_normalizedFilePath}" "${base_path}"

width=`identify -format %w ${base_path}`
height=`identify -format %h ${base_path}`
band_height=$((($height * 50) / 100))
band_position=$(($height - $band_height))
text_position=$(($band_position - 8))
point_size=$(((12 * $width) / 100))

echo "Image dimensions ($width x $height) - band height $band_height @ $band_position - point size $point_size"

# 高斯模糊和文本
convert ${base_path} -blur 10x8 /tmp/blurred.png
convert /tmp/blurred.png -gamma 0 -fill white -draw "rectangle 0,$band_position,$width,$height" /tmp/mask.png
convert -size ${width}x${band_height} xc:none -fill 'rgba(0,0,0,0.2)' -draw "rectangle 0,0,$width,$band_height" /tmp/labels-base.png
convert -background none -size ${width}x${band_height} -pointsize $point_size -fill white -gravity center -gravity South caption:"$caption" /tmp/labels.png

convert ${base_path} /tmp/blurred.png /tmp/mask.png -composite /tmp/temp.png

rm /tmp/blurred.png
rm /tmp/mask.png

# 图片合成
filename=New${base_file}
convert /tmp/temp.png /tmp/labels-base.png -geometry +0+$band_position -composite /tmp/labels.png -geometry +0+$text_position -geometry +${w}-${h} -composite "${target_path}"

# 清除文件
rm /tmp/temp.png
rm /tmp/labels-base.png
rm /tmp/labels.png

echo "Overlayed ${target_path}"
}

icon_count=`/usr/libexec/PlistBuddy -c "Print CFBundleIcons~ipad:CFBundlePrimaryIcon:CFBundleIconFiles" "${CONFIGURATION_BUILD_DIR}/${INFOPLIST_PATH}" | wc -l`
last_icon_index=$((${icon_count} - 2))

i=0
while [  $i -lt $last_icon_index ]; do
icon=`/usr/libexec/PlistBuddy -c "Print CFBundleIcons~ipad:CFBundlePrimaryIcon:CFBundleIconFiles:$i" "${CONFIGURATION_BUILD_DIR}/${INFOPLIST_PATH}"`

if [[ $icon == *.png ]] || [[ $icon == *.PNG ]]
then
processIcon $icon
else
processIcon "${icon}.png"
processIcon "${icon}@2x.png"
processIcon "${icon}@3x.png"
fi
let i=i+1
done
