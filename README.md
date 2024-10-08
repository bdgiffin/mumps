# MUMPS sparse solver

[![ci](https://github.com/scivision/mumps/actions/workflows/ci.yml/badge.svg)](https://github.com/scivision/mumps/actions/workflows/ci.yml)
[![ci_windows](https://github.com/scivision/mumps/actions/workflows/ci_windows.yml/badge.svg)](https://github.com/scivision/mumps/actions/workflows/ci_windows.yml)
[![intel-oneapi](https://github.com/scivision/mumps/actions/workflows/intel-oneapi.yml/badge.svg)](https://github.com/scivision/mumps/actions/workflows/intel-oneapi.yml)

CMake downloads the source tarfile from MUMPS developer websites and builds.
CMake builds MUMPS in parallel faster and more conveniently than the original Makefiles.
CMake allows easy reuse of MUMPS in external projects via CMake
[FetchContent](https://github.com/scivision/mumps-fetchcontent)
or ExternalProject or `cmake --install`.

Many compilers and systems are supported by CMake build system on Windows, MacOS and Linux.
Static (default) or Shared `cmake -DBUILD_SHARED_LIBS=on` MUMPS builds are supported.

Platforms known to work with MUMPS and CMake include:

* Windows (use -G Ninja or -G "MinGW Makefiles")
  * MSYS2 (GCC)
  * Windows Subsystem for Linux (GCC)
  * Intel oneAPI
  * Visual Studio (C code) + oneAPI (Fortran code)
* MacOS
  * GCC (Homebrew)
  * Intel oneAPI
* Linux
  * GCC
  * Intel oneAPI
  * NVIDIA HPC SDK
* Cray

The MUMPS project is distinct from this CMake script wrapper.
See the
[MUMPS Users email list](https://listes.ens-lyon.fr/sympa/subscribe/mumps-users)
for any questions about MUMPS itself.

## Build

From this repo's top directory:

```sh
cmake -B build
cmake --build build
```

With the default options, under the build/ directory this results in library binaries:

```
# Linux / MacOS / MSYS2
libdmumps.a
libmumps_common.a
libpord.a
libsmumps.a

# Windows oneAPI / Visual Studio
dmumps.lib
mumps_common.lib
pord.lib
smumps.lib
```

If the system doesn't have LAPACK and SCALAPACK, first build and install them:

```sh
cmake -S scripts -B scripts/build -DCMAKE_INSTALL_PREFIX=~/mylibs
cmake --build build

# mumps
cmake -B build -DCMAKE_PREFIX_PATH=~/mylibs
cmake --build build
```

### MUMPS version selection

The MUMPS version defaults to a recent release.
For reproducibility, benchmarking and other purposes, one may select the version of MUMPS to build like:

```sh
cmake -B build -DMUMPS_UPSTREAM_VERSION=5.5.1
```

The MUMPS_UPSTREAM_VERSION works for MUMPS versions in
[cmake/libraries.json](./cmake/libraries.json).

## Usage

Numerous build options are available as in the following sections.
Most users can just use the defaults.

### MPI

For systems where MPI, BLACS and SCALAPACK are not available, or where non-parallel execution is suitable, the default parallel can be disabled at CMake configure time by option `cmake -Dparallel=false`.

### Precision

The default precision is "s;d" covering float64 and float32.

```sh
cmake -Darith="s;d"
```

may be optionally specified:

```
-Darith=s  # real32
-Darith=d  # real64
-Darith=c  # complex64
-Darith=z  # complex128
```

### Matlab / GNU Octave

Matlab / GNU Octave MEX interface may be built (one or the other) by EITHER:

```sh
-Dmatlab=on
-Doctave=on
```

These require `-Dparallel=off`.
These Matlab scripts seems to have been developed ~ 2006 and may not fully work anymore.
Ask the MUMPS Users List if you need such scripts.
We present them mainly as an example of compiling MEX libraries for Octave and Matlab with CMake.

### ordering

To use Scotch and METIS (requires MUMPS >= 5.0):

```sh
cmake -Dscotch=true
```

If 64-bit integers are needed, use:

```sh
cmake -Dintsize64=true
```

### OpenMP

OpenMP can make MUMPS slower in certain situations.
Try with and without OpenMP to see which is faster for your situation.
Default is OpenMP OFF.

```sh
cmake -Dopenmp=true
```
