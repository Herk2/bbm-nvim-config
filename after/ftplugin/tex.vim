" VimTeX - LaTeX plugin for Vim
"
" Maintainer: Karl Yngve Lervåg
" Email:      karl.yngve@gmail.com
"

"if !get(g:, 'vimtex_enabled', 1)
"  finish
"endif

" Cf https://github.com/lervag/vimtex/blob/master/ftdetect/tex.vim
if !get(g:, 'vimtex_enabled', 1)
      \ || get(g:, 'tex_flavor', 'latex') !=# 'latex'
  finish
endif

" For some reason, it seems the best way to ensure filetype "tex" is to just
" set the g:tex_flavor option. Overriding the autocmds or similar seems to make
" startup slower, for some unknown reason.
let g:tex_flavor = 'latex'

if exists('b:did_ftplugin_vimtex')
  finish
endif
let b:did_ftplugin_vimtex = 1

" Check for plugin clashes.
" Note: This duplicates the code in health/vimtex.vim:s:check_plugin_clash()
let s:scriptnames = vimtex#util#command('scriptnames')

let s:latexbox = !empty(filter(copy(s:scriptnames), "v:val =~# 'latex-box'"))
if s:latexbox
  call vimtex#log#warning([
        \ 'Conflicting plugin detected: LaTeX-Box',
        \ 'VimTeX does not work as expected when LaTeX-Box is installed!',
        \ 'Please disable or remove it to use VimTeX!',
        \])
endif

" END kyl's Buffer-Local Vimtex Settings
" --------------------------------------
" My (ejm's) LaTex settings

" Only load this plugin it has not yet been loaded for this buffer
" Note that using b:did_ftplugin would disable vimtex
if exists("b:did_mytexplugin")
  finish
endif
let b:did_mytexplugin = 1

if empty(v:servername) && exists('*remote_startserver')
  call remote_startserver('VIM')
endif

let g:tex_flavor = 'latex'  " recognize tex files as latex

" jdhao_settings
  " let g:vimtex_view_general_viewer = 'skim'
  " let g:vimtex_view_general_viewer = '/Applications/Skim.app/Contents/SharedSupport/displayline' 
" let g:vimtex_view_general_options = '-r @line @pdf @tex'

"rjg.me settings
" Viewer options: One may configure the viewer either by specifying a built-in viewer method:
"let g:vimtex_view_method = 'Skim'
" Or with a generic interface:
let g:vimtex_view_general_viewer = "skim"
let g:vimtex_view_general_options = "--unique file:@pdf\#src:@line@tex"
" common settings
let g:vimtex_compiler_method = "latexmk"
let mapleader = " "
let maplocalleader = " "

" Forward Search Deepak Ramani 
" https://dr563105.github.io/blog/skim-vimtex-setup/ 
let g:tex_flavor='latex' " Default tex file format
"let g:vimtex_view_method = 'skim' " Choose which program to use to view PDF file
" Cursor Sync Deepak Ramani
let g:vimtex_view_skim_sync = 1 "Value 1 allows forward search after every successful compilation (:VimtexCompile)
let g:vimtex_view_skim_activate = 1 "Value 1 allows focus of control to shift from neovim to skim after command `:VimtexView

" Not sure of the whence the next shortcut.
nmap <localleader>c <plug>(vimtex-compile)

" Forward Search EJM
" Define a custom shortcut to trigger VimtexView and Forward Search
nmap <localleader>v <plug>(vimtex-view)

" From Astronvim/mappings.lua
maps.n["<leader>w"] = { "<cmd>w<cr>", desc = "Save" }
" setting indentation
setlocal expandtab
setlocal autoindent
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4

" Turn off automatic indenting in enumerated environments
let g:tex_indent_items=0

" Compilation
noremap <leader>r <Cmd>update<CR><Cmd>VimtexCompileSS<CR>

" Write the line "TEX" to the file "/tmp/inverse-search-target.txt".
" I use the file  "/tmp/inverse-search-target.txt" as part of making inverse
" search work for both LaTeX and Lilypond LyTeX files.
call system(printf("echo %s > %s", "TEX", "/tmp/inverse-search-target.txt"))

" BEGIN FORWARD SHOW
" ---------------------------------------------
nmap <leader>v <plug>(vimtex-view)
" macOS forward search implementation
" ---------------------------------------------
" END COMPILATION AND PDF READER SUPPORT

