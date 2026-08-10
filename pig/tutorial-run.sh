#!/bin/sh

pig -x local script1-local.pig
test -f script1-local-results.txt/_SUCCESS && cat script1-local-results.txt/part-r-00000
test -f script1-local-results.txt/_SUCCESS || echo "script1 Job Failed !!!"

pig -x local script2-local.pig
test -f script2-local-results.txt/_SUCCESS && cat script2-local-results.txt/part-r-00000
test -f script2-local-results.txt/_SUCCESS || echo "script2 Job Failed !!!"

