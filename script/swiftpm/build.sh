#!/bin/bash

if [[ "$OSTYPE" == "linux-gnu" ]]; then
  echo "Linux build command is not set"
  exit 1
elif [[ "$OSTYPE" == "darwin"* ]]; then
  export PATH=/Library/Developer/Toolchains/swift-latest.xctoolchain/usr/bin:$PATH
  echo $(swift --version)
  LIBGIT2_LIB_PATH=$(find . -wholename '*/External/libgit2.a' | head -n 1)
  echo "Using libgit2 in: $LIBGIT2_LIB_PATH"

  LIBZ=/usr/lib/libz.dylib
  LIBICONV=/usr/lib/libiconv.dylib
  LIBCURL=/usr/lib/libcurl.dylib

  COMMAND="swift build -Xlinker $LIBGIT2_LIB_PATH -Xlinker $LIBZ -Xlinker $LIBICONV -Xlinker $LIBCURL"
  echo $COMMAND
  $COMMAND

  EXIT_STATUS=$?
else
  echo "Error: unsupported platform."
fi

exit $EXIT_STATUS