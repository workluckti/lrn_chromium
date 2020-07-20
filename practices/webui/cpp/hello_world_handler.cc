

#include "chrome/browser/ui/webui/hello_world_handler.h"

#include "base/bind.h"

HelloWorldHandler::HelloWorldHandler() {
}

HelloWorldHandler::~HelloWorldHandler() {
}

// WebUIMessageHandler implementation.
void HelloWorldHandler::RegisterMessages() {
  web_ui()->RegisterMessageCallback("hello_world.addNumbers",
      base::BindRepeating(&HelloWorldHandler::AddNumbers,
                          base::Unretained(this)));
}
// Add two numbers together using integer arithmetic.
void HelloWorldHandler::AddNumbers(const base::ListValue* args) {
  AllowJavascript();
  int term1, term2;
  if (!args->GetInteger(0, &term1) || !args->GetInteger(1, &term2))
    return;
  base::Value result(term1 + term2);
  CallJavascriptFunction("hello_world.addResult", result);
}