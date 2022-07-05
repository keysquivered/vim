" ================================
" === configuration of vim
" === suit for go and markdown
" === author : gvls
" ================================

"source xx/xx/vimrc
"let g:load_change_color_scheme = 1
"if exists("g:load_change_color_scheme")
"    finish
"endif

" son version can use this configuration
" fix bug for vi
set nocompatible
" check file type automaticly
filetype on
filetype indent on
" such as ( ... )
set showmatch
" show tab line
set showtabline=2

" cursor status in riht corner
"set ruler

" display by 2character
"set ambiwidth=double

" can use mouse in vim
"set mouse=a

" bottom status
" 0 : not display; 1 : display When one window; 2 : always display
" show status : ctrl + g | :f
set laststatus=2
" status line
"%<	如果状态行过长，在何处换行。缺省是在开头。
function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction
function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?' '.l:branchname.'':' '
endfunction
set statusline=
set statusline+=%#LineNr#\ %1*%r\ %5*==\ %3*%l%4*-%3*%v\ %5*==
"set statusline+=\ %4*%{StatuslineGit()}
set statusline+=\ %4*-%8*%{GitStatusA()}%4*-%6*%{GitStatusM()}%4*-%1*%{GitStatusR()}%4*-
set statusline+=\ %=
set statusline+=\ %4*%L\ %7*%Y\ %2*%{&fileencoding?&fileencoding:&encoding}\ %3*%p%%
" execute oder in current dir
set autochdir
" encoding of display
" in addition, :e ++enc=cp936 || :e ++enc=euc-cn
set encoding=utf-8
" encoding of save file
"set fileencoding=utf-8
" encoding list which display according to
"set fileencodings=utf8,ucs-bom,default,latin1,gbk,cp936,gb2312,gb18030
"set fileformat=unix

" when open file go to pre position
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
" line number on left
set number
" line relative number on left
set relativenumber
" no set independent vim clipboard
" press ctrl+shirt and use mouse to select, then use ctrl+shirt+c to copy
set clipboard=unnamed
" cursor position up from bottom
set scrolloff=5
" in : get tip by table key
set wildmenu
" hight light search result
set nohlsearch
" hight light when search
set noincsearch
" ignore case when search
set noignorecase
" smart case when search
set nosmartcase
" show line of current line
set nocursorline
" display automaticly 
set wrap
" <CR> automaticly
set textwidth=999
" show cmd
set showcmd
" when split, make cursor on right
set nosplitright
" when split, make cursor on below
set splitbelow
" table
set tabstop=4
" lenght of -> for all level
set shiftwidth=4
" set count of "yy"
set viminfo='1000,<100





" ================================
" ===basic map
" ================================
"let mapleader = "\"
" enter in normal model
nnoremap <CR> o<Esc>
"inoremap <S-CR> i<CR><Esc>
":autocmd CmdwinEnter * nnoremap <CR> <CR>
":autocmd BufReadPost quickfix nnoremap <CR> <CR>
"inoremap <s-tab> <c-x><c-f>
" space in normal model
"nnoremap <space> i <Esc>
" bottom information
nnoremap <C-g> 1<c-g>
" return to last place and view in middle
"nnoremap <C-o> <c-g>zz
" return to new place and view in middle
"nnoremap <C-i> <c-g>zz
"imap <c-l> <del>





" ================================
" ===appearance for cursor
" ================================
" cursor size Settings
let &t_SI.="\e[5 q" "SI = INSERT mode
let &t_SR.="\e[4 q" "SR = REPLACE mode
let &t_EI.="\e[1 q" "EI = NORMAL mode (ELSE)
" Cursor settings:
"  1 -> blinking block
"  2 -> solid block
"  3 -> blinking underscore
"  4 -> solid underscore
"  5 -> blinking vertical bar
"  6 -> solid vertical bar
"let &t_SI = "\<Esc>]50;CursorShape=1\x7"
"let &t_SR = "\<Esc>]50;CursorShape=2\x7"
"let &t_EI = "\<Esc>]50;CursorShape=0\x7"





" ================================
" === markdown ===================
" ================================
" massage document: github:Markdown-here

" tips: markdown,*.txt
" inoremap insert mode
" noremap normal mode and no recursion(j=5j)
if has ("autocmd")

" <Enter> by oderly
autocmd Filetype markdown set autoindent
autocmd Filetype markdown set smartindent

" spelling check
"autocmd Filetype markdown set spell

" jump
"autocmd Filetype markdown inoremap ,f <Esc>/口口口<CR>:nohlsearch<CR>c3l
autocmd Filetype markdown inoremap <c-l> <Esc>/口口口<CR>:nohlsearch<CR>c3l
"autocmd Filetype markdown inoremap <s-CR> <Esc>A<CR>
"autocmd Filetype markdown inoremap <CR> <Esc>/口口口<Enter>c3l

" title
" H1 ; other use: ===
autocmd Filetype markdown inoremap ,1 #<Space>
" H2 ; other use: ---
autocmd Filetype markdown inoremap ,2 ##<Space><Space>
autocmd Filetype markdown inoremap ,3 ###<Space><Space><Space>
autocmd Filetype markdown inoremap ,4 ####<Space><Space><Space><Space>
autocmd Filetype markdown inoremap ,5 #####<Space><Space><Space><Space><Space>
autocmd Filetype markdown inoremap ,6 ######<Space><Space><Space><Space><Space><Space>

" B ; other use: ____
autocmd Filetype markdown inoremap ,b ****<Space>口口口<Esc>F*hi
" ---
autocmd Filetype markdown inoremap ,s ~~~~<Space>口口口<Esc>F~hi
" / ; other use:  __
autocmd Filetype markdown inoremap ,i __<Space>口口口<Esc>F_i

" list
" other use: <number>.<Space>
" other use: -<Space>
" other use: +<Space>
"autocmd Filetype markdown inoremap ,100 *<Space>口口口

" links use: [xxx](link)
" other use: [xxx][case-insensitice symbol]	[case-insensitice symbol]: here write link
" other use: [ABC]	[ABC]: here write link
" other use: http://...
" other use: <...>
autocmd Filetype markdown inoremap ,a [](口口口) 口口口<Esc>F[a

" image use: ![alt text](link "display")
" other use: ![alt text][symbol]		[symbol]: link "display"
"autocmd Filetype markdown inoremap ,p ![](口口口<Space>"口口口") 口口口<Esc>F[a

" hightlight
autocmd Filetype markdown inoremap ,d `` 口口口<Esc>F`i

" code use: ```language
"		...
"	   ```
"autocmd Filetype markdown inoremap ,c ```<Enter>```<Enter><Enter>口口口<Esc>3kA
autocmd Filetype markdown inoremap ,ce ```<Enter>```<Enter><Esc>2kA
autocmd Filetype markdown inoremap ,cs ```shell<Enter><Enter>```<Enter><Esc>2kA
autocmd Filetype markdown inoremap ,cj ```javascript<Enter><Enter>```<Enter><Esc>2kA
autocmd Filetype markdown inoremap ,cc ```c<Enter><Enter>```<Enter><Esc>2kA
autocmd Filetype markdown inoremap ,cg ```go<Enter><Enter>```<Enter><Esc>2kA

" tables use:
" xxx | xxx | xxx
" --- | --- | ---
" yyy | yyy | yyy
" we can write : to side of '-' to right-aligned or centered
" -: right	:- left		:-:	center
" \|-\|-\|<Enter>\|\|<Enter>\|-\|-\|<Enter><Esc>2ka
autocmd Filetype markdown inoremap ,t <c-o>:TableModeEnable<cr>\|-\|<Enter>\|  \|<Enter>\|-\|<Enter><enter><Esc>3kla
autocmd Filetype markdown inoremap <silent> ,l <esc>:call tablemode#spreadsheet#InsertColumn(1)<CR>
autocmd Filetype markdown inoremap <silent> ,q <esc>:call MdExitTable()<cr>a
fun MdExitTable()
	:execute "normal :TableModeRealign\<CR>"
	:execute "normal :TableModeEnable\<CR>"
	:execute "normal :TableModeDisable\<CR>"
	let l:tableEnd = search("^$","nW")
	if tableEnd != 0
		let l:tabEndEnd = getline(tableEnd+1)
		if tabEndEnd == ""
			call cursor(tableEnd+1, 1)
		endif
	endif
endfun

" blockquotes
" I
" I
" I
" higher use: >><Space>
"autocmd Filetype markdown inoremap ,12313 ><Space> 口口口

" we can use HTML grammer
" <dl>
"   <dt>Definition list</dt>
"   <dd>Is something people use sometimes.</dd>
" </dl>

" ---------------------
" use: ---
" other use: ***
" other use: ___
"autocmd Filetype markdown inoremap ,l <Enter><Enter><Enter><Enter>--------------------------------<Enter><Enter><Enter><Enter><Enter>

" some else function: YouTube video	math

" need use '\' to desplay
" ` _ {} [] () # + - * . !

" view
"nmap <F4> :call PreviewMarkdown()<CR>
"func! PreviewMarkdown()
	"if &filetype == 'markdown' || $filetype == 'md'
		"exec "!typora %"
	"endif
"endfunc

endif

autocmd Filetype markdown imap <silent> <c-k> <esc>o
"autocmd Filetype markdown imap <silent> <c-j> <esc>/|\(-\+|\)\+<cr>o
autocmd Filetype markdown imap <silent> <c-j> <esc>/^\|\(-\+\|\)\+<cr>o

augroup myOrderOrderNumber
	autocmd!
	autocmd TextChangedI *.md silent exec "call OrderOrderNumber()"
augroup END
fun OrderOrderNumber()
	let l:currentLine = line(".")
	let l:currentText = getline(".")
	let l:lastText = getline(line(".")-1)
	let l:nextText = getline(line(".")+1)
	let l:lastOrder = matchstr(lastText, '^[0-9]\+\. ')
	let l:nextOrder = matchstr(nextText, '^[0-9]\+\. ')
	"call append(line(".")+1, lastOrder)
	if currentText == "" && lastOrder != ""
		call setline(currentLine, lastOrder)
		let l:forLine = currentLine + 1
		while nextOrder != ""
			:execute "normal j^\<c-a>"
			"call setline(forLine, nextOrder)
			let forLine = forLine + 1
			let nextText = getline(forLine)
			let nextOrder = matchstr(nextText, '^[0-9]\+\. ')
		endwhile
		call cursor(currentLine, 1)
		:execute "normal ^\<c-a>$a "
	endif
endfun

augroup myFillTable
	autocmd!
	autocmd TextChangedI *.md silent exec "call FillTable()"
augroup END
fun FillTable()
	let l:currentText = getline(".")
	if currentText == ""
		let l:lastText = getline(line(".")-1)
		let l:lastEnd = matchstr(lastText, '^|\(-\+|\)\+$')
		" add new line after table
		if lastEnd != ""
			let l:newLine = substitute(lastEnd, "\-\\+", "  ", "")
			let l:newLine = substitute(newLine, "\-\\+", " 口口口 ", "g")
			call setline(line("."), newLine)
			call append(line("."), lastEnd)
			call cursor(line("."), 3)
			:execute "normal :TableModeEnable\<CR>"
			return
		endif
		let l:lastInside = matchstr(lastText, '^|\(.\+|\)\+$')
		" add new line in table. default : lastEnd == ""
		if lastInside != ""
			let l:newLine = substitute(lastInside, "[^|]\\+", " 口口口 ", "g")
			let l:newLine = substitute(newLine, "[^|]\\+", "  ", "")
			call setline(line("."), newLine)
			call cursor(line("."), 3)
			:execute "normal :TableModeEnable\<CR>"
		endif
	endif
endfun

" may use more time
"augroup myFixTable
	"autocmd!
	"autocmd TextChanged *.md silent exec ":TableModeRealign"
	"autocmd TextChangedP *.md silent exec ":TableModeRealign"
"augroup END






" ================================
" ===ranger
" ================================
" let g:ranger_map_keys = 0





" ================================
" ===function
" ================================
" Compile function
autocmd Filetype go,sh nnoremap <silent> go :call CompileRunGcc()<CR><c-w>h
"autocmd Filetype go nnoremap gO <c-w>l:close<CR>
"autocmd Filetype go nnoremap gn :cnext<CR>
"autocmd Filetype go nnoremap gN :cprevious<CR>
"autocmd Filetype go nnoremap gc :cclose<CR>
"autocmd Filetype go nnoremap gb :GoBuild<CR>
"autocmd Filetype go nnoremap gt :GoTest<CR>
"autocmd Filetype go nnoremap gt :GoRename<CR>
func! CompileRunGcc()
	exec "w"
	"exec "2close"
"	exec "only"
	let l:currentBufName = bufname("%")
	let l:goTermWinName = "!go run ".currentBufName
	let l:ifGoTerm = bufexists(goTermWinName)
	if ifGoTerm == 1
		let l:bufN = bufnr(goTermWinName)
		exec ":bdelete ".bufN
		return
	endif
	let l:shTermWinName = "!bash ".currentBufName
	let l:ifShTerm = bufexists(shTermWinName)
	if ifShTerm == 1
		let l:bufN = bufnr(shTermWinName)
		exec ":bdelete ".bufN
		return
	endif

	if &filetype == 'go'
		" run current file
"		:GoRun %
		:rightbelow vert term ++cols=40 go run %
		":term go run .
	elseif &filetype == 'sh'
		":!time bash %
		:rightbelow vert term ++cols=50 bash %
	elseif &filetype == 'html'
		"silent! exec "!".g:mkdp_browser." % &"
	elseif &filetype == 'markdown'
		"exec "InstantMarkdownPreview"
	elseif &filetype == 'javascript'
		"set splitbelow
		":sp
		":term export DEBUG="INFO,ERROR,WARNING"; node --trace-warnings .
	endif
endfunc
"autocmd bufenter * if (winnr("$") == 2 && exists("b:NERDTree") && b:NERDTreeType == "primary") | qa | endif

"nmap <space>m :call TestMyCode()<CR>
"fun TestMyCode()
"	let l:currentBufName = bufname("%")
"	let l:ifSh = matchstr(currentBufName, "bash .*\.sh")
"	echom ifSh
"endfun

augroup myAutoExitGroup
	autocmd!
	autocmd bufenter * silent call AutoExitWin()
augroup END
func AutoExitWin()
	let l:currentBufName = bufname("%")
	let l:currentWinN = winnr()
	let l:ifGoTerm = matchstr(currentBufName, "^!go run .*\.go")
	let l:ifSh = matchstr(currentBufName, "^!bash .*\.sh")
	let l:firstWinBuf = winbufnr(1)
"	echom ifSh
	if ifGoTerm != "" && currentWinN == 1
		exe "q"
	endif
"	if currentBufName == "" && currentWinN == 1 && firstWinBuf > 1
	" parameter 2 : avoid open other window appear exit
	if currentBufName == "" && currentWinN == 1
		exe "q"
	endif
	if ifSh != "" && currentWinN == 1
		exe "q"
	endif
endfun



" au[tocmd] [group] {event} {pat} [nested] {cmd}
" BufEnter : may tell you file is changed
augroup myInitNewFileGroup
	" clear old command of myInitNewFile
	autocmd!
	" do what you want
	autocmd BufNewFile *.go,*.sh,*.proto,*.md silent call MyInitNewFileFuc()
	"autocmd BufNewFile *.go,*.sh 0r ~/vim/skeleton.go
augroup END

fun MyInitNewFileFuc()
	" system("InitNewFile.sh", getcwd() bufname("%"))
	:r! ~/.vim/InitNewFile.sh `pwd` %
	:%s/^\n//
	:%s/口口口//
endfun



augroup myExitFileAddXGroup
	autocmd!
	autocmd BufWritePost *.sh silent call MyExitFileAddX()
augroup END

fun MyExitFileAddX()
	if &filetype == "sh"
		let l:fileName = bufname("%")
		let l:myPerm = getfperm(fileName)
		let l:ifX = matchstr(myPerm, "x")
		if ifX == ""
			call setfperm(fileName,"rwxrwxr-x")
		endif
		":r! chmod +x %
		"let kkkk = system(l:ddd)
	endif
endfun



nnoremap <silent> yy yy:call SystemCopy()<CR>
xnoremap <silent> y y:call SystemCopy()<CR>
fun SystemCopy()
	let l:currentYY = getreg()
	let l:actualYY = strpart(currentYY, 0, strlen(currentYY)-1)
	let l:escape1 = substitute(actualYY, '\', '\\\','g')
	let l:escape2 = substitute(escape1, '`', '\\`','g')
	let l:escape3 = substitute(escape2, "#", "\\\\#",'g')
	let l:escape4 = substitute(escape3, "%", "\\\\%",'g')
	let l:escape5 = substitute(escape4, "?", "\\\\?",'g')
	let l:escape6 = substitute(escape5, "}", "\\\\}",'g')
	let l:escape7 = substitute(escape6, "[", "\\\\[",'g')
	let l:escape8 = substitute(escape7, "]", "\\\\]",'g')
	let l:escape = substitute(escape5, "{", "\\\\{",'g')
	call system("echo ".shellescape(expand(escape))." | xsel -b")
endfun



" match string int bool \t}
"autocmd Filetype go nmap <silent> <c-j> <Esc>/".*"\\|[+-]\?\d\+\(\.\d*\)\?\\|false\\|\t}<CR>
"autocmd Filetype go nmap <silent> <c-k> <Esc>?".*"\\|[+-]\?\d\+\(\.\d*\)\?\\|false\\|\t}<CR>
"autocmd Filetype go imap <silent> <c-j> <Esc>/".*"\\|[+-]\?\d\+\(\.\d*\)\?\\|false\\|\t}<CR>
"autocmd Filetype go imap <silent> <c-k> <Esc>?".*"\\|[+-]\?\d\+\(\.\d*\)\?\\|false\\|\t}<CR>
" match : := =
"autocmd Filetype go nmap <silent> <c-j> <Esc>/: \\|:= \\|= \\|\t}\\|\t)<CR>w
"autocmd Filetype go nmap <silent> <c-k> <Esc>?: \\|:= \\|= \\|\t}\\|\t)<CR>nw
"autocmd Filetype go imap <silent> <c-j> <Esc>/: \\|:= \\|= \\|\t}\\|\t)<CR>w
"autocmd Filetype go imap <silent> <c-k> <Esc>?: \\|:= \\|= \\|\t}\\|\t)<CR>nw
"autocmd Filetype go imap <silent> <c-n> <Esc>/\t}\\|\t)<CR>w
autocmd Filetype go nmap <silent> <c-j> <Esc>/^\t*}\\|^\t*)<CR>o
autocmd Filetype go imap <silent> <c-j> <Esc>/^\t*}\\|^\t*)<CR>o
autocmd Filetype go vmap <silent> <c-j> <Esc>/^\t*}\\|^\t*)<CR>o
"autocmd Filetype go nmap <silent> <c-k> <Esc>0?^\t*}\\|^\t*)<CR>f}f)
"autocmd Filetype go imap <silent> <c-k> <Esc>0?^\t*}\\|^\t*)<CR>f}f)
autocmd Filetype go nmap <silent> <c-k> o
"autocmd Filetype go imap <silent> <c-k> <esc>vl<esc>o
autocmd Filetype go imap <silent> <c-k> a<esc>xvl<esc>o
autocmd Filetype go vmap <silent> <c-k> <esc>o
"autocmd Filetype go imap <silent> <c-k> <esc>:call MyNextLine()<cr><esc>
"autocmd Filetype go,sh imap <silent> <esc> <esc>:call UltiSnips#JumpForwards()<cr><esc><c-[>



augroup myAutoFillErrGroup
	autocmd!
	autocmd TextChangedI *.go silent exec "call AutoFillErr()"
augroup END

fun AutoFillErr()
	if &filetype == 'go'
		let l:currentText = getline(".")
		let l:currentIfErr = matchstr(currentText, '\t\+.*err *:\?= *\w*\.\?\w\+(.*)$')

		if currentIfErr != ""
			let l:nextText = getline(line(".")+1)
			let l:lastIfCan = matchstr(nextText, 'if err != nil {')
			if lastIfCan == ""
				let l:currentLine = line(".")
				let l:lineTab = matchstr(getline("."), '\t\+')
				call append(line("."), lineTab."}")
				"call append(line("."), "")
				call append(line("."), lineTab."\treturn <???>")
				call append(line("."), lineTab."if err != nil {")
			endif
		endif

	endif
endfun



augroup myAutoFillMapGroup
	autocmd!
	autocmd TextChangedI *.go silent exec "call AutoFillMap()"
augroup END

fun AutoFillMap()
	if &filetype == 'go'
		let l:lastText = getline(line(".")-1)
		let l:lastIfMapHead = matchstr(lastText, '\w\+ *:= *map\[\w\+\]\w\+{$')

		" new map
		if lastIfMapHead != ""
			let l:nextText = getline(line(".")+1)
			let l:nextIfMapHead = matchstr(nextText, '\t\+}$')
			if nextIfMapHead != ""
				let l:currentText = getline(".")
				let l:currentIfMap = matchstr(currentText, '\t\+$')
				if currentIfMap != ""
					let l:currentLine = line(".")
					let l:myCol = col(".")
					"let l:lineTab = matchstr(getline("."), '\t\+')
					let l:newMapKey = matchstr(lastIfMapHead, ".*\]")
					let newMapKey = matchstr(newMapKey, "map\[.*")
					let l:newMapVal = matchstr(lastIfMapHead, "\].*{")
					let l:setMapVal = '<value>'
					if newMapVal == "]string{"
						let setMapVal = '"s"'
					elseif newMapVal == "]bool{"
						let setMapVal = 'true'
					elseif newMapVal == "]int{"
						let setMapVal = '1'
					elseif newMapVal == "]int64{"
						let setMapVal = '1'
					elseif newMapVal == "]float64{"
						let setMapVal = '1.0'
					endif
					"call setline(currentLine, lineTab.setMapVal."END")
					if newMapKey == "map[string]"
						call setline(currentLine, currentIfMap.'"k": '.setMapVal.',')
						let myCol = myCol + 1
					else
						call setline(currentLine, currentIfMap.'k: '.setMapVal.',')
					endif
					:stopinsert
					norm 0fks
					call cursor(currentLine, myCol)
				endif
			endif
		endif

		" insert map
		let l:lastIfMap = matchstr(lastText, '\t\+.\+: *.\+,$')
		if lastIfMap != ""
			let l:nextText = getline(line(".")+1)
			let l:nextIfMapA = matchstr(nextText, '\t\+}$')
			let l:nextIfMapB = matchstr(nextText, '\t\+.\+: *.\+,$')
			if nextIfMapA != "" || nextIfMapB != ""
				let l:currentText = getline(".")
				let l:currentIfMap = matchstr(currentText, '\t\+$')
				if currentIfMap != ""
					let l:currentLine = line(".")
					let l:myCol = col(".")
					"let l:lineTab = matchstr(getline("."), '\t\+')
					let l:newMapType = matchstr(lastIfMap, '\".*\":')
					let l:newMapValu = matchstr(lastIfMap, ': *.*,')
					"call setline(currentLine, newMapValu)
					if newMapType != ""
						call setline(currentLine, currentIfMap.'"k"'.newMapValu)
						let myCol = myCol + 1
					else
						call setline(currentLine, currentIfMap.'k'.newMapValu)
					endif
					:stopinsert
					norm 0fks
					call cursor(currentLine, myCol)
				endif
			endif
		endif
	endif
endfun



augroup myAutoFillStructGroup
	autocmd!
	autocmd TextChangedI *.go silent exec "call AutoFillStruct()"
augroup END

"autocmd Filetype go imap <silent> <c-k> <Esc>?: \\|:= \\|= \\|\t}<CR>nw
fun AutoFillStruct()
	if &filetype == 'go'
		let l:lastText = getline(line(".")-1)
		let l:lastIfStruct = matchstr(lastText, '\w\+ *:= *&\?\w\+{$')

		if lastIfStruct != "" 
			let l:nextText = getline(line(".")+1)
			let l:nextIfStruct = matchstr(nextText, '\t\+}$')
			if nextIfStruct != ""
				let l:currentText = getline(".")
				let l:currentIfStruct = matchstr(currentText, '\t\+$')
				if currentIfStruct != ""
					let l:currentLine = line(".")
					"let l:lastLineTab = matchstr(getline(currentLine-1), '\t\+')
					"let l:structVar = tolower(matchstr(ifStruct, '[a-z,A-Z,0-9]\+{  }'))
					"let l:myCol = col(".")+3
					"call setline(currentLine, lastLineTab.structVar." := ".ifStruct)
					"call cursor(currentLine, myCol)
					":GoFillStruct<CR>[m/:<CR>w
					:GoFillStruct
					:stopinsert
					call cursor(currentLine, 1)
					norm $
					let l:wordEnd = col(".")
					" end of follow have <space>
					norm F 
					let l:wordStart = col(".")
					call cursor(currentLine, wordEnd-1)
					norm gh
					call cursor(currentLine, wordStart+1)
	"				norm $vF \<c-g>
				endif
			endif
		endif
	endif
endfun



"autocmd Filetype go imap <silent> <c-l> <Esc>:call JumpPreVal()<CR>
autocmd Filetype go imap <silent> <c-l> <Esc>:call JumpNextVal()<CR>
"autocmd Filetype go vmap <silent> <c-l> <Esc>:call JumpPreVal()<CR>
autocmd Filetype go vmap <silent> <c-l> <Esc>:call JumpNextVal()<CR>
"fun JumpPreVal()
	"call search(".*:.*,","b")
	"let l:currentLine = line(".")
	"norm $
	"let l:wordEnd = col(".")
	" "end of follow have <space>
	"norm F 
	"let l:wordStart = col(".")
	"call cursor(currentLine, wordEnd-1)
	"norm gh
	"call cursor(currentLine, wordStart+1)
"endfun
fun JumpNextVal()
	let l:oldPosiLine = line(".")
	let l:oldPosiCol = col(".")
	let l:preFunHead = search("\t\t*.*\w*{$","bnWc")
	"call cursor(oldPosiLine, oldPosiCol)
	let l:preFunEnd = search("\t*}$","bnWc")
	"call cursor(oldPosiLine, oldPosiCol)
	"call setline(oldPosiLine, preFunHead.".".preFunEnd.".".oldPosiLine)

	" judge under function head
	if preFunHead > preFunEnd && preFunHead != oldPosiLine
		let l:nextFunEnd = search("\t*}$","nW")
		let l:nextFunHead = search("\t*.*{$","nW")
		"call setline(oldPosiLine, nextFunEnd."-".nextFunHead)

		" judeg over function end
		if nextFunEnd < nextFunHead || nextFunHead == 0
			"call setline(oldPosiLine, currentLineA)
			let l:newPosi = search(": *.*,","n")
			" make circle
			let l:ifInFun = "0"
				"call setline(oldPosiLine, newPosi)
			if oldPosiLine+1 == nextFunEnd && newPosi+1 != nextFunEnd
				"call setline(oldPosiLine, nextFunEnd)
				let ifInFun = "1"
				let newPosi = preFunHead+1
				call cursor(preFunHead, oldPosiCol)
			endif
			" judge object in function
			let l:haveField = search(": *.*,","n")
			if newPosi > preFunHead && newPosi < nextFunEnd && haveField > preFunHead && haveField < nextFunEnd
				let ifInFun = "0"
				" make can jump to current line
				call search(": *.*,")
				let l:currentLine = line(".")
				norm $
				let l:wordEnd = col(".")
				" end of follow have <space>
				norm F 
				let l:wordStart = col(".")
				call cursor(currentLine, wordEnd-1)
				norm gh
				call cursor(currentLine, wordStart+1)
			endif
			if ifInFun == "1"
				call cursor(oldPosiLine, oldPosiCol)
			endif
		endif
	else
		"let l:objectPosi = search("<???>","n")
		"if objectPosi != 0
		let canFind = search("<???>")
		if canFind != 0
			let l:curLine = line(".")
			let l:wordStart = col(".")
			norm f>
			norm gh
			call cursor(curLine, wordStart)
		endif
		"endif
	endif
endfun



"augroup myAutoAnnotationGroup
"	autocmd!
"	autocmd TextChangedI *.go silent exec "call AutoAnnotation()"
"augroup END
"fun AutoAnnotation()
"	let l:currentText = getline(".")
"
"	let l:funcText = matchstr(currentText, 'func \w\+()')
"	if funcText != ""
"		let l:funcName = matchstr(matchstr(currentText, '\w\+()'), '[a-z,A-Z,0-9,_]\+')
"		let l:lastLine = line(".")-1
"		let l:lastText = getline(lastLine)
"		let l:lastHead = matchstr(lastText, '// \w\+ ')
"		if lastHead != "// ".funcName." "
"			call append(lastLine, "// ".funcName." ")
"		endif
"		"call append(line(".")-2, myLastText."XX")
"	endif
"
"endfun



autocmd Filetype go,sh,proto,vim nmap <silent> <c-h> :call DoAnnotation()<CR>
fun DoAnnotation()
	if &filetype == 'proto' || &filetype == 'go'
		let l:myCurrentText = getline(".")
		let l:myText = matchstr(myCurrentText, '^\t* *//.*')
		"call append(line(".")+1, myText)
		if myText == ""
			" not have annotation
			:execute "normal ^i//\<Esc>j"
		else
			" have annotation
			:normal ^xxj
		endif
	endif
	if &filetype == 'sh'
		let l:myCurrentText = getline(".")
		let l:myText = matchstr(myCurrentText, '^\t* *#.*')
		"call append(line(".")+1, myText)
		if myText == ""
			" not have annotation
			:execute "normal ^i#\<Esc>j"
		else
			" have annotation
			:normal ^xj
		endif
	endif
	if &filetype == 'vim'
		let l:myCurrentText = getline(".")
		let l:myText = matchstr(myCurrentText, '^\t* *".*')
		"call append(line(".")+1, myText)
		if myText == ""
			" not have annotation
			:execute "normal ^i\"\<Esc>j"
		else
			" have annotation
			:normal ^xj
		endif
	endif
endfun



"autocmd Filetype * nnoremap <silent> <expr><S-CR> dd<CR>
"inoremap <expr> <cr> coc#_select_confirm()
augroup mySnippetGroup
	autocmd!
	autocmd TextChangedP *.go silent call MyAutoSnippetP()
	autocmd TextChangedI *.go silent call MyAutoSnippetI()
augroup END
fun MyAutoSnippetP()
"	let l:ifExpand = pumvisible()
"	let l:curCol = col(".")
"	exe "norm <c-y>"
"	call cursor(".", curCol+1)

	let l:currentText = getline(".")
	let l:funcText = matchstr(currentText, '^\t*..$')
"	call system("echo ".shellescape(expand(currentText))." | xsel -b")
	if funcText != ""
		call UltiSnips#ExpandSnippet()
	endif

"	let l:kkk = coc#refresh()
endfun
fun MyAutoSnippetI()
	let l:currentText = getline(".")
	let l:funcText = matchstr(currentText, '^\t*..$')
"	call system("echo ".shellescape(expand(currentText))." | xsel -b")
	if funcText != ""
		call UltiSnips#ExpandSnippet()
	endif

"	:call coc#refresh()
endfun





" ================================
" ===plug manager
" ================================
" more plug search : vimawesome.com
filetype plugin on
filetype plugin indent on
call plug#begin('~/.vim/plugged')
"Plug 'fatih/molokai'
"Plug 'dense-analysis/ale'
Plug 'gvls/vim-go-markdown-colors'
" neoranger rnvimr
Plug 'francoiscabrol/ranger.vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-surround'
" need install nodejs npm yarn
Plug 'neoclide/coc.nvim', {'branch':'release'}
Plug 'jiangmiao/auto-pairs', {'for':['go','vim','sh','markdown','json','proto']}
Plug 'fatih/vim-go', {'for':'go', 'do':':GoInstallBinaries'}
Plug 'ctrlpvim/ctrlp.vim', {'for':'go'}
Plug 'SirVer/ultisnips', {'for':'go'}
Plug 'buoto/gotests-vim', {'for':'go'}
" need cd directory and go build
Plug 'tenfyzhong/gengotag', {'for': 'go'}
Plug 'vim-scripts/argtextobj.vim', {'for':'go'}
"Plug 'junegunn/fzf.vim'
"Plug 'junegunn/fzf'
"Plug 'ianva/vim-youdao-translater'
"Plug 'preservim/nerdcommenter', {'for':['go','vim']}
"Plug 'honza/vim-snippets', {'for':'go'}
Plug 'godlygeek/tabular', {'for':['markdown','vim']}
Plug 'dhruvasagar/vim-table-mode', {'for':'markdown'}
"Plug 'preservim/vim-markdown', {'for':'markdown'}
"Plug 'junegunn/vim-easy-align'
":call mkdp#util#install()
"Plug 'vim-signiture'
call plug#end()
" PlugInstall
function! UpdateMyAllPlugins()
	exec "PlugUpgrade"
	exec "PlugUpdate"
	exec "GoUpdateBinaries"
endfunction





" ================================
" ===colors
" ================================
"code hight light
syntax enable
syntax on
" :so $VIMRUNTIME/syntax/hitest.vim
color vim-go-markdown-colors
" molokai
"let g:rehash256 = 1
"let g:molokai_original = 1
"colorscheme molokai





" ================================
" ===ranger
" ================================
let g:ranger_map_keys = 0
nmap <silent> <space>ra :RangerCurrentFileExistingOrNewTab<CR>





" ================================
" ===gitgutter
" ================================
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '~'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '^^'
let g:gitgutter_sign_removed_above_and_below = '{'
let g:gitgutter_sign_modified_removed = '~-'
function! GitStatusA()
  let [a,m,r] = GitGutterGetHunkSummary()
  return a > 0?''.a.'':' '
"  return printf('+%d ~%d -%d', a, m, r)
endfunction
function! GitStatusM()
  let [a,m,r] = GitGutterGetHunkSummary()
  return m > 0?''.m.'':' '
endfunction
function! GitStatusR()
  let [a,m,r] = GitGutterGetHunkSummary()
  return r > 0?''.r.'':' '
endfunction





" ================================
" ===vim-table-mode
" ================================
"function! s:isAtStartOfLine(mapping)
"  let text_before_cursor = getline('.')[0 : col('.')-1]
"  let mapping_pattern = '\V' . escape(a:mapping, '\')
"  let comment_pattern = '\V' . escape(substitute(&l:commentstring, '%s.*$', '', ''), '\')
"  return (text_before_cursor =~? '^' . ('\v(' . comment_pattern . '\v)?') . '\s*\v' . mapping_pattern . '\v$')
"endfunction
"inoreabbrev <expr> <bar><bar>
"          \ <SID>isAtStartOfLine('\|\|') ?
"          \ '<c-o>:TableModeEnable<cr><bar><space><bar><left><left>' : '<bar><bar>'
"inoreabbrev <expr> __
"          \ <SID>isAtStartOfLine('__') ?
"          \ '<c-o>:silent! TableModeDisable<cr>' : '__'





" ================================
" ===ultisnips
" ================================
" Trigger configuration. You need to change this to something other than <tab> if you use one of the following:
" - https://github.com/Valloric/YouCompleteMe
" - https://github.com/nvim-lua/completion-nvim
let g:UltiSnipsExpandTrigger=",e"
"let g:UltiSnipsJumpForwardTrigger="<c-b>"
"let g:UltiSnipsJumpForwardTrigger=",f"
let g:UltiSnipsJumpForwardTrigger="<c-l>"
"let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsJumpBackwardTrigger=",F"
"let g:UltiSnipsSnippetDirectories =['','']

" If you want :UltiSnipsEdit to split your window.
"let g:UltiSnipsEditSplit="vertical"

let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/UltiSnips'] 





" ================================
" ===vim-go===
" ================================
"autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
autocmd Filetype go nmap <space>gM <esc>?\w\+(<cr>
autocmd Filetype go nmap <space>gm <esc>/\w\+(<cr>

autocmd Filetype go nmap <space>gc :GoRename<space>

autocmd Filetype go nmap <space>gC :GoChannelPeers<space>

autocmd Filetype go nmap <silent> <space>ga :GoAlternate<CR>

" go to definition use guru but it may slow
"let g:go_def_mode = 'godef'
autocmd Filetype go nmap <silent> <space>gd :GoDef<CR>
autocmd Filetype go nmap <silent> <space>gD :GoDefType<CR>
autocmd Filetype go nmap <silent> <space>gb :GoDefPop<CR>
"nmap <silent> <space>gs :GoDefStack<CR>

" cnext cprevious cclose lnext lprevious lclose
"let g:go_list_type = "quickfix"
autocmd Filetype go nmap <space>gk :lprevious<cr>
autocmd Filetype go nmap <space>gj :lnext<cr>
autocmd Filetype go nmap <space>g[ :lclose<cr>
autocmd Filetype go nmap <space>gi :GoImplements<cr>
autocmd Filetype go nmap <space>gI :GoImpl<space>

"let g:go_fillstruct_mode = 'fillstruct'
let g:go_fillstruct_mode = 'gopls'
autocmd Filetype go nmap <silent> <space>gs :GoFillStruct<CR>[m/:<CR>w

autocmd Filetype go nmap <silent> <space>gv :GoSameIdsAutoToggle<CR>

" show funciton struct
"let g:go_decls_includes = "func,type"
autocmd Filetype go nmap <silent> <space>gf :GoDecls<CR>
autocmd Filetype go nmap <silent> <space>gF :GoDeclsDir<CR>

" Possible options are: `snakecase`(_), `camelcase`(aBc), `lispcase`, `pascalcase`, `keep`
autocmd Filetype go nmap <space>gt :GoAddTags<space>
autocmd Filetype go nmap <space>gT :GoRemoveTags<space>
" `snakecase`, `camelcase`, `lispcase`, `pascalcase`, `keep`
let g:go_addtags_transform = 'camelcase'

"dif, daf...
" jump to error
":cnext
":cprevious
":cclose

"let g:go_list_type = "quickfix"

" debug window
let g:go_debug_windows = {
		\ 'vars':       'leftabove 40vnew',
		\ 'stack':      'botright 3new',
	  \ }
		"\ 'goroutines': 'botright 3new',
		"\ 'out':        'botright 5new',
" debug key mapping
let g:go_debug_breakpoint_sign_text = '='
let g:go_debug_mappings = {
	     \ '(go-debug-print)':      {'key': '<F3>'},
	     \ '(go-debug-breakpoint)': {'key': '<F4>'},
	     \ '(go-debug-continue)':   {'key': '<F5>'},
	     \ '(go-debug-next)':       {'key': '<F6>'},
	     \ '(go-debug-step)':       {'key': '<F7>'},
	     \ '(go-debug-stepout)':    {'key': '<F8>'},
	     \ '(go-debug-halt)':       {'key': '<F10>'},
	     \ '(go-debug-restart)':    {'key': '<F11>'},
	     \ '(go-debug-stop)':       {'key': '<F12>'},
	  \ }

"show type of function , variate
let g:go_auto_type_info = 1

" update time
let g:go_updatetime = 100

" hilight for same variate
"let g:go_auto_sameids = 0
"
" inside terminal
let g:go_term_enabled = 1
let g:go_term_width = 40
"let g:go_term_height = 5
let g:go_term_mode = "rightbelow vsplit"

" do after save 
"let g:go_fmt_autosave = 1
"let g:go_imports_autosave = 1
"let g:go_mod_fmt_autosave = 1
"let g:go_asmfmt_autosave = 0
"let g:go_template_autocreate = 1
"let g:go_fmt_command = "goimports"

let g:go_metalinter_autosave = 1
"let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
let g:go_metalinter_command = "gopls"
"let g:go_metalinter_deadline = "5s"

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let	g:go_highlight_function_calls = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_operators = 1
let g:go_highlight_variable_declarations = 1
" build flag on head of file
"let g:go_highlight_build_constraints = 1
" hightlight generate text
"let g:go_highlight_generate_tags = 1

"let g:go_highlight_structs = 1
"let g:go_highlight_extra_types = 1


"let g:go_highlight_array_whitespace_error = 1
"let g:go_highlight_chan_whitespace_error = 1
"let g:go_highlight_format_strings = 0
"let g:go_highlight_functions = 1
"let g:go_highlight_methods = 0
"let g:go_highlight_space_tab_error = 1
"let g:go_highlight_string_spellcheck = 1
"let g:go_highlight_trailing_whitespace_error = 1
"let g:go_highlight_variable_assignments = 1
"let g:go_doc_keywordprg_enabled = 





" ================================
" ===coc
" ================================
" :h coc-variable
"let g:coc_node_path =

" automaticly install extensions when open vim
"let g:coc_global_extensions = ['coc-snippets', 'coc-translator']
"let g:coc_global_extensions = ['coc-snippets']
"imap ,e <Plug>(coc-snippets-expand)

" TextEdit might fail if hidden is not set.
"set hidden

" Some servers have issues with backup files, see #649.
"set nobackup
"set nowritebackup

" Give more space for displaying messages.
"set cmdheight=1

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=100

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
" number of line and sign in same column
if has("nvim-0.5.0") || has("patch-8.1.1564")
	" Recently vim can merge signcolumn and number column into one
	"set signcolumn=number
	set signcolumn=yes
else
	set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
	\ pumvisible() ? "\<C-n>" :
	\ <SID>check_back_space() ? "\<TAB>" :
	\ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
"inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction
"return !col || getline('.')[col - 1]  =~ '\s'

" Use <c-space> to trigger completion.
" call complement
if has('nvim')
	autocmd Filetype go,vim inoremap <silent><expr> <c-space> coc#refresh()
else
	autocmd Filetype go,vim inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
"inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
	"\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
" swtich next error
"nmap <silent> [g <Plug>(coc-diagnostic-prev)
"nmap <silent> ]g <Plug>(coc-diagnostic-next)
autocmd Filetype go,vim nmap <silent> <space>gN <Plug>(coc-diagnostic-prev)
autocmd Filetype go,vim nmap <silent> <space>gn <Plug>(coc-diagnostic-next)

" GoTo code navigation.
" go to define and show path of file
"autocmd Filetype go,vim nmap <silent> <space>gd <Plug>(coc-definition)
"nmap <silent> gy <Plug>(coc-type-definition)
"nmap <silent> gi <Plug>(coc-implementation)
" go to place of use
autocmd Filetype go,vim nmap <silent> <space>gu <Plug>(coc-references)
autocmd Filetype go,vim nmap <silent> <space>gl <plug>(coc-openlink)
"nmap <silent> <space>gc <plug>(coc-rename)

" call help
autocmd Filetype go,vim nnoremap <silent> <space>gh :call CocActionAsync('doHover')<cr>

" Use K to show documentation in preview window.
"nnoremap <silent> K :call <SID>show_documentation()<CR>
"function! s:show_documentation()
	"if (index(['vim','help'], &filetype) >= 0)
		"execute 'h '.expand('<cword>')
	"elseif (coc#rpc#ready())
		"call CocActionAsync('doHover')
	"else
		"execute '!' . &keywordprg . " " . expand('<cword>')
	"endif
"endfunction

" Highlight the symbol and its references when holding the cursor.
"autocmd FileType go autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
"nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
"xmap <leader>f  <Plug>(coc-format-selected)
"nmap <leader>f  <Plug>(coc-format-selected)

"augroup mygroup
	"autocmd!
	"" Setup formatexpr specified filetype(s).
	"autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
	"" Update signature help on jump placeholder.
	"autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
"augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
"xmap <leader>a  <Plug>(coc-codeaction-selected)
"nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
"nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
"nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
"xmap if <Plug>(coc-funcobj-i)
"omap if <Plug>(coc-funcobj-i)
"xmap af <Plug>(coc-funcobj-a)
"omap af <Plug>(coc-funcobj-a)
"xmap ic <Plug>(coc-classobj-i)
"omap ic <Plug>(coc-classobj-i)
"xmap ac <Plug>(coc-classobj-a)
"omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
"if has('nvim-0.4.0') || has('patch-8.2.0750')
	"nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
	"nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
	"inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
	"inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
	"vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
	"vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
"endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
"nmap <silent> <C-s> <Plug>(coc-range-select)
"xmap <silent> <C-s> <Plug>(coc-range-select)
"
" Add `:Format` command to format current buffer.
"command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
"command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
"command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
"set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
"nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
"nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
"nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
"nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
"nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
"nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
"nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
"nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
let g:coc_default_semantic_highlight_groups = 1
"call coc#config('languageserver', {
"			\ 'ccls': {
"			\   "command": "ccls",
"			\   "trace.server": "verbose",
"			\   "filetypes": ["c", "cpp", "objc", "objcpp"]
"			\ }
"			\})





" ================================
" ===auto-pairs
" ================================
"let g:AutoPairsShortcutFastWrap = '<c-l>'
let g:AutoPairsMapSpace = 0





" ================================
" ===nerdtree
" ================================
" Exit Vim if NERDTree is the only window remaining in the only tab.
"autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
let g:NERDTreeWinSize = 15





" ================================
" ===gotests
" ================================
let g:gotests_bin = '/home/zombie/go/bin/gotests'
