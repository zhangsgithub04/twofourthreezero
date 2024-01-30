#!/bin/bash
#c="Grid"
#grep -o "import.*$c.*from *'@mui/material" -R boardx_client/src | wc -l
#grep -o "import.*$c.*from *'@mui/material" -R boardx_client/src
#num=$(grep -o "import.*$c.*from *'@mui/material" -R boardx_client/src | wc -l)
#echo $c $num

echo "Start....."
counter=0
while IFS= read -r c; do
  ((counter++))
  c="${c## }"   # Removes leading whitespace
  c="${c%% }"   # Removes trailing whitespace

  num=$(grep -o "import.*$c.*from *'@mui/material" -R boardx_client/src | wc -l)
  num2=$(grep -o "$c" -R boardx_client/src | wc -l)
  #echo $counter: $c was imported $num times and was referenced $num2 times.
  echo $counter: $c $num $num2

  # You can process the line here as needed

done < componentlist


echo "done"
