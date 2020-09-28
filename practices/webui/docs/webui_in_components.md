<style>
.note::before {
  content: 'Note: ';
  font-variant: small-caps;
  font-style: italic;
}

.doc h1 {
  margin: 0;
}
</style>

# Creating WebUI Interfaces in `components/`

To create a WebUI interface in `components/` you need to follow different steps from [Creating WebUI Interfaces in `chrome/`](https://www.chromium.org/developers/webui). This guide is specific to creating a WebUI interface in `src/components/`. It is based on the steps I went through to create the WebUI infrastructure for chrome://safe-browsing in 'src/components/safe_browsing/content/web_ui/'.

```sh
src
├──components
|   ├──hi_world
|   |   | #1 Creating the WebUI page
|   |   ├──hi_world.html
|   |   ├──hi_world.css
|   |   └──hi_world.js #8+ Adding a callback handler 
|   |   | #3 Adding URL constants for the new chrome URL
|   |   ├──constants.cc
|   |   └──constants.h
|   |   | #5 Adding a WebUI class for handling requests to the chrome://hi-world/ URL
|   |   ├──hi_world_ui.h #8+ Adding a callback handler 
|   |   └──hi_world_ui.cc #8+ Adding a callback handler 
|   |   ├──hi_world_handler.h #8 Adding a callback handler 
|   |   └──hi_world_handler.cc #8 Adding a callback handler 
|   |   | #6 Adding new sources to Chrome
|   |   ├──BUILD.gn
|   |   └──DEPS
|   ├──resources
|   |   | #2 Adding the resources
|   |   └──hi_world_resources.grdp
|   |   | #2+ Adding the resources
|   |   └──dev_ui_components_resources.grd
|   | #4 Adding localized strings
|   └──hi_world_strings.grdp
|   | #4+ Adding localized strings
|   └──components_strings.grd
└──chrome
    └──browser
        └──ui
            └──webui 
                | #7+ Adding your WebUI request handler to the Chrome WebUI factory
                └──chrome_web_ui_controller_factory.cc 


```

- [Creating WebUI Interfaces in `components/`](#creating-webui-interfaces-in-components)
  - [Creating the WebUI page](#creating-the-webui-page)
  - [Adding the resources](#adding-the-resources)
  - [Adding URL constants for the new chrome URL](#adding-url-constants-for-the-new-chrome-url)
  - [Adding localized strings](#adding-localized-strings)
  - [Adding a WebUI class for handling requests to the chrome://hi-world/ URL](#adding-a-webui-class-for-handling-requests-to-the-chromehi-world-url)
  - [Adding new sources to Chrome](#adding-new-sources-to-chrome)
  - [Adding your WebUI request handler to the Chrome WebUI factory](#adding-your-webui-request-handler-to-the-chrome-webui-factory)
  - [Testing](#testing)
  - [Adding a callback handler](#adding-a-callback-handler)
  - [Creating a WebUI Dialog](#creating-a-webui-dialog)
  - [DevUI Pages](#devui-pages)

<a name="creating_webui_page"></a>
## Creating the WebUI page

WebUI resources in `components/` will be added in your specific project folder. Create a project folder `src/components/hi_world/`. When creating WebUI resources, follow the [Web Development Style Guide](https://chromium.googlesource.com/chromium/src/+/master/styleguide/web/web.md). For a sample WebUI page you could start with the following files:

`src/components/hi_world/hi_world.html:`
```html
<!DOCTYPE HTML>
<html dir="$i18n{textdirection}">
<head>
 <meta charset="utf-8">
 <title>$i18n{hiWorldTitle}</title>
 <link rel="stylesheet" href="hi_world.css">
 <script src="chrome://resources/js/cr.js"></script>
 <script src="chrome://resources/js/load_time_data.js"></script>
 <script src="chrome://resources/js/util.js"></script>
 <script src="strings.js"></script>
 <script src="hi_world.js"></script>
</head>
<body style="font-family:$i18n{fontfamily};font-size:$i18n{fontSize}">
  <h1>$i18n{hiWorldTitle}</h1>
  <p id="welcome-message"></p>
</body>
</html>
```

`src/components/hi_world/hi_world.css:`
```css
p {
  white-space: pre-wrap;
}
```

`src/components/hi_world/hi_world.js:`
```js
cr.define('hi_world', function() {
  'use strict';

  /**
   * Be polite and insert translated hi world strings for the user on loading.
   */
  function initialize() {
    $('welcome-message').textContent = loadTimeData.getStringF('welcomeMessage',
        loadTimeData.getString('userName'));
  }

  // Return an object with all of the exports.
  return {
    initialize: initialize,
  };
});

document.addEventListener('DOMContentLoaded', hi_world.initialize);
```

## Adding the resources

Resource files are specified in a `.grdp` file. Here's our
`components/resources/hi_world_resources.grdp`:

```xml
<?xml version="1.0" encoding="utf-8"?>
<grit-part>
  <include name="IDR_HI_WORLD_HTML" file="../../components/hi_world/hi_world.html" type="BINDATA" />
  <include name="IDR_HI_WORLD_CSS" file="../../components/hi_world/hi_world.css" type="BINDATA" />
  <include name="IDR_HI_WORLD_JS" file="../../components/hi_world/hi_world.js" type="BINDATA" />
</grit-part>
```

Add the created file in `components/resources/dev_ui_components_resources.grd`:

```xml
+<part file="hi_world_resources.grdp" />
```

## Adding URL constants for the new chrome URL

Create the `constants.cc` and `constants.h` files to add the URL constants. This is where you will add the URL or URL's which will be directed to your new resources.

`src/components/hi_world/constants.cc:`
```c++
const char kChromeUIHiWorldURL[] = "chrome://hi-world/";
const char kChromeUIHiWorldHost[] = "hi-world";
```

`src/components/hi_world/constants.h:`
```c++
extern const char kChromeUIHiWorldURL[];
extern const char kChromeUIHiWorldHost[];
```

## Adding localized strings

We need a few string resources for translated strings to work on the new resource. The welcome message contains a variable with a sample value so that it can be accurately translated. Create a new file `components/hi_world_strings.grdp`. You can add the messages as follow:

```xml
<message name="IDS_HI_WORLD_TITLE" desc="A happy message saying hi to the world">
  Hello World!
</message>
<message name="IDS_HI_WORLD_WELCOME_TEXT" desc="Message welcoming the user to the hi world page">
  Welcome to this fancy Hi World page <ph name="WELCOME_NAME">$1<ex>Chromium User</ex></ph>!
</message>
```
Add the created file in `components/components_strings.grd`:

```xml
+<part file="hi_world_strings.grdp" />
```

## Adding a WebUI class for handling requests to the chrome://hi-world/ URL

Next we need a class to handle requests to this new resource URL. Typically this will subclass `ChromeWebUI` (but WebUI dialogs should subclass `HtmlDialogUI` instead).

`src/components/hi_world/hi_world_ui.h:`
```c++
#ifndef COMPONENTS_HI_WORLD_UI_H_
#define COMPONENTS_HI_WORLD_UI_H_
#pragma once

#include "base/macros.h"
#include "content/public/browser/web_ui_controller.h"

// The WebUI for chrome://hi-world
class HiWorldUI : public content::WebUIController {
 public:
  explicit HiWorldUI(content::WebUI* web_ui);
  ~HiWorldUI() override;
 private:
  DISALLOW_COPY_AND_ASSIGN(HiWorldUI);
};

#endif  // COMPONENTS_HI_WORLD_UI_H_
```

`src/components/hi_world/hi_world_ui.cc:`
```c++
#include "components/hi_world/hi_world_ui.h"

#include "components/grit/components_scaled_resources.h"
#include "components/grit/dev_ui_components_resources.h"
#include "components/hi_world/constants.h"
#include "components/strings/grit/components_strings.h"
#include "content/public/browser/browser_context.h"
#include "content/public/browser/web_contents.h"
#include "content/public/browser/web_ui.h"
#include "content/public/browser/web_ui_data_source.h"

HiWorldUI::HiWorldUI(content::WebUI* web_ui)
    : content::WebUIController(web_ui) {
  // Set up the chrome://hi-world source.
  content::WebUIDataSource* html_source =
      content::WebUIDataSource::Create(chrome::kChromeUIHelloWorldHost);

  // Localized strings.
  html_source->AddLocalizedString("hiWorldTitle", IDS_HELLO_WORLD_TITLE);
  html_source->AddLocalizedString("welcomeMessage", IDS_HELLO_WORLD_WELCOME_TEXT);

  // As a demonstration of passing a variable for JS to use we pass in the name "Bob".
  html_source->AddString("userName", "Bob");
  html_source->UseStringsJs();

  // Add required resources.
  html_source->AddResourcePath("hi_world.css", IDR_HELLO_WORLD_CSS);
  html_source->AddResourcePath("hi_world.js", IDR_HELLO_WORLD_JS);
  html_source->SetDefaultResource(IDR_HELLO_WORLD_HTML);

  content::BrowserContext* browser_context =
      web_ui->GetWebContents()->GetBrowserContext();
  content::WebUIDataSource::Add(browser_context, html_source);
}

HiWorldUI::~HiWorldUI() {
}
```

## Adding new sources to Chrome

In order for your new class to be built and linked, you need to update the `BUILD.gn` and DEPS files. Create

`src/components/hi_world/BUILD.gn:`
```
sources = [
  "hi_world_ui.cc",
  "hi_world_ui.h",
  ...
```
and `src/components/hi_world/DEPS:`
```
include_rules = [
  "+components/strings/grit/components_strings.h",
  "+components/grit/components_scaled_resources.h"
  "+components/grit/dev_ui_components_resources.h",
]
```

## Adding your WebUI request handler to the Chrome WebUI factory

The Chrome WebUI factory is where you setup your new request handler.

`src/chrome/browser/ui/webui/chrome_web_ui_controller_factory.cc:`
```c++
+ #include "components/hi_world/hi_world_ui.h"
+ #include "components/hi_world/constants.h"
...
+ if (url.host() == chrome::kChromeUIHelloWorldHost)
+   return &NewWebUI<HiWorldUI>;
```

## Testing

You're done! Assuming no errors (because everyone gets their code perfect the first time) you should be able to compile and run chrome and navigate to `chrome://hi-world/` and see your nifty welcome text!

## Adding a callback handler

You probably want your new WebUI page to be able to do something or get information from the C++ world. For this, we use message callback handlers. Let's say that we don't trust the Javascript engine to be able to add two integers together (since we know that it uses floating point values internally). We could add a callback handler to perform integer arithmetic for us.

`src/components/hi_world/hi_world_ui.h:`
```c++
#include "content/public/browser/web_ui.h"
+
+ namespace base {
+   class ListValue;
+ }  // namespace base

// The WebUI for chrome://hi-world
...
    // Set up the chrome://hi-world source.
    content::WebUIDataSource* html_source = content::WebUIDataSource::Create(hi_world::kChromeUIHelloWorldHost);
+
+   // Register callback handler.
+   RegisterMessageCallback("addNumbers",
+       base::BindRepeating(&HiWorldUI::AddNumbers,
+                           base::Unretained(this)));

    // Localized strings.
...
    virtual ~HiWorldUI();
+
+  private:
+   // Add two numbers together using integer arithmetic.
+   void AddNumbers(const base::ListValue* args);

    DISALLOW_COPY_AND_ASSIGN(HiWorldUI);
  };
```

`src/components/hi_world/hi_world_ui.cc:`
```c++
  #include "components/hi_world/hi_world_ui.h"
+
+ #include "base/values.h"
  #include "content/public/browser/browser_context.h"
...
  HiWorldUI::~HiWorldUI() {
  }
+
+ void HiWorldUI::AddNumbers(const base::ListValue* args) {
+   int term1, term2;
+   if (!args->GetInteger(0, &term1) || !args->GetInteger(1, &term2))
+     return;
+   base::FundamentalValue result(term1 + term2);
+   AllowJavascript();
+   std::string callback_id;
+   args->GetString(0, &callback_id);
+   ResolveJavascriptCallback(base::Value(callback_id), result);
+ }
```

`src/components/hi_world/hi_world.js:`
```c++
    function initialize() {
+     cr.sendWithPromise('addNumbers', [2, 2]).then((result) =>
+         addResult(result));
    }
+
+   function addResult(result) {
+     alert('The result of our C++ arithmetic: 2 + 2 = ' + result);
+   }

    return {
      initialize: initialize,
    };
```

You'll notice that the call is asynchronous. We must wait for the C++ side to call our Javascript function to get the result.

## Creating a WebUI Dialog

Some pages have many messages or share code that sends messages. To make possible message handling and/or to create a WebUI dialogue `c++->js` and `js->c++`, follow the guide in [WebUI Explainer](https://chromium.googlesource.com/chromium/src/+/master/docs/webui_explainer.md).

## DevUI Pages

DevUI pages are WebUI pages intended for developers, and unlikely used by most users. An example is `chrome://bluetooth-internals`. On Android Chrome, these pages are moved to a separate [Dynamic Feature Module (DFM)](https://chromium.googlesource.com/chromium/src/+/master/docs/android_dynamic_feature_modules.md) to reduce binary size. Most WebUI pages are DevUI. This is why in this doc uses `dev_ui_components_resources.{grd, h}` in its examples.

`components/` resources that are intended for end users are associated with `components_resources.{grd, h}` and `components_scaled_resorces.{grd, h}`. Use these in place of or inadditional to `dev_ui_components_resources.{grd, h}` if needed.

<script>
let nameEls = Array.from(document.querySelectorAll('[id], a[name]'));
let names = nameEls.map(nameEl => nameEl.name || nameEl.id);

let localLinks = Array.from(document.querySelectorAll('a[href^="#"]'));
let hrefs = localLinks.map(a => a.href.split('#')[1]);

hrefs.forEach(href => {
  if (names.includes(href))
    console.info('found: ' + href);
  else
    console.error('broken href: ' + href);
})
</script>
