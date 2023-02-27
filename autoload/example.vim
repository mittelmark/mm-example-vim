" https://www.linode.com/docs/guides/writing-a-vim-plugin/
" Pure Vim-Script
function! example#DisplayTime(...)
    if a:0 > 0 && (a:1 == "d" || a:1 == "t")
        if a:1 == "d"
            echo strftime("%b %d")
        elseif a:1 == "t"
            echo strftime("%H:%M")
        endif
    else
        echo strftime("%b %d %H:%M")
    endif
endfunction

" Starts a section for Python 3 code.
python3 << EOF
# Imports Python modules to be used by the plugin.
import vim
import json, requests
import re
# Sets up variables for the HTTP requests the
# plugin makes to fetch word definitions from
# the Wiktionary dictionary.
request_headers = { "accept": "application/json" }
request_base_url = "https://en.wiktionary.org/api/rest_v1/page/definition/"
request_url_options = "?redirect=true"

# Fetches available definitions for a given word.
def get_word_definitions(word_to_define):
    response = requests.get(request_base_url + word_to_define + request_url_options, headers=request_headers)

    if (response.status_code != 200):
        print(response.status_code + ": " + response.reason)
        return

    definition_json = json.loads(response.text)

    for definition_item in definition_json["en"]:
        print(definition_item["partOfSpeech"])

        for definition in definition_item["definitions"]:
            print(" - " + re.sub("<.+?>","", str(definition["definition"])))
EOF

" Calls the Python 3 function.
function! example#DefineWord()
    let cursorWord = expand('<cword>')
    python3 get_word_definitions(vim.eval('cursorWord'))
endfunction

" load from ../python
if !has("python3")
  echo "vim has to be compiled with +python3 to run this"
  finish
endif

if exists('g:sample_python_plugin_loaded')
  finish
endif

let s:plugin_root_dir = fnamemodify(resolve(expand('<sfile>:p')), ':h')

python3 << EOF
import sys
from os.path import normpath, join
import vim
plugin_root_dir = vim.eval('s:plugin_root_dir')
python_root_dir = normpath(join(plugin_root_dir, '..', 'python'))
sys.path.insert(0, python_root_dir)
import plugin # python/plugin.py
EOF

let g:sample_python_plugin_loaded = 1

function! example#PythonVersion()
  python3 plugin.print_python_version()
endfunction
" example for a console application

function! example#AspellCheck()
    let cursorWord = expand('<cword>')
    let aspellSuggestions = system("echo '" . cursorWord . "' | aspell -a")
    let aspellSuggestions = substitute(aspellSuggestions, "& .* 0:", "", "g")
    let aspellSuggestions = substitute(aspellSuggestions, ", ", "\n", "g")
    echo aspellSuggestions
endfunction
    
