# See profile_used.py
#
# profile file, js file

from __future__ import print_function
import sys, json

used = json.loads(open(sys.argv[1]).read())

show = True
in_table = False

for orig in open(sys.argv[2]).readlines():
  line = orig.strip()

  if orig.startswith('function _') and line.endswith(('){', ') {')):
    name = line.split(' ')[1].split('(')[0]
    if name.startswith('_') and not used.get(name):
      #print >> sys.stderr, 'remove', name
      show = False

  if line.startswith('var FUNCTION_TABLE'):
    in_table = True

  if in_table:
    start = 0
    if 'var ' in line:
      start = line.index('[')+1
    end = len(line)
    if ']' in line:
      end = line.index(']')
    contents = line[start:end]
    fixed = ['"' + name + '"' if not used.get(name) else name for name in contents.split(',')]
    print((line[:start] + ','.join(fixed) + line[end:]).replace('""', ''))
  else:
    if show:
      print(orig, end=' ')

  if orig.startswith('}'):
    show = True

  if in_table and line.endswith(';'):
    in_table = False

