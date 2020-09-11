# Chromium 代码编译

## 博客摘录
[Chromium代码编译选项介绍](https://gclxry.com/chromium-build-args/)
- is_debug。这个选项值可以为true或者false。当为true时编译debug版本，false时编译release版本。
- is_component_build。这个选项值可以为true或者false。当为true时将chromium代码编译成多个小的dll，false时代码编译成单个dll。一般我们编译debug版本时，设置is_component_build = true，这样每次改动编译链接花费的时间就会减少很多。编译release版本时，设置is_component_build = false，这样就可以把所有代码编译到一个dll里面。
- target_cpu。这个选项值为字符串，控制我们编译出的程序所匹配的cpu。编译32位x86版本设置成target_cpu =”x86″，编译64位x64版本设置成target_cpu =”x64″。如果我们没有显式指定target_cpu的值，那么target_cpu的值为编译它的电脑所用的cpu类型。通常target_cpu的值为x86会比x64编译速度更快，并且支持增量编译。另外如果设置了target_cpu =”x86″，也必须设置enable_nacl = false，否则编译速度会慢很多。
- enable_nacl。这个选项值可以为true或者false。控制是否启用Native Client，通常我们并不需要。所以把其值设置成enable_nacl = false。
- is_clang。这个选项值可以为true或者false。控制是否启用clang进行编译。目前m63 clang编译还不稳定，所以这个选项设置成is_clang = false。m64开始支持clang编译。
- ffmpeg_branding=”Chrome” proprietary_codecs=true。这个两个选项是控制代码编译支持的多媒体格式跟chrome一样，支持mp4等格式。
- symbol_level。其值为整数。当值为0时，不生成调试符号，可以加快代码编译链接速度。当值为1时，生成的调试符号中不包含源代码信息，无法进行源代码级调试，但是可以加快代码编译链接速度。当值为2时，生成完整的调试符号，编译链接时间比较长。
- is_official_build。这个选项值可以为true或者false。控制是否启用official编译模式。official编译模式会进行代码编译优化，非常耗时。仅发布的时候设置成is_official_build = true开启优化。
- use_jumbo_build 。这个选项值可以为true或者false。控制是否启用试验性的jumbo编译。jumbo会显著提高代码编译的速度。目前已经完成了blink内核的jumob化，编译时间减少到了之前的1/10。
- ~~remove_webcore_debug_symbols。这个选项值可以为true或者false。控制编译生成blink调试符号中是否去掉源代码信息。如果值为true，优点是加快编译速度，缺点是不能源代码级调试blink相关代码。~~