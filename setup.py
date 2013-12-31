from distutils.core import setup
from Cython.Build import cythonize

import os
os.environ["CC"] = "g++"
os.environ["CXX"] = "g++"


setup(
	name = 'cPaleo',
	ext_modules = cythonize("test/hello.pyx", language="c++"), 
)
