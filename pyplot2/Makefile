
process.so: process.pyx
	python setup.py build_ext --inplace
	@rm -rf process.cpp build

clean:
	@rm -rf *.cpp *.c *.so build

