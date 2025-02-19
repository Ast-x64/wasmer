#! /bin/sh

# How to install `fd`: https://github.com/sharkdp/fd#installation
: "${FD:=fd}"

# A script to update the version of all the crates at the same time
PREVIOUS_VERSION='2.2.0-rc1'
NEXT_VERSION='2.2.0-rc2'

# quick hack
${FD} Cargo.toml --exec sed -i '{}' -e "s/version = \"$PREVIOUS_VERSION\"/version = \"$NEXT_VERSION\"/"
${FD} Cargo.toml --exec sed -i '{}' -e "s/version = \"=$PREVIOUS_VERSION\"/version = \"=$NEXT_VERSION\"/"
echo "manually check changes to Cargo.toml"

${FD} wasmer.iss --exec sed -i '{}' -e "s/AppVersion=$PREVIOUS_VERSION/AppVersion=$NEXT_VERSION/"
echo "manually check changes to wasmer.iss"

# Re-generate lock files
cargo generate-lockfile
cargo generate-lockfile --manifest-path wasmer-test/Cargo.toml

# Order to upload packages in
## wasmer-types
## win-exception-handler
## compiler
## compiler-cranelift
## compiler-llvm
## compiler-singlepass
## emscripten
## wasi
## wasmer (api)
