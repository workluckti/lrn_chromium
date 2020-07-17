#include "base/utf_string_conversions.h"
#include "chrome/browser/ui/browser.h"
#include "chrome/browser/ui/browser_list.h"
#include "chrome/browser/ui/webui/hello_world.h"
#include "chrome/common/url_constants.h"

void HelloWorldDialog::ShowDialog() {
  Browser* browser = BrowserList::GetLastActive();
  DCHECK(browser);
  browser->BrowserShowHtmlDialog(new HelloWorldDialog(), NULL);
}

HelloWorldDialog::HelloWorldDialog() {
}

HelloWorldDialog::~HelloWorldDialog() {
}

bool HelloWorldDialog::IsDialogModal() {
  return false;
}

string16 HelloWorldDialog::GetDialogTitle() {
  return UTF8ToUTF16("Hello World");
}

GURL HelloWorldDialog::GetDialogContentURL() const {
  return GURL(chrome::kChromeUIHelloWorldURL);
}

void HelloWorldDialog::GetWebUIMessageHandlers(
    std::vector<WebUIMessageHandler*>* handlers) const {
}

void HelloWorldDialog::GetDialogSize(gfx::Size* size) const {
  size->SetSize(600, 400);
}

std::string HelloWorldDialog::GetDialogArgs() const {
  return std::string();
}

void HelloWorldDialog::OnDialogClosed(const std::string& json_retval) {
  delete this;
}

void HelloWorldDialog::OnCloseContents(TabContents* source,
    bool* out_close_dialog) {
  if (out_close_dialog)
    *out_close_dialog = true;
}

bool HelloWorldDialog::ShouldShowDialogTitle() const {
  return true;
}