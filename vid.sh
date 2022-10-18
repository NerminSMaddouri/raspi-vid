dir_of_jpegs=new_timelapse
output_dir=./
video_filename=output.avi

print_usage() {
  printf "\nUsage:\n"
  printf "\n$0 --dir-of-jpegs=<directory/path> --video-filename=<filename>\n\n"
}
echo " pwd: $(pwd)"

for arg in "$@"; do
  case $arg in
    --dir-of-jpegs=*)
      temp_dir_of_jpegs="$(echo $arg | awk -F= '{print $2}')";;

    --video-filename=*)
      temp_video_filename="$(echo $arg | awk -F= '{print $2}')";;
    --output-dir=*)
      temp_output_dir="$(echo $arg | awk -F= '{print $2}')";;
  esac
done

if [ -z "$temp_dir_of_jpegs" ]; then
  echo 'Missing directory of jpegs. Exiting...'
  print_usage
  exit 1
fi
dir_of_jpegs="$temp_dir_of_jpegs"

if [ -z "$temp_video_filename" ]; then
  echo 'Missing video output filename. Exiting...'
  print_usage
  exit 1
fi
video_filename="$temp_video_filename"

if [ -n "$temp_output_dir" ]; then
  output_dir="$temp_output_dir"
fi

echo "dir of jpegs: $dir_of_jpegs"
echo "video_filename: $video_filename"
echo "output dir: $output_dir"

pushd $dir_of_jpegs

ls -1tr | grep -v filenames.txt > filenames.txt

echo 'running mencoder'
echo " pwd: $(pwd)"
mencoder    \
  -nosound  \
  -noskip   \
  -oac copy \
  -ovc copy \
  -o $video_filename \
  -mf fps=20 'mf://@filenames.txt'

popd

mv "${dir_of_jpegs}/${vid}" .
