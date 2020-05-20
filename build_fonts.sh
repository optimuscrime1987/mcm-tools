#!/bin/bash
set -o nounset  # exit if trying to use an uninitialized var
set -o errexit  # exit if any program fails
set -o pipefail # exit if any program in a pipeline fails, also
set -x          # debug mode

projects=( betaflight cleanflight )
revisions=( 1 2 )
rm -rf build

for revision in "${revisions[@]}"; do
  for project in "${projects[@]}"; do
    fonts=( bold clarity default digital extra_large impact_mini impact large vision ${project} )

    mkdir -p build/fonts/${project}/${revision}
    mkdir -p build/fonts/logos
    python png2mcm.py -i logos/${project}.png -o build/fonts/logos/${project}-logo.mcm -x 24 -y 4 -s 160


    for font in "${fonts[@]}"; do
      cp fonts/${project}/${revision}/${font}.mcm build/fonts/${project}/${revision}/${font}.mcm
      python copy2mcm.py -i build/fonts/logos/${project}-logo.mcm -o build/fonts/${project}/${revision}/${font}.mcm -f 160 -t 160 -c 96

      mkdir -p dist/${project}-configurator/resources/osd/${revision}
      cp build/fonts/${project}/${revision}/${font}.mcm dist/${project}-configurator/resources/osd/${revision}
    done
  done
done
