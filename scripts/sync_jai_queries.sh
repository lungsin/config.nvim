#!/bin/bash

# This script is used to sync the jai queries with the jai tree-sitter parser repository.
# https://github.com/constantitus/tree-sitter-jai

git clone -n --depth 1 --filter=tree:0 https://github.com/constantitus/tree-sitter-jai.git
cd tree-sitter-jai
git sparse-checkout set --no-cone queries
git checkout
cd ..

cp -r tree-sitter-jai/queries/* queries/jai/
rm -rf tree-sitter-jai

