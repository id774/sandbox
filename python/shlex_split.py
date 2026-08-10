# Split a command line string into tokens with shlex, honoring quotes.

import shlex

r = shlex.split('''he said 'you are beautiful!' ''')
print(r)
