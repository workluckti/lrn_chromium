# local-ntp 即新标签页的修改 -> webui 典型应用

代码相关文件路径：
```sh
src
├──chrome
    ├──browser
    |   ├──resources  
    |   |   | #1 Creating the WebUI page
    |   |   ├──hello_world.html
    |   |   ├──hello_world.css
    |   |   └──hello_world.js #8+ Adding a callback handler #10+ Passing arguments to the WebUI
    |   └──browser_resources.grd #2+ Adding the resources to Chrome
    |   ├──ui
    |   |   ├──webui 
    |   |   |   | #5 Adding a WebUI class for handling requests to the chrome://hello-world/ URL
    |   |   |   ├──hello_world_ui.h #9+- Creating a WebUI Dialog
    |   |   |   └──hello_world_ui.cc
    |   |   |   | #8 Adding a callback handler
    |   |   |   ├──hello_world_handler.h 
    |   |   |   └──hello_world_handler.cc 
    |   |   |   | #7+ Adding your WebUI request handler to the Chrome WebUI factory
    |   |   |   └──chrome_web_ui_controller_factory.cc 
    |   |   |   |  #9 Creating a WebUI Dialog
    |   |   |   ├──hello_world.h #10+- Passing arguments to the WebUI
    |   |   |   └──hello_world.cc #10+- Passing arguments to the WebUI
    |   |   └──BUILD.gn #6+ Adding new sources to Chrome
    ├──common 
    |   | #3+ Adding URL constants for new chrome URL
    |   ├──webui_url_constants.h
    |   └──webui_url_constants.cc
    └──app #4+ Adding localized strings
        └──generated_resources.grd

```