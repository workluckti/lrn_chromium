

#include "chrome/browser/ui/webui/hello_world_handler.h"

#include "base/bind.h"
#include "chrome/grit/generated_resources.h"
#include "base/strings/string_util.h"
#include "base/strings/utf_string_conversions.h"
#include "content/public/browser/content_browser_client.h"
#include "content/public/common/content_client.h"

HelloWorldHandler::HelloWorldHandler() {
}

HelloWorldHandler::~HelloWorldHandler() {
}

// WebUIMessageHandler implementation.
void HelloWorldHandler::RegisterMessages() {
  web_ui()->RegisterMessageCallback("hello_world.addNumbers",
      base::BindRepeating(&HelloWorldHandler::AddNumbers,
                          base::Unretained(this)));
  web_ui()->RegisterMessageCallback("hello_world.getJsonText",
      base::BindRepeating(&HelloWorldHandler::GetJsonText,
                          base::Unretained(this)));
  web_ui()->RegisterMessageCallback("hello_world.getText",
      base::BindRepeating(&HelloWorldHandler::GetText,
                          base::Unretained(this)));
  web_ui()->RegisterMessageCallback("hello_world.getJsonTextByHttp",
      base::BindRepeating(&HelloWorldHandler::GetJsonTextByHttp,
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

// Get json text by json_flag.
void HelloWorldHandler::GetJsonText(const base::ListValue* args){
  AllowJavascript();
  std::string json_flag;
  if (!args->GetString(0, &json_flag)){
    return;
  }
  std::string utf8_str = "";
  if (json_flag == "test.json"){
    utf8_str = (IDS_HELLO_WORLD_JSON_TEXT);
    CallJavascriptFunction("hello_world.getJson", base::Value(utf8_str));
}
  return;
}

// Get text by text_flag.
void HelloWorldHandler::GetText(const base::ListValue* args){
  AllowJavascript();
  std::string text_flag;
  if (!args->GetString(0, &text_flag)){
    return;
  }
  std::string utf8_str = "";
  if (text_flag == "cycle.logo"){
    utf8_str = (IDS_HELLO_WORLD_CYCLE_LOG_BASE64_TEXT);
    CallJavascriptFunction("hello_world.getCycleLogo", base::Value(utf8_str));
  }
  else if (text_flag == "square.logo"){
    utf8_str = (IDS_HELLO_WORLD_SQUARE_LOG_BASE64_TEXT);
    CallJavascriptFunction("hello_world.getSquareLogo", base::Value(utf8_str));
  }
  else if (text_flag == "fx110.logo"){
    utf8_str = (IDS_HELLO_WORLD_FX110_LOGO_BASE64_TEXT);
    CallJavascriptFunction("hello_world.getFx110Logo", base::Value(utf8_str));
  }
  else if (text_flag == "forexsite.logo"){
    utf8_str = (IDS_HELLO_WORLD_FOREX_SITE_LOGO_BASE64_TEXT);
    CallJavascriptFunction("hello_world.getForexSiteLogo", base::Value(utf8_str));
  }
  else if (text_flag == "country.flag"){
    utf8_str = (IDS_HELLO_WORLD_COUNTRY_FLAG_LOGO_BASE64_TEXT);
    CallJavascriptFunction("hello_world.getCountryFlag", base::Value(utf8_str));
  }
  else if (text_flag == "news.thumbnail"){
    utf8_str = (IDS_HELLO_WORLD_NEWS_THUMBNAIL_BASE64_TEXT);
    CallJavascriptFunction("hello_world.getNewsThumbnail", base::Value(utf8_str));
  }
  return;
}

// Get reponse text by http url.
void HelloWorldHandler::GetJsonTextByHttp(const base::ListValue* args){
  AllowJavascript();
  std::string text_flag, // the flag of get json info
              text_url;  // the http url
  if (!args->GetString(0, &text_url) || !args->GetString(1, &text_flag)){
    return;
  }
  std::string response_json_text = "";
  if (text_flag == "dealer.findDealerEvaluation"){
    response_json_text = (IDS_HELLO_WORLD_JSON_TEXT_DealerEvaluation);
    CallJavascriptFunction("hello_world.updateDealerEvaluation", base::Value(response_json_text));
  }
  else if (text_flag == "hotNews.findHotNewsPage"){
    response_json_text = (IDS_HELLO_WORLD_JSON_TEXT_HotNewsPage);
    CallJavascriptFunction("hello_world.updateHotNewsPage", base::Value(response_json_text));
  }
  else if (text_flag == "defaultWebsite.findCommonlyUsedWebsite"){
    response_json_text = (IDS_HELLO_WORLD_JSON_TEXT_CommonlyUsedWebsite);
    CallJavascriptFunction("hello_world.updateCommonlyUsedWebsite", base::Value(response_json_text));
  }
}