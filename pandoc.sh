#!/bin/bash

echo "i am $(whoami) with id $(id -g)"

if [ ! $PANDOCCMD ]
then
  echo "pandoc.sh no PANDOCCMD found, setting default one"
  export PANDOCCMD="pandoc --filter pandoc-include-code --pdf-engine=pdflatex"
fi

if [ $TEMPLATELINK ]
then
  echo "pandoc.sh Downloading template $TEMPLATELINK to $HOME/.pandoc/templates/default.latex"

  mkdir -p $HOME/.pandoc/templates
  wget $TEMPLATELINK -O $HOME/.pandoc/templates/default.latex
fi

compile () {
      mkdir -p build/${1%/*}
      OLDPWD=$PWD
      pushd ${1%/*}
      $PANDOCCMD $(basename $1) -o $OLDPWD/build/${1%.*}.pdf
      echo $PANDOCCMD $(basename $1) -o $OLDPWD/build/${1%.*}.pdf
      popd
}



if [ ! -d "build" ]; then
  echo "pandoc.sh /build not found, generating"
  mkdir build
fi

export -f compile
parallel compile ::: $(find . -name '*.md*')
