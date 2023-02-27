
# print("Hello from Python source code in plugin.py")

import platform

try:
  import vim
except:
  print("No vim module available outside vim")
  pass

def print_python_version():
    print(platform.python_version())
