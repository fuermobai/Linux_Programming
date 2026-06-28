" ==================== 插件管理 ====================
call plug#begin('~/.vim/plugged')
" Coc.vim 插件
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" 自动管理 tag 文件
Plug 'ludovicchabant/vim-gutentags'
" 在侧边栏显示代码大纲
Plug 'preservim/tagbar'
" 提供 C/C++ 开发的全套辅助功能，包括代码模板
" 提升语法折叠性能，避免编辑时卡顿[reference:11]
Plug 'Konfekt/FastFold'
" 增强折叠行显示，展示更多有用信息[reference:12]
Plug 'tomtom/foldtext_vim'
" vim snippets 
Plug 'honza/vim-snippets'
call plug#end()

" ==================== Gentoo/Vim 特定设置 ====================
" 【重要】Gentoo 多 Python 版本共存时，显式指定解释器防止 Coc 找不到
" 请先运行 :!which python3 确认路径，通常是 /usr/bin/python3
let g:coc_python_version = '/usr/bin/python3'

" 全局扩展列表（首次启动会自动安装）
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-clangd',
  \ ]

" ==================== 补全与导航快捷键 ====================
" 回车确认补全
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Tab 切换补全项
" inoremap <silent><expr> <TAB>
"       \ coc#pum#visible() ? coc#pum#next(1):
"       \ CheckBackspace() ? "\<Tab>" :
"       \ coc#refresh()

inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1): "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" K 查看文档
nnoremap <silent> K :call <SID>show_documentation()<CR>

" 代码导航
nnoremap <silent> gd <Plug>(coc-definition)
nnoremap <silent> gy <Plug>(coc-type-definition)
nnoremap <silent> gi <Plug>(coc-implementation)
nnoremap <silent> gr <Plug>(coc-references)

" 重命名与格式化
nmap <leader>rn <Plug>(coc-rename)
nmap <leader>f <Plug>(coc-format-selected)
xmap <leader>f <Plug>(coc-format-selected)

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" ==================== C/C++ 专属配置 ====================
autocmd FileType c,cpp setlocal shiftwidth=4 tabstop=4 softtabstop=4 expandtab

" ---------- vim-gutentags 配置 ----------
" 设置 gtags 模块
let g:gutentags_modules = ['ctags', 'gtags_cscope']
" 配置 gtags 数据库的生成命令
let g:gutentags_gtags_extra_args = '--quiet'
let g:gutentags_gtags_opts = ['--objdir=.', '-C']
" 当项目根目录有 .git 文件夹时，自动在该目录生成 tag 和 gtags 数据库
let g:gutentags_project_root = ['.git']

" ---------- Tagbar 配置 ----------
" 设置 F9 键为开关 Tagbar 窗口的快捷键
nmap <F9> :TagbarToggle<CR>
" 让 Tagbar 窗口位于右侧，宽度为 40 列
let g:tagbar_width = 40
let g:tagbar_position = 'rightabove'

" -------- Tab 跳过> -----------
" 定义一个函数，用于检查当前光标后是否是右括号，是则跳出
function! SkipPair()
    let l:line = getline('.')
    let l:pos = col('.') - 1
    if l:pos < len(l:line) && l:line[l:pos] =~ '[)\]}>";:]'
        return "\<Right>"
    else
        return "\<Tab>"
    endif
endfunction

" 在插入模式下，将 <Tab> 键映射为调用上面的函数
" inoremap <Tab> <C-r>=SkipPair()<CR>
"
"
"
"
" =============================== 自定义设置 @20260620  ====================
"
"
"                          author: Q
" 设置行号
set nu
colorscheme default
" 设置vim底部显示当前编辑文件全路径
set statusline=%F
" ————————— 代码折叠配置——————————————
nnoremap <space> za 
set foldenable
set foldmethod=syntax
set foldcolumn=4
set foldlevel=99
" 保存折叠和光标位置
set viewoptions=folds,cursor
autocmd BufWinLeave * mkview
autocmd BufWinEnter * silent loadview
" 设置折叠列的高亮颜色（更醒目）
highlight FoldColumn guibg=DarkGreen guifg=Blue
highlight Folded guibg=Red guifg=Blue
" 设置远程终端颜色显示
highlight FoldColumn ctermbg=236 ctermfg=255
highlight Folded ctermbg=240 ctermfg=14
" 修改注释的颜色号为：
highlight Comment ctermfg=117 guifg=#87ceeb
" 修改Coc 菜单展示背景色为紫色
" highlight Visual ctermbg=125 guibg=purple
" highlight CocSnippetVisual NONE
" highlight CocSnippetVisual ctermbg=125 guibg=purple
highlight Pmenu ctermbg=53 guibg=#5a005a
" highlight! Pmenu ctermbg=140 guibg=#5a005a
highlight! PmenuSel ctermbg=140 guibg=#87ceeb
" highlight! PmenuSel ctermbg=53 guibg=#87ceeb
highlight! PmenuSbar ctermbg=red guibg=#87ceeb
highlight CocMenuSel ctermbg=magenta
" 设置光标所在行颜色
" set cursorline
" highlight CursorLine ctermbg=25
"
" 插入模式：闪烁的方块
let &t_SI = "\e[1 q"
" 替换模式：闪烁的方块（也可改为其他形状）
let &t_SR = "\e[1 q"
" 普通模式：闪烁的方块（可选，便于区分模式）
let &t_EI = "\e[1 q"


" ==================== 统一 Tab/Shift-Tab 智能映射 ====================
" 功能：
"   补全菜单弹出时：Tab/Shift+Tab 上下循环选择
"   片段展开后：Tab/Shift+Tab 在占位符间跳转
"   其他情况：Tab 若光标后是 )]}'>";:` 则跳过，否则插入正常缩进
"           Shift+Tab 若菜单/片段未激活则删除前一个字符（保持原习惯）

" 辅助函数：判断光标后是否为可跳过的配对符号
function! s:SmartTab()
  let l:line = getline('.')
  let l:col = col('.') - 1
  " 如果光标后是 ) ] } > ' " ; : ` 中的任一字符，则向右移动
  if l:col < len(l:line) && l:line[l:col] =~ "[)\\]}>'\";:`]"
    return "\<Right>"
  else
    return "\<Tab>"
  endif
endfunction

" Tab 键：补全选择 → 片段跳转 → 智能跳过/缩进
inoremap <silent><expr> <Tab>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ coc#expandableOrJumpable() ? "\<Plug>(coc-snippets-expand-jump)" :
      \ <SID>SmartTab()

" Shift+Tab 键：补全向上选择 → 片段回跳 → 删除前一个字符
inoremap <silent><expr> <S-Tab>
      \ coc#pum#visible() ? coc#pum#prev(1) :
      \ coc#jumpable() ? "\<C-k>" :
      \ "\<C-h>"
