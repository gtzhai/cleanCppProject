#!/bin/bash

build(){
  if [ ! -d build ];then
    mkdir build
  fi
  cd build

  if [ `which ninja` ];then
    cmake -GNinja ..
    ninja all doc
  else
    #cmake -G "MSYS Makefiles"
    #cmake -G "Visual Studio 14 2015" ..
    cmake ..
    make -j8
  fi
}

clean(){
  if [ -d build ];then
    rm build -rf
  fi
}

case "$1" in
    clean)
        clean
        echo "Clean Done"
        ;;
    *)
        build
        echo "Build Done"
        ;;
esac