```sh
src
├──components
|   ├──hello_world
|   |   | #1 Creating the WebUI page
|   |   ├──hellow_world.html
|   |   ├──hellow_world.css
|   |   └──hellow_world.js #8+ Adding a callback handler 
|   |   | #3 Adding URL constants for the new chrome URL
|   |   ├──constants.cc
|   |   └──constants.h
|   |   | #5 Adding a WebUI class for handling requests to the chrome://hello-world/ URL
|   |   ├──hello_world_ui.h #8+ Adding a callback handler 
|   |   └──hello_world_ui.cc #8+ Adding a callback handler 
|   |   | #6 Adding new sources to Chrome
|   |   ├──BUILD.gn
|   |   └──DEPS
|   ├──resources
|   |   | #2 Adding the resources
|   |   └──hello_world_resources.grdp
|   |   | #2+ Adding the resources
|   |   └──dev_ui_components_resources.grd
|   | #4 Adding localized strings
|   └──hello_world_strings.grdp
|   | #4+ Adding localized strings
|   └──components_strings.grd
├──chrome
    ├──browser
    |   ├──resources  
    |   |   | #1 Creating the WebUI page
    |   |   ├──hellow_world.html
    |   |   ├──hellow_world.css
    |   |   └──hellow_world.js #8+ Adding a callback handler #10+ Passing arguments to the WebUI
    |   └──browser_resources.grd #2+ Adding the resources to Chrome
    |   ├──ui
    |   |   ├──webui 
    |   |   |   | #5 Adding a WebUI class for handling requests to the chrome://hello-world/ URL
    |   |   |   ├──hello_world_ui.h #8+ Adding a callback handler #9+- Creating a WebUI Dialog
    |   |   |   └──hello_world_ui.cc #8+ Adding a callback handler
    |   |   |   | #7+ Adding your WebUI request handler to the Chrome WebUI factory
    |   |   |   └──chrome_web_ui_controller_factory.cc 
    |   |   |   |  #9 Creating a WebUI Dialog
    |   |   |   ├──hello_world.h #10+- Passing arguments to the WebUI
    |   |   |   └──hello_world.cc #10+- Passing arguments to the WebUI
    |   |   └──BUILD.gn #6+ Adding new sources to Chrome
    ├──common 
    |   | #3+ Adding URL constants for new chrome URL
    |   ├──url_constants.h
    |   └──url_constants.cc
    ├──app #4+ Adding localized strings
        └──generated_resources.grd

```