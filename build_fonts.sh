#!/bin/bash
set -o nounset  # exit if trying to use an uninitialized var
set -o errexit  # exit if any program fails
set -o pipefail # exit if any program in a pipeline fails, also
set -x          # debug mode

projects=( betaflight cleanflight )

rm -rf build

for project in "${projects[@]}"; do
  fonts=( bold default large extra_large digital ${project} )

  mkdir -p build/fonts/${project}
  mkdir -p build/fonts/logos
  python png2mcm.py -i logos/${project}.png -o build/fonts/logos/${project}-logo.mcm -x 24 -y 4 -s 160


  for font in "${fonts[@]}"; do
    cp fonts/${project}/${font}.mcm build/fonts/${project}/${font}.mcm
    python copy2mcm.py -i build/fonts/logos/${project}-logo.mcm -o build/fonts/${project}/${font}.mcm -f 160 -t 160 -c 96

    mkdir -p dist/${project}-configurator/resources/osd
    cp build/fonts/${project}/${font}.mcm dist/${project}-configurator/resources/osd/
  done
done
