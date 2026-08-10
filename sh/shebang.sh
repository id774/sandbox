#!/bin/bash -eux
# Trace how the shebang options -eux expand the first three positional parameters.
: $1 $2 $3
