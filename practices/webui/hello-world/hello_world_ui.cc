#include "chrome/browser/ui/webui/hello_world_ui.h"
#include "chrome/browser/ui/webui/hello_world_handler.h"

#include "chrome/browser/profiles/profile.h"
#include "chrome/common/url_constants.h"
#include "chrome/grit/browser_resources.h"
#include "chrome/grit/generated_resources.h"
#include "content/public/browser/web_ui_data_source.h"

HelloWorldUI::HelloWorldUI(content::WebUI* web_ui)
    : content::WebUIController(web_ui) {
  // set up message handler
  web_ui->AddMessageHandler(std::make_unique<HelloWorldHandler>());
  // Set up the chrome://hello-world source.
  content::WebUIDataSource* html_source =
      content::WebUIDataSource::Create(chrome::kChromeUIHelloWorldHost);

  // Localized strings.
  html_source->AddLocalizedString("helloWorldTitle", IDS_HELLO_WORLD_TITLE);
  html_source->AddLocalizedString("welcomeMessage", IDS_HELLO_WORLD_WELCOME_TEXT);

  // As a demonstration of passing a variable for JS to use we pass in the name "Bob".
  html_source->AddString("userName", "Bob");
  // html_source->SetJsonPath("strings.js"); // ERROR: No function, change to `UseStringsJs()`
  html_source->UseStringsJs();

  // Add required resources.
  html_source->AddResourcePath("hello_world.css", IDR_HELLO_WORLD_CSS);
  html_source->AddResourcePath("hello_world.js", IDR_HELLO_WORLD_JS);
  html_source->AddResourcePath("hello_world_data.js", IDR_HELLO_WORLD_DATA_JS);
  html_source->SetDefaultResource(IDR_HELLO_WORLD_HTML);

  Profile* profile = Profile::FromWebUI(web_ui);
  content::WebUIDataSource::Add(profile, html_source);
}

HelloWorldUI::~HelloWorldUI() {
}