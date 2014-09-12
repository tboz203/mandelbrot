#!/usr/bin/env python

import process
import cProfile, pstats
import sys

exit()

if not 'profile' in sys.argv:

    print('beginning `process`')
    cProfile.run('process.process(maxiter=20, granularity=6)', 'Profile.prof')
    print('finished `process`')

s = pstats.Stats('Profile.prof')
s.strip_dirs().sort_stats('time').print_stats()

