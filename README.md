# mm-example-vim

Example plugin for the Vim text editor with command definitions using standard
Vimscript, a console application and two examples for Python plugins.

## Installation

Installation for Vim 8 using the standard package mechanism like this:

```
mkdir -p ~/.vim/pack/mittelmark/start
git clone https://github.com/mittelmark/mm-example-vim ~/.vim/pack/mittelmark/start
```

## Commands

* `DisplayTime` - show current time (Vimscript)
* `DefineWord` - place cursor on a word and get defintions for that word
  (Python)
* `PythonVersion` - get the PythonVersion for your Vim installation (Python)
* `AspellCheck` - use Aspell to check the word under cursor (Console
  application) 

## Files

* `plugin/example.vim` - the command mappings file
* `autoload/example.vim` the plugin code for 
    - the pur Vimscript plugin command`DisplayTime`
    - the embedded Python plugin command `DefineWord`
    - the externalized Python plugin command `PythonVersion`
    - the command line command `AspellCheck`  
* `python/plugin.py` - the pure Python code for `PythonVersion`
