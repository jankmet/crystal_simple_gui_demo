#!/bin/bash

SFML_LIB=$"/home/jan/Documents/dev/media/SFML-2.3.2/lib"
CSFML_LIB=$"/home/jan/Documents/dev/media/CSFML-2.3/lib"

F=${1%.*}

LD_LIBRARY_PATH="$SFML_LIB:$CSFML_LIB" crystal build --link-flags "-L$SFML_LIB -L$CSFML_LIB" $F.cr &&
LD_LIBRARY_PATH="$SFML_LIB:$CSFML_LIB" ./$F
