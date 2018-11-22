#!/bin/bash

echo "i am $(whoami) with id $(id -g)"

if [ ! $PANDOCCMD ]
then
  echo "pandoc.sh no PANDOCCMD found, setting default one"
  PANDOCCMD="pandoc --listings --pdf-engine=xelatex"
fi

if [ $TEMPLATELINK ]
then
  echo "pandoc.sh Downloading template $TEMPLATELINK to $HOME/.pandoc/templates/default.latex"

  mkdir -p $HOME/.pandoc/templates
  wget $TEMPLATELINK -O $HOME/.pandoc/templates/default.latex
fi

compile () {
  for f in $@; do
    if [ "${f##*.}" == "md" ]; then


      echo $PANDOCCMD /gitfolder/$f -o /cgitfolder/${f%.*}.pdf
      mkdir -p ./build/${f%/*}

      $PANDOCCMD $f -o ./build/${f%.*}.pdf
    fi
  done
}



if [ ! -d "/build" ]; then
  echo "pandoc.sh /cgitgolder not found, generating"
  mkdir /build
fi


compile $(find . -name '*.md*')
