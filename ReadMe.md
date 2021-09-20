https://github.com/jmgarciamaleno/bash-config

https://github.com/frontdevops/my-bash-config

https://github.com/haccks/zsh-config

https://github.com/qoomon/my-zsh

## install
yay -Sy bash-completion
emerge --ask app-shells/bash-completion

## configure
1. in mac os platforms, Softlink your file to .bashrc or put your configuration code in .bashrc, then source .bashrc from .bash_profile with the following code in .bash_profile:
if [ -r ~/.bashrc ]; then
   source ~/.bashrc
fi

2. in Unix/Linux platforms, put the following code in .bashrc:
``` shell
mybashrc=/mnt/hdd/app/conf.d/shell/mybashrc
if [ -r $mybashrc ]; then
   source $mybashrc
fi
```
or
```shell
mybashrc=/mnt/hdd/app/conf.d/shell/mybashrc
[ -f $mybashrc ] && source $mybashrc
```
## ANSI 转义序列
Shell 可以通过一些特殊的转义序列，控制终端上的字符颜色、光标位置等。ANSI 转义序列 就是这些特殊序列的一种标准，基本上所有终端都支持（就连著名的小黑窗，Win32 控制台在 Windows 10 TH2 之后也支持 ANSI 转义序列了）。
以文本颜色为例，16 色 ANSI 转义序列大概长这样：

| 序列   | 文本颜色 | 序列   | 文本颜色   |
|--------|----------|--------|------------|
| \e[30m | 黑       | \e[90m | 亮黑（灰） |
| \e[31m | 红       | \e[91m | 亮红       |
| \e[32m | 绿       | \e[92m | 亮绿       |
| \e[33m | 黄       | \e[93m | 亮黄       |
| \e[34m | 蓝       | \e[94m | 亮蓝       |
| \e[35m | 品红     | \e[95m | 亮品红     |
| \e[36m | 青       | \e[96m | 亮青       |
| \e[37m | 白       | \e[97m | 亮白       |

其中 \e 表示 ESC 的转义序列，也可以写作 \033、\x1B
随着终端的发展，转义序列也有了更多的定义，支持到了 8 位（256 色）、16 位甚至 24 位色。详细的 ANSI 转义序列可以参考以下链接：

[ANSI escape code - Wikipedia](https://en.wikipedia.org/wiki/ANSI_escape_code)
[bash:tip_colors_and_formatting - FLOZz’ MISC](https://misc.flogisoft.com/bash/tip_colors_and_formatting)

测试一下:
```shell
print -P '[%{\e[32m%}%n%{\e[0m%}@%{\e[31m%}%m %{\e[34m%}%1~%{\e[0m%}]$ '
```

但是像这样手写一长串不直观的转义序列未免也太过低效，所以 Zsh 提供了几种方便地设置文本颜色的方法：

| 命令            | 描述                                                                                       |
|-----------------|--------------------------------------------------------------------------------------------|
| $fg[color]      | 设置文本颜色，color 的取值可以是 black red green yellow blue magenta cyan white default 等 |
| $fg_bold[color] | 设置文本为粗体同时设定文本颜色                                                             |
| $reset_color    | 重置文本颜色为默认颜色                                                                     |
| $bg[color]      | 设置背景颜色                                                                               |
完整的定义可以在 [Zsh](https://github.com/zsh-users/zsh/blob/master/Functions/Misc/colors) 源码 中查看。
如果你没有使用 oh-my-zsh 之类的配置框架，你需要在 .zshrc 中手动加入 autoload -U colors && colors 才能使用这些颜色代码。

所以上面的示例也可以改写成这样（注意这里必须用双引号）：
测试一下:
```shell
print -P "[%{$fg[green]%}%n%{$reset_color%}@%{$fg[red]%}%m %{$fg[blue]%}%1~%{$reset_color%}]$ "
```
### 为Bash提示符添加配色
一下是常用的配色，有修改字体颜色、修改为粗体、添加下划线、设置背景颜色等设置:
```bash
'\e[0;30m' # 黑色
'\e[0;31m' # 红色
'\e[0;32m' # 绿色
'\e[0;33m' # 黄色
'\e[0;34m' # 蓝色
'\e[0;35m' # 紫色
'\e[0;36m' # 青色
'\e[0;37m' # 白色
'\e[1;30m' # 黑色 粗体
'\e[1;31m' # 红色 粗体
'\e[1;32m' # 绿色 粗体
'\e[1;33m' # 黄色 粗体
'\e[1;34m' # 蓝色 粗体
'\e[1;35m' # 紫色 粗体
'\e[1;36m' # 青色 粗体
'\e[1;37m' # 白色 粗体
'\e[4;30m' # 黑色 下划线
'\e[4;31m' # 红色 下划线
'\e[4;32m' # 绿色 下划线
'\e[4;33m' # 黄色 下划线
'\e[4;34m' # 蓝色 下划线
'\e[4;35m' # 紫色 下划线
'\e[4;36m' # 青色 下划线
'\e[4;37m' # 白色 下划线
'\e[40m' # 黑色 背景
'\e[41m' # 红色 背景
'\e[42m' # 绿色 背景
'\e[43m' # 黄色 背景
'\e[44m' # 蓝色 背景
'\e[45m' # 紫色 背景
'\e[46m' # 青色 背景
'\e[47m' # 白色 背景
‘\e[0m' # 重置为默认值
```
## LS_COLORS
[Configuring LS_COLORS](http://www.bigsoft.co.uk/blog/2008/04/11/configuring-ls_colors)
[LS_COLORS](https://github.com/trapd00r/LS_COLORS)
## Reference
[教你写一个 Zsh 主题](https://printempw.github.io/zsh-prompt-theme-customization/)

[你不需要花哨的命令提示符](https://zhuanlan.zhihu.com/p/51008087)

[Crazy POWERFUL Bash Prompt](https://www.askapache.com/linux/bash-power-prompt/)

[如何修改Bash Shell的提示符的格式和配色](http://blog.itpub.net/69955379/viewspace-2705072/)
