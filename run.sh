#!/bin/bash


# get and/or check PROOJECTNAME
# PROJ_NAME="heimdal"
# PROJ_NAME="IBM Watson Connectors Example Project"
PROJ_NAME="mytest" # this worked on heimdal.mpk

# get and/or check MPK
# MPK_NAME=heimdal.mpk
MPK_NAME=$1
# MPK_NAME=$PROJ_NAME.mpk

#run
MXPROJECT_NAME=$PROJ_NAME  MXTEMPLATE_MPK=$MPK_NAME node index.js
