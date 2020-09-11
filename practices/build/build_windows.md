
# build chromium in windows
## configure Git:
```sh
$ git config --global user.name "My Name"
$ git config --global user.email "my-name@chromium.org"
$ git config --global core.autocrlf false
$ git config --global core.filemode false
$ git config --global branch.autosetuprebase always
```

## Setting up the build

```sh
gn gen out/Default # simplest one
gn gen --ide=vs out/Default # add visual studio ide
gn gen --ide=vs --filters=//chrome --no-deps out/Default # add filter path
## complicated sample
gn gen --ide=vs --filters=//chrome/browser/ui/views/* --no-deps out/browser_ui_views
gn gen --ide=vs --filters=//base --no-deps out/base
gn gen --ide=vs --filters=//ipc --no-deps out/ipc
```
> arguments:
> * `gen` generate project files
> * `--ide=vs` choose visual studio as ide
> * `--filters=//chrome/browser/ui/views/*` generate project files in the path
> * `--no-deps` don't genrate the dependens project files
> * `out/**` project output path, it should be subdirectory of `out`
> 
>PS:  use `gn help gen` to get more args statements.

By default when you start debugging in Visual Studio the debugger will only attach to the main browser process. To debug all of Chrome, install [Microsoft's Child Process Debugging Power Tool](https://blogs.msdn.microsoft.com/devops/2014/11/24/introducing-the-child-process-debugging-power-tool/). You will also need to **run Visual Studio as administrator**, or it will silently fail to attach to some of Chrome's child processes.

It is also possible to debug and develop Chrome in Visual Studio without a solution file. Simply **“open” your chrome.exe binary** with `File->Open->Project/Solution`, or from a Visual Studio command prompt like so: `devenv /debugexe out\Debug\chrome.exe <your arguments>`. Many of Visual Studio's code editing features will not work in this configuration, but by installing the *VsChromium Visual Studio Extension* you can get the source code to appear in the solution explorer window along with other useful features such as code search.