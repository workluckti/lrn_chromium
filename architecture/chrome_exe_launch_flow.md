# 浏览器程序启动流程

# Windows platform start

[Chromium架构之启动](https://gclxry.com/chromium-framework-start/)

`src\chrome\app\chrome_exe_main_win.cc` -> main 函数（程序入口）<br>
Win32程序的入口都是wWinMain. C++ 标准入口为 main.
```c++
...

#if !defined(WIN_CONSOLE_APP)
int APIENTRY wWinMain(HINSTANCE instance, HINSTANCE prev, wchar_t*, int) {
#else
int main() {
  HINSTANCE instance = GetModuleHandle(nullptr);
#endif

...
```

`src\chrome\app\main_dll_loader_win.cc` -> MainDllLoader 函数（加载主dll）<br>
MainDllLoader去加载浏览器实际逻辑的dll。不同的浏览器进程加载的dll不一样。比如Browser进程加载的是chrome.dll，Renderer进程加载的是chrome_child.dll，Watcher进程加载的是chrome_watcher.dll。<br>
加载好dll之后就会调用dll里面的ChromeMain函数，执行不同的逻辑。