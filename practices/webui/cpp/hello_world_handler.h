#ifndef CHROME_BROWSER_UI_WEBUI_HELLO_WORLD_HANDLER_H_
#define CHROME_BROWSER_UI_WEBUI_HELLO_WORLD_HANDLER_H_

#include "base/macros.h"
#include "base/values.h"
#include "content/public/browser/web_ui_message_handler.h"

// The WebUI for chrome://hello-world
class HelloWorldHandler : public content::WebUIMessageHandler {
 public:
  HelloWorldHandler();
  ~HelloWorldHandler() override;

  // WebUIMessageHandler implementation.
  void RegisterMessages() override;

 private: 
  // Add two numbers together using integer arithmetic.
  void AddNumbers(const base::ListValue* args);

  DISALLOW_COPY_AND_ASSIGN(HelloWorldHandler);
};

#endif  // CHROME_BROWSER_UI_WEBUI_HELLO_WORLD_HANDLER_H_