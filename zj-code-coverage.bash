#!/bin/bash
set -exo pipefail

script_file=$(realpath "$0")
script_absolute_path=$(dirname "$script_file")
package_path=$(realpath $script_absolute_path/../..)
package_build_path=$package_path/build

# Go to the build directory, build and install
(
    cd $package_build_path

    # Build with ZJ_CODE_COVERAGE=ON is necessary for generating code coverage
    cmake .. \
        -D ZJ_CODE_COVERAGE=ON \
        -D CMAKE_BUILD_TYPE=Release \
        -D BUILD_SHARED_LIBS=OFF \
        -D BUILD_TESTING=ON
    make

    # You need to test first, then you can get the code coverage report
    ctest

    # Generating code coverage report
    # https://subscription.packtpub.com/book/programming/9781803239729/9/ch09lvl1sec56/generating-code-coverage-reports

    # Get the tests/ folder's real path no ".." so "--exclude" and interpret
    tests_absolute_real_path="$(realpath "$package_path/tests/")"
    # Exclude system "/usr" stuff and local "./tests" stuff
    lcov --directory . --exclude '/usr/*' --exclude "${tests_absolute_real_path}/*" --capture --output-file coverage.info
    genhtml coverage.info --output-directory coverage-report
    firefox coverage-report/index.html
)
