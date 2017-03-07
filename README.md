# mcm-tools
MAX7456 font management command line tools

## cleanflight/betaflight notes

the fonts/ directory contains source fonts.
the logos/ directory contains logos.

logos are 288x72 pixels, 32bit color with transparency.
only three "colors" can be rendered by the max7456 osd, black/white/transparent.
288x72 is chosen because each logo is 24x4 characters wide and each font character is 12x18 pixels.

the build_fonts.sh is used to create fonts with the logos in them, and then all the non-logo characters from the source fonts
are copied into the new fonts with logos.

the script will create a build/ directory which is a temporary directory and can be deleted at any time.
the script will also create a dist/ directory, one for each configurator app that needs fonts.

once the fonts in the dist/ directory have been checked, you can replace the source fonts with the new versions of the fonts.

the /build and /dist directories should NOT be included in the source repo.

the /fonts/legacy directory contains legacy fonts.  earlier versions of this project used them as source files and moved (remapped) some characters in the destination fonts.
If the mwosd fonts need updating then create a new script to do this. 

the script makes some hardcoded assumptions about the names of projects and the fonts based on the current requirements of the tool.

