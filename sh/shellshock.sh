#!/bin/bash
# Check whether bash is vulnerable to Shellshock (CVE-2014-6271).

env x='() { :;}; echo Vulnerable' bash -c "echo This is a test."
