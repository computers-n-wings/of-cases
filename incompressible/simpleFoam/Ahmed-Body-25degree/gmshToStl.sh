#!/bin/bash
options="-format stl"

rm joined.stl

for filename in *.brep ## or *.stp, change clscale and clmin/clmax to refine/coarsen mesh, lower values result in finer mesh.
do
  echo $filename
  if [[ $filename != wallG* ]] && [[ $filename == wall* ]]; 
  then
     gmsh $filename -2 -o ./${filename%\.*}.stl $options -clscale 0.5 -clmin 5 -clmax 10;
  else
     gmsh $filename -2 -o ./${filename%\.*}.stl $options -clscale 2 -clmin 20 -clmax 50;
  fi
  sed -i "s/Created by Gmsh/${filename%\.*}/g" "./${filename%\.*}.stl"
  cat "./${filename%\.*}.stl" >> "./joined.stl"
  rm "./${filename%\.*}.stl"  # to remove the individual stl files.
done;

