"===================
"适合自己用的vimrc配置文件
"===================

"设置编码
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8

"保存.vimrc文件时自动重启加载，即让此文件立即生效
autocmd BufWritePost $MYVIMRC source $MYVIMRC

"语法高亮
syntax on

"设置ruler会在右下角显示光标所在的行号和列号,不方便查看,改成设置状态栏显示内容
"set ruler

"设置状态行显示的内容. %F: 显示当前文件的完整路径. %r: 如果readonly,会显示[RO]
"%B: 显示光标下字符的编码值,十六进制. %l:光标所在的行号. %v:光标所在的虚拟列号.
"%P: 显示当前内容在整个文件中的百分比. %H和%M是strftime()函数的参数,获取时间.
set statusline=%F%r\ [HEX=%B][%l,%v,%P]\ %{strftime(\"%H:%M\")}

"显示行号
set nu "等同于 set number

"突出显示当前行
set cursorline "等同于 set cul

"突出显示当前列
set cursorcolumn "等同于 set cuc

"共享剪贴板  
set clipboard+=unnamed 

"从不备份  
set nobackup

"自动保存
set autowrite

"隐藏工具栏
"set guioptions-=T
"隐藏菜单栏
"set guioptions-=m

"高亮显示所有搜索到的内容.后面用map映射快捷键来方便关闭当前搜索的高亮.
"set hlsearch

"光标立刻跳转到搜索到内容
"set incsearch

"搜索到最后匹配的位置后,再次搜索不回到第一个匹配处
"set nowrapscan

"去掉输入错误时的提示声音
set noeb

" 默认按下Esc后,需要等待1秒才生效,设置Esc超时时间为100ms,尽快生效
set ttimeout
set ttimeoutlen=100

"在处理未保存或只读文件的时候，弹出确认
set confirm

"让Backspace键可以往前删除字符.
"Debian系统自带的vim版本会加载一个debian.vim文件,默认已经设置这一项,
"可以正常使用Backspace键.如果使用自己编译的vim版本,并自行配置.vimrc文件,
"可能就没有设置这一项,导致Backspace键用不了,或者时灵时不灵.所以主动配置.
"使回格键（backspace）正常处理indent, eol, start等
set backspace=indent,eol,start

"允许backspace和光标键跨越行边界
"set whichwrap+=<,>,h,l

"去掉有关vi一致性模式,避免操作习惯上的局限.
set nocompatible

"FIXME 在MS-DOS控制台打开vim时,控制台使用鼠标右键来复制粘贴,设置
"全鼠标模式,鼠标右键被映射为visual mode,不能用来复制粘贴,不方便.
"但是如果不设置鼠标模式,会无法使用鼠标滚轮来滚动界面.经过验证,发现
"可以设成普通模式mouse=n来使用鼠标滚轮,也能使用鼠标右键复制粘贴.
" mouse=c/mouse=i模式都不能用鼠标滚轮. Linux下还是要设成 mouse=a
set mouse=n
"set selection=exclusive
"set selectmode=mouse,key

"高亮显示括号匹配
set showmatch

"设置Tab长度为4空格
set tabstop=4
"设置自动缩进长度为4空格
set shiftwidth=4
"自动缩进,这个导致从外面拷贝多行以空格开头的内容时,会有多的缩进,先不设置
"set autoindent
"不要用空格代替制表符
set noexpandtab
"输入tab制表符时，自动替换成空格
"set expandtab
"设置softtabstop有一个好处是可以用Backspace键来一次删除4个空格.
"softtabstop的值为负数,会使用shiftwidth的值,两者保持一致,方便统一缩进.
"set softtabstop=4


"显示空格和tab键
set listchars=tab:>-,trail:-

"1=启动显示状态行, 2=总是显示状态行.设置总是显示状态行,方便看到当前文件名
set laststatus=2

"自动补全
:inoremap ( ()<ESC>i
:inoremap ) <c-r>=ClosePair(')')<CR>
:inoremap { {<CR>}<ESC>O
:inoremap } <c-r>=ClosePair('}')<CR>
:inoremap [ []<ESC>i
:inoremap ] <c-r>=ClosePair(']')<CR>
:inoremap " ""<ESC>i
:inoremap ' ''<ESC>i
function! ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endfunction 
"打开文件类型检测,并载入文件类型插件,为特定文件类型载入相关缩进文
filetype plugin indent on
" 设置自动补全的选项. longest表示只自动补全最大匹配的部分,剩余部分通过
" CTRL-P/CTRL-N来选择匹配项进行补全. menu表示弹出可补全的内容列表.
" 如果有多个匹配,longest选项不会自动选中并完整补全,要多按一次CTRL-P,比较
" 麻烦,不做设置,保持默认设置,vim默认没有设置longest.
"set completeopt=longest,menu "启用这句才会开启自动补全


"设置背景主题 
"color asmanian2
"设置字体
"set guifont=Courier_New:h10:cANSI
"设置颜色主题,适用于黑色背景.
colorscheme slate

"=============显示中文帮助
if version >= 603
    set helplang=cn
    set encoding=utf-8
endif

"=============新建.c,.h,.sh,.java文件，自动插入文件头 
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.java exec ":call SetTitle()" 
""定义函数SetTitle，自动插入文件头 
func SetTitle() 
    "如果文件类型为.sh文件 
    if &filetype == 'sh' 
        call setline(1,"\############################") 
        call append(line("."), "\# File Name: ".expand("%")) 
        call append(line(".")+1, "\# Author: Yuan Yingchao") 
        call append(line(".")+2, "\# Mail: ") 
        call append(line(".")+3, "\# Created Time: ".strftime("%c"))
        call append(line(".")+4, "\############################") 
        call append(line(".")+5, "\#!/bin/bash") 
        call append(line(".")+6, "") 
    else 
        call setline(1, "/******************************") 
        call append(line("."), "    > File Name: ".expand("%")) 
        call append(line(".")+1, "    > Author: Yuan Yingchao") 
        call append(line(".")+2, "    > Mail: ") 
        call append(line(".")+3, "    > Created Time: ".strftime("%c")) 
        call append(line(".")+4, " *****************************/") 
        call append(line(".")+5, "")
    endif

    "新建文件后，自动定位到文件末尾
    autocmd BufNewFile * normal G
endfunc 
