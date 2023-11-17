# Common Scripts for C++ Package Setup

[![GitHub license](https://img.shields.io/badge/license-Apache--2.0-blue.svg)](https://github.com/zongyaojin/zj-base/blob/main/LICENSE)

This repository is intended to be included as a submodule in a C++ `$package`, and it assumes the following folder structure. See top comments in each script for details.

```text
$package/
    |-- cmake/zj-cmake/modules
    |-- scripts/zj-common-scripts/ (*this repository as a submodule*)
    |-- thirdparty/
    |-- .pre-commit-config.yaml
    |-- CMakeLists.txt
    |-- Doxyfile
```
