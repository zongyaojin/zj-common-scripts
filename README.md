# Common Scripts for Package Setup

These scripts assume the following folder structure. The scripts are intended to be used by a `$package` that has this repository as a submodule in the path below.

```text
$package/
    |-- cmake/zj-cmake/modules
    |-- scripts/zj-common-scripts/ (*this module*)
    |-- thirdparty/
    |-- .pre-commit-config.yaml
    |-- CMakeLists.txt
    |-- Doxyfile
```

For the functions of each individual script, see their top comments.
