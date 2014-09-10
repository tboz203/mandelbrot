#!/usr/bin/env python

from process import process
import cProfile, pstats

print('beginning `process`')
cProfile.run('process(maxiter=20, granularity=10)', 'Profile.prof')
print('finished `process`')

s = pstats.Stats('Profile.prof')
s.strip_dirs().sort_stats('time').print_stats()
