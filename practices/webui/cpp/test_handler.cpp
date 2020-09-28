#include <string>

 #define  IDS_HELLO_WORLD_JSON_TEXT   "[{\"logourl\":\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADwAAAA8CAIAAAC1\",\"name\":\"第一财经\",\"url\":\"www.yicai.com\",\"introduction\":\"官方网站\",\"sort\":1},{\"logourl\":\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADwAAAA8CAIAAAC1\",\"name\":\"雪球网\",\"url\":\"http://xueqiu.com\",\"introduction\":\"雪球，聪明的投资者都在这里- 3500万投资者都在用的投资社区\",\"sort\":2}]"
 #define  IDS_HELLO_WORLD_CYCLE_LOG_BASE64_TEXT   "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADwAAAA8CAIAAAC1"
 #define  IDS_HELLO_WORLD_SQUARE_LOG_BASE64_TEXT   "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAM4AAABICAYAAAC"
 #define  IDS_HELLO_WORLD_NEWS_THUMBNAIL_BASE64_TEXT   "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAMgAAACWCAYA"
 #define  IDS_HELLO_WORLD_FX110_LOGO_BASE64_TEXT   "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAALQAAAArCAYAAADR"
 #define  IDS_HELLO_WORLD_FOREX_SITE_LOGO_BASE64_TEXT   "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAALkAAAA1CAY"
 #define  IDS_HELLO_WORLD_COUNTRY_FLAG_LOGO_BASE64_TEXT  "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAFYAAAA6CAY"


// Add two numbers together using integer arithmetic.
void HelloWorldHandler::AddNumbers(const base::ListValue *args)
{
  AllowJavascript();
  int term1, term2;
  if (!args->GetInteger(0, &term1) || !args->GetInteger(1, &term2))
    return;
  base::Value result(term1 + term2);
  CallJavascriptFunction("hello_world.addResult", result);
}

// Get json text by json_flag.
void HelloWorldHandler::GetJsonText(const base::ListValue *args)
{
  AllowJavascript();
  std::string json_flag;
  if (!args->GetString(0, &json_flag))
  {
    return;
  }
  std::string utf8_str = "";
  if (json_flag == "test.json")
  {
    utf8_str = base::UTF16ToUTF8(GetContentClient()->GetLocalizedString(IDS_HELLO_WORLD_JSON_TEXT));
    CallJavascriptFunction("hello_world.getJson", base::Value(utf8_str));
  }
  return;
}

// Get text by text_flag.
void HelloWorldHandler::GetText(const base::ListValue *args)
{
  AllowJavascript();
  std::string text_flag;
  if (!args->GetString(0, &text_flag))
  {
    return;
  }
  std::string utf8_str = "";
  if (text_flag == "cycle.logo")
  {
    utf8_str = base::UTF16ToUTF8(GetContentClient()->GetLocalizedString(IDS_HELLO_WORLD_CYCLE_LOG_BASE64_TEXT));
    CallJavascriptFunction("hello_world.getCycleLogo", base::Value(utf8_str));
  }
  else if (text_flag == "square.logo")
  {
    utf8_str = base::UTF16ToUTF8(GetContentClient()->GetLocalizedString(IDS_HELLO_WORLD_SQUARE_LOG_BASE64_TEXT));
    CallJavascriptFunction("hello_world.getSquareLogo", base::Value(utf8_str));
  }
  else if (text_flag == "fx110.logo")
  {
    utf8_str = base::UTF16ToUTF8(GetContentClient()->GetLocalizedString(IDS_HELLO_WORLD_FX110_LOGO_BASE64_TEXT));
    CallJavascriptFunction("hello_world.getFx110Logo", base::Value(utf8_str));
  }
  else if (text_flag == "forexsite.logo")
  {
    utf8_str = base::UTF16ToUTF8(GetContentClient()->GetLocalizedString(IDS_HELLO_WORLD_FOREX_SITE_LOGO_BASE64_TEXT));
    CallJavascriptFunction("hello_world.getForexSiteLogo", base::Value(utf8_str));
  }
  else if (text_flag == "country.flag")
  {
    utf8_str = base::UTF16ToUTF8(GetContentClient()->GetLocalizedString(IDS_HELLO_WORLD_COUNTRY_FLAG_LOGO_BASE64_TEXT));
    CallJavascriptFunction("hello_world.getCountryFlag", base::Value(utf8_str));
  }
  else if (text_flag == "news.thumbnail")
  {
    utf8_str = base::UTF16ToUTF8(GetContentClient()->GetLocalizedString(IDS_HELLO_WORLD_NEWS_THUMBNAIL_BASE64_TEXT));
    CallJavascriptFunction("hello_world.getNewsThumbnail", base::Value(utf8_str));
  }
  return;
}