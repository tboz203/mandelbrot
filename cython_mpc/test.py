#!/usr/bin/env python

import process
import cProfile, pstats
import sys

if 'run' in sys.argv:

    print('beginning `process`')
    cProfile.run('process.process((-2, -2, 2, 2), 500, 100, 200, 128)', 'Profile.prof')
    print('finished `process`')

if 'profile' in sys.argv:

    s = pstats.Stats('Profile.prof')
    s.strip_dirs().sort_stats('time').print_stats()

