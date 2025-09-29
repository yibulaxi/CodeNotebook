# vi (Visual) 文本编辑器 、vim配置

启动 vi: `vi [filename]`

# 两种模式
vi 编辑器命令采用快捷键，如果输入一个字符可能是文件内容也可能是命令，所以提供两种模式：
- `命令模式` ( `Command Mode` )，输入控制命令。
- `插入模式` ( `Insert Mode` )，编辑文件。

## 启动 vi 时，进入`命令模式`。
- 在插入模式时，按 `Esc` 进入`命令模式`。
- 输入插入命令，进入`插入模式`。插入模式进入命令：
  - `a`: 从 光标 后面 开始输入文本
  - `A`: 从 光标的行 后面 开始输入文本
  - `i`: 从 光标 前面 开始输入文本
  - `I`: 从 光标的行 前面 开始输入文本
  - `o`: 在 光标的行 后面 插入一行
  - `O`: 在 光标的行 前面 插入一行
```
|命令| → a,A,i,I,o,O → |插入|
|模式| ←     ESC     ← |模式|
```

# 命令模式命令
- `:help`:     帮助
- `:q`:        退出vi
- `:w <另存为>`:  保存
- `:w! <另存为>`: 保存（覆盖已有文件）
- `:wq`:       保存并退出
- `:q!`:       不保存并退出
- `:! <命令>`:   执行 Shell 命令
- `:r <文件名>`:  读和插入指定文件内容到当前光标位置（粘贴自）

## 命令模式快捷键
- `d`: 删除字( `w`ord ), 行( line )
- `u`: 撤销最后的编辑操作（重做）
- `y`: 复制(yank)
- `p`: 在当前行 后 粘贴已复制或删除的行
- `P`: 在当前行 前 粘贴已复制或删除的行
- `L`: →
- `H`: ←
- `J`: ↓
- `K`: ↑
- `0`: 回到本行开头

# 命令的格式
一般命令的按键语法如下：
- `[#1]operation [#2]target`
  - #1 是可选的数字，指定操作的次数
  - operation 指定操作
  - #2 是可选的数字，指定操作影响的目标数目
  - target 指定操作的目标

- 字(`word`)是空字符(空格、回车、换行)分割的字符串
  - `aaa bbb ccc`
- 如果当前字是操作的目标，输入w word
- 如果当前行是操作的目标，目标的语法和操作的语法相同。

## 命令举例
- `dw`: 删除当前光标所在的字
  - `aaa bbb ccc` -> `bbb ccc`
  - `^          `
  - `aaa bbb ccc` -> `abbb ccc`
  - ` ^         `
- `d5w` / `5dw`: 删除5个字(`w`ord)，从当前光标位置开始
  - `aaa bbb ccc ddd eee fff` -> `fff`
  - `^                      `
  - `5dw`: 删除一个字，执行5次
  - `d5w`: 一次删除5个字，执行1次
  - `2d3w`: 删除3个字，执行2次，实际删除6个字 = `6dw` = `d6w`
- `dd`: 删除光标所在的1行（如果当前行是操作的目标，目标的语法和操作的语法相同）
- `2dd`: 删除2行，从当前行开始
  - `aaa` -> `ccc`
  - `bbb`
  - `ccc`
- `:2,3d`: 删除第2-3行
  - `aaa` -> `aaa`
  - `bbb` -> `ddd`
  - `ccc`
  - `ddd`
- `yy`: 复制当前行
- `1G`: 把光标移动到文件的第1行
  - `5G`: 把光标移动到文件的第5行
- `G`: 把光标移动到文件的第最后1行
- `dG`: 删除当前行和之后的所有行

# 查找和替换

## 查找
`/str`: 查找 str 字符串
1. 光标移动到 从哪开始找 的位置。
2. 直接输入 `/` （不是 `:/` ）
3. 输入查找关键字，例如 `/bbb`
4. 按 `n` 查找下一个

## 替换
`:[range]s/old_string/new_string[/option]`

- `range`: 指定搜索范围，如果忽略，那么指定当前行
- `s`: 指定替换命令
- `/`: 搜索定界符
- `old_string`: 将要被替换的文本
- `/`: 替换定界符
- `new_string`: 替换之后的新文本
- `/option`: 修饰符，g表示全部(global)

### 替换命令举例
- `:s/john/jane/`:      把john替换为jane，在当前行中，替换1次。
- `:s/john/jane/g`:     把john替换为jane，在当前行中，全部替换。
- `:1,10s/john/jane/g`: 把john替换为jane，在1-10行中，全部替换。
- `:1,$s/john/jane/g`:  把john替换为jane，在整个文件中，全部替换。

# 设置 vi 环境
使用 `:set` 命令设置 vi 工作环境。

## 例子
- `:set nu`: 显示行号

## 光标与界面
- :set number          " 显示行号
- :set relativenumber  " 相对行号，适合移动/复制
- :set cursorline      " 高亮当前行
- :set ruler           " 在右下角显示光标位置
- :set showmode        " 显示当前模式（如 --INSERT--）
- :set showcmd         " 显示部分命令
- :set laststatus=2    " 总是显示状态栏
- :set title           " 显示当前文件名在终端标题

## 缩进与格式
- :set autoindent      " 自动缩进（关闭：noautoindent）
- :set smartindent     " 智能缩进（关闭：nosmartindent）
- :set tabstop=4       " Tab 显示为 4 个空格
- :set shiftwidth=4    " 自动缩进宽度 4
- :set expandtab       " 用空格代替 Tab
- :set softtabstop=4   " Tab 键输入时相当于 4 个空格

## 搜索与匹配

- :set ignorecase      " 搜索时忽略大小写
- :set smartcase       " 若包含大写字母，则区分大小写
- :set hlsearch        " 高亮搜索结果
- :set incsearch       " 输入搜索时实时匹配
- :set showmatch       " 高亮匹配的括号

## 编辑体验

- :set backspace=2     " 插入模式下可以删除换行符等
- :set clipboard=unnamedplus " 使用系统剪贴板
- :set wildmenu        " 命令补全菜单
- :set history=1000    " 历史命令数
- :set undolevels=1000 " 撤销次数

## 文件与编码

- :set encoding=utf-8
- :set fileencoding=utf-8
- :set fileencodings=utf-8,ucs-bom,gbk,cp936,latin1
- :set autoread        " 文件在外部被修改时自动加载
- :set hidden          " 允许在未保存的情况下切换 buffer

## 性能优化

- :set lazyredraw      " 宏执行时不重绘
- :set ttyfast         " 提高终端速度

## 鼠标点击进入可视模式

- 默认情况下，如果 set mouse=a，在终端里用鼠标点文本就会进入 Visual 模式，还可能拖动选区。
- :set mouse-=v  在已有设置的基础上，去掉 v (visual 模式的鼠标支持)。
- :set mouse=    清空 mouse 选项，表示 完全禁用鼠标功能。
  - n Normal 普通模式下启用鼠标
  - v Visual 可视模式下启用鼠标
  - i Insert 插入模式下启用鼠标
  - c Command-line 命令行模式下启用鼠标
  - h all windows with horizontal splits 水平分割窗口时启用
  - a all modes (nvi) 相当于 nvi 的简写，常见配置
  - r for hit-enter and more-prompt 在 -- More -- 等提示时启用
  - A all 包含所有模式，等于 nvich

# vim设置 持久设置
- 设置环境只对当前会话有效。
- 可以把环境设置保存在用户主目录的 `~/.exrc` 文件中，可单行可多行。
  - 单行： `set number cursorline ruler showmode showcmd laststatus=2 title noautoindent nosmartindent tabstop=4 shiftwidth=4 expandtab softtabstop=4 ignorecase smartcase hlsearch showmatch wildmenu encoding=utf-8 fileencoding=utf-8 mouse=`

## SpaceVim 整合包  https://spacevim.org/ （弃用）
curl -sLf https://spacevim.org/install.sh | bash

rm -rf ~/.SpaceVim.d && rm -rf ~/.vimrc && rm -rf ~/.config/nvim && rm -rf ~/.SpaceVim && rm -rf ~/.vim && curl -sLf https://spacevim.org/install.sh | bash

- h	向左移动光标
- j	向下移动光标
- k	向上移动光标
- l	向右移动光标
- <Up>,<Down>	智能上下
- H	将光标移动到屏幕顶部
- L	将光标移动到屏幕底部
- <	向左缩进并重新选择
- >	向右缩进并重新选择
- }	向前段落
- {	段落向后
- Ctrl-f// Shift-Down_<PageDown>	平滑向前滚动
- Ctrl-b// Shift-Up_<PageUp>	平滑向后滚动
- Ctrl-d	平滑向下滚动
- Ctrl-u	平滑向上滚动
- Ctrl-e	智能向下滚动 ( 3 Ctrl-e/j)
- Ctrl-y	智能向上滚动 ( 3Ctrl-y/k)
- Ctrl-a	将光标移至开头
- Ctrl-b	在命令行中向后移动光标
- Ctrl-f	在命令行中向前移动光标
- Ctrl-w	删除整个单词
- Ctrl-u	删除光标之前的所有文本
- Ctrl-k	删除光标后的所有文本
- Ctrl-c/Esc	取消命令行模式
- Tab	弹出菜单中的下一项
- Shift-Tab	弹出菜单中的上一项

https://spacevim.org/documentation/#command-line-mode-key-bindings
