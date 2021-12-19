#!/bin/sh
set -e

export GATSBY_DIR="/home/node"
export PATH="$PATH:/usr/local/bin/gatsby"

# Initialize Gatsby or run NPM install if needed
if [ ! -f "$GATSBY_DIR/package.json" ]
then
  echo "Initializing Gatsby..."
  gatsby new $GATSBY_DIR/tmptrepepe
  mv $GATSBY_DIR/tmptrepepe/*  $GATSBY_DIR
  rm -rf $GATSBY_DIR/tmptrepepe
fi
find $GATSBY_DIR/node_modules/ -empty -type d -exec npm install \;


# Decide what to do
if  [ "$1" == "develop" ]
then
  rm -rf $GATSBY_DIR/public
  gatsby develop --host 0.0.0.0 --port 8008

elif  [ "$1" == "build" ]
then
  rm -rf $GATSBY_DIR/public
  gatsby build

elif  [ "$1" == "stage" ]
then
  rm -rf $GATSBY_DIR/public
  gatsby build
  gatsby serve --host 0.0.0.0 --port 8008

else
  exec $@

fi