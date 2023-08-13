#!/bin/bash

if [[ $1 == "--pdf" ]]; then
  echo "Building PDF..."
    asciidoctor-pdf \
    -a toc \
    -a sectnums \
    -a reproducible \
    -a icons=font \
    -a source-highlighter=Pygments \
    -a experimental \
    -r asciidoctor-diagram \
    -R src \
    -D build \
    '**/*.adoc'
elif [[ $1 == "--html" ]]; then
  echo "Building HTML..."
    asciidoctor \
    -a data-uri \
    -a toc=left \
    -a sectnums \
    -a reproducible \
    -a icons=font \
    -a source-highlighter=Pygments \
    -a experimental \
    -r asciidoctor-diagram \
    -R src \
    -D build \
    '**/*.adoc'
else
    echo "Usage: build-asciidoc.sh [--pdf|--html]"
    exit 1
fi
