my_array=("anet_ft_out" "anetdv_ft_out" "anetlv_ft_out")
for file in "${my_array[@]}"
do
    if [ ! -d "out/$file" ]; then
        mkdir "out/$file"
    fi
done