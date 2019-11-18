#!/bin/bash 

PACKMAN=apt-get

if [ `uname | grep "Darwin"` ];then
  PACKMAN=brew
elif [ `uname | grep "MSYS"` ];then
  PACKMAN=packman
fi

if [ "$PACKMAN" == "apt-get" ];then
  wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
  sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
  apt-get update
  #install common packages

  #install development packages
  apt-get install -y libltdl7
  apt-get install -y --no-install-recommends build-essential automake autoconf autogen libtool flex bison pkg-config g++ cmake scons ggcov lcov curl unzip sloccount git git-core jenkins doxygen ttf-dejavu subversion
  apt-get install -y cppcheck clang-tidy clang valgrind clang-format
  apt-get install -y ninja-build graphviz plantuml
  apt-get install -y python-pip

  #install python development packages
  python -m pip install --upgrade pip
  pip install Sphinx
  pip install breathe
  pip install exhale
  pip install sphinx_rtd_theme

  #install packages needed for app


  #install cross toolchain

  #start services
  service jenkins restart
elif [ "$PACKMAN" == "pacman" ]; then
  pacman-key --init
  pacman -Syu
  pacman -S mingw-w64-x86_64-cmake mingw-w64-x86_64-extra-cmake-modules
  pacman -S mingw-w64-x86_64-make
  pacman -S mingw-w64-x86_64-gdb
  pacman -S mingw-w64-x86_64-toolchain
  export PATH=$PATH:/mingw64/bin/
  pacman -S clang mingw-w64-x86_64-clang-tools-extra mingw-w64-x86_64-clang-analyzer
  pacman -S git doxygen subversion ninja
  pacman -S mingw-w64-x86_64-cppcheck mingw-w64-x86_64-graphviz mingw-w64-x86_64-lcov
elif [ "$PACKMAN" == "brew" ]; then
  brew install llvm doxygen cppcheck graphviz
fi
