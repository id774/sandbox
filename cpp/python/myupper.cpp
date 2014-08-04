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
