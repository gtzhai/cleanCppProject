#!/bin/bash


build(){
  if [ ! -d build ];then
    mkdir build
  fi
  cd build

  if [ `which ninja` ];then
    cmake $CMAKE_OPTION -GNinja ..
    ninja all doc
  else
    #cmake -G "MSYS Makefiles"
    #cmake -G "Visual Studio 14 2015" ..
    cmake $CMAKE_OPTION ..
    make -j8
  fi
}

clean(){
  if [ -d build ];then
    rm build -rf
  fi
}

format(){
  if [ `which clang-format` ];then
    find ./src -type f -regex .*\\.h\\\|.*\\.hpp\\\|.*\\.hxx\\\|.*\\.c\\\|.*\\.cpp\\\|.*\\.cxx\\\|.*\\.cc -exec clang-format -i {} \;
  fi
}

tidy(){
  if [ `which clang-tidy` ];then
    find ./src -type f -regex .*\\.h\\\|.*\\.hpp\\\|.*\\.hxx\\\|.*\\.c\\\|.*\\.cpp\\\|.*\\.cxx\\\|.*\\.cc -exec clang-tidy -p build/compile_commands.json {} \;
  fi
}

case "$1" in
    clean)
        clean
        echo "Clean Done"
        ;;
    format)
        format 
        echo "Format Done"
        ;;
    tidy)
        tidy 
        ;;
    cover)
        CMAKE_OPTION=" -DCOVERAGE=ON "
        build
        ;;
    addrsani)
        CMAKE_OPTION=" -DADDRESS_SANITIZER=ON "
        build
        ;;
    *)
        build
        echo "Build Done"
        ;;
esac

