// myupper.cpp: Python extension module that prints a string in upper case
//
// Description:
// Define the myupper Python extension module, whose myupper function prints
// its string argument converted to upper case. setup.py builds it.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com
//
// Requirements:
// - Python 3 development headers (Python.h)
//

#include <Python.h>
#include <iostream>
#include <string>
#include <algorithm>

using namespace std;

static PyObject *
myupper(PyObject *self, PyObject *args) {
    const char *text;
    if (!PyArg_ParseTuple(args, "s", &text))
        return NULL;
    string target = text;
    transform (target.begin(), target.end(), target.begin(), ::toupper);
    cout<< target <<endl;
    Py_RETURN_NONE;
}

static PyMethodDef myupper_methods[] = {
    {"myupper", myupper, METH_VARARGS, "convert to upper."},
    {NULL, NULL, 0, NULL}
};

static struct PyModuleDef myupper_module = {
    PyModuleDef_HEAD_INIT,
    "myupper",
    "sample extension module",
    -1,
    myupper_methods
};

PyMODINIT_FUNC
PyInit_myupper(void) {
    return PyModule_Create(&myupper_module);
}
