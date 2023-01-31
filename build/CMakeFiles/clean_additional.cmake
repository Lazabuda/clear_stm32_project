# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Debug")
  file(REMOVE_RECURSE
  "Appd.S"
  "Appd.bin"
  "Appd.hex"
  "Appd.map"
  )
endif()
