
if(NOT "E:/GitHub/gtzhai/cleanCppProject/3rd/Catch/src/Catch_download-stamp/Catch_download-gitinfo.txt" IS_NEWER_THAN "E:/GitHub/gtzhai/cleanCppProject/3rd/Catch/src/Catch_download-stamp/Catch_download-gitclone-lastrun.txt")
  message(STATUS "Avoiding repeated git clone, stamp file is up to date: 'E:/GitHub/gtzhai/cleanCppProject/3rd/Catch/src/Catch_download-stamp/Catch_download-gitclone-lastrun.txt'")
  return()
endif()

execute_process(
  COMMAND ${CMAKE_COMMAND} -E remove_directory "E:/GitHub/gtzhai/cleanCppProject/3rd/Catch/src/Catch_download"
  RESULT_VARIABLE error_code
  )
if(error_code)
  message(FATAL_ERROR "Failed to remove directory: 'E:/GitHub/gtzhai/cleanCppProject/3rd/Catch/src/Catch_download'")
endif()

# try the clone 3 times in case there is an odd git clone issue
set(error_code 1)
set(number_of_tries 0)
while(error_code AND number_of_tries LESS 3)
  execute_process(
    COMMAND "D:/Program Files/Git/cmd/git.exe"  clone  "https://github.com/catchorg/Catch2.git" "Catch_download"
    WORKING_DIRECTORY "E:/GitHub/gtzhai/cleanCppProject/3rd/Catch/src"
    RESULT_VARIABLE error_code
    )
  math(EXPR number_of_tries "${number_of_tries} + 1")
endwhile()
if(number_of_tries GREATER 1)
  message(STATUS "Had to git clone more than once:
          ${number_of_tries} times.")
endif()
if(error_code)
  message(FATAL_ERROR "Failed to clone repository: 'https://github.com/catchorg/Catch2.git'")
endif()

execute_process(
  COMMAND "D:/Program Files/Git/cmd/git.exe"  checkout origin/master --
  WORKING_DIRECTORY "E:/GitHub/gtzhai/cleanCppProject/3rd/Catch/src/Catch_download"
  RESULT_VARIABLE error_code
  )
if(error_code)
  message(FATAL_ERROR "Failed to checkout tag: 'origin/master'")
endif()

execute_process(
  COMMAND "D:/Program Files/Git/cmd/git.exe"  submodule update --recursive --init 
  WORKING_DIRECTORY "E:/GitHub/gtzhai/cleanCppProject/3rd/Catch/src/Catch_download"
  RESULT_VARIABLE error_code
  )
if(error_code)
  message(FATAL_ERROR "Failed to update submodules in: 'E:/GitHub/gtzhai/cleanCppProject/3rd/Catch/src/Catch_download'")
endif()

# Complete success, update the script-last-run stamp file:
#
execute_process(
  COMMAND ${CMAKE_COMMAND} -E copy
    "E:/GitHub/gtzhai/cleanCppProject/3rd/Catch/src/Catch_download-stamp/Catch_download-gitinfo.txt"
    "E:/GitHub/gtzhai/cleanCppProject/3rd/Catch/src/Catch_download-stamp/Catch_download-gitclone-lastrun.txt"
  RESULT_VARIABLE error_code
  )
if(error_code)
  message(FATAL_ERROR "Failed to copy script-last-run stamp file: 'E:/GitHub/gtzhai/cleanCppProject/3rd/Catch/src/Catch_download-stamp/Catch_download-gitclone-lastrun.txt'")
endif()

