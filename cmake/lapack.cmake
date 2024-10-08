if(intsize64)
  if(MKL IN_LIST LAPACK_COMPONENTS)
    list(APPEND LAPACK_COMPONENTS MKL64)
  else()
    if(NOT (OpenBLAS IN_LIST LAPACK_COMPONENTS
      OR Netlib IN_LIST LAPACK_COMPONENTS
      OR Atlas IN_LIST LAPACK_COMPONENTS
      OR MKL IN_LIST LAPACK_COMPONENTS))
      if(DEFINED ENV{MKLROOT})
        list(APPEND LAPACK_COMPONENTS MKL MKL64)
      endif()
    endif()
  endif()
endif()

find_package(LAPACK REQUIRED COMPONENTS ${LAPACK_COMPONENTS})
