#!/bin/bash

echo "i am $(whoami) with id $(id -g)"

if [ ! $PANDOCCMD ]
then
  echo "pandoc.sh no PANDOCCMD found, setting default one"
  PANDOCCMD="pandoc --filter pandoc-include-code --pdf-engine=pdflatex"
fi

if [ $TEMPLATELINK ]
then
  echo "pandoc.sh Downloading template $TEMPLATELINK to $HOME/.pandoc/templates/default.latex"

  mkdir -p $HOME/.pandoc/templates
  wget $TEMPLATELINK -O $HOME/.pandoc/templates/default.latex
fi

compile () {
      echo $PANDOCCMD $1 -o build/${f%.*}.pdf
      mkdir -p ./build/${1%/*}
      $PANDOCCMD $1 -o ./build/${1%.*}.pdf
}



if [ ! -d "/build" ]; then
  echo "pandoc.sh /build not found, generating"
  mkdir /build
fi

export -f compile
paralell compile ::: $(find . -name '*.md*')
