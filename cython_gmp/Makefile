

all: process.so

process.so: process.pyx
	python setup.py build_ext --inplace -lgmp
	@rm -rf build *.c *.cpp

clean:
	@rm -rf build *.c *.cpp *.so
