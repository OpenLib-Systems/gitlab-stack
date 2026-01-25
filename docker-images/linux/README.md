# Linux C++ build image with

- GCC
- CMake
- Ninja

## Gitlab login

docker login registry.gitlab.com

## Build

docker build -t registry.gitlab.com/botsch-group/images/cpp-linux:2026.01 .

## Push

docker push registry.gitlab.com/botsch-group/images/cpp-linux:2026.01
