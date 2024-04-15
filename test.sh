my_array=("anet" "anetdv_new" "anetlv_new")
for file in "${my_array[@]}"
do
    #ln -s vid_slowfast data/$file
    #ln -s vid_clip data/$file
    echo $file
done