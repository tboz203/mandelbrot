
process.so: process.pyx
	python setup.py build_ext --inplace
	@rm -rf *.{c,cpp} build

clean:
	@rm -rf *.{c,cpp,so} build

