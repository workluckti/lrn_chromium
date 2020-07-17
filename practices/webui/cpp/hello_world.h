#ifndef CHROME_BROWSER_UI_WEBUI_HELLO_WORLD_H_
#define CHROME_BROWSER_UI_WEBUI_HELLO_WORLD_H_
#pragma once

#include "chrome/browser/ui/webui/html_dialog_ui.h"

class HelloWorldDialog : private HtmlDialogUIDelegate {
 public:
  // Shows the Hello World dialog.
  static void ShowDialog();
  virtual ~HelloWorldDialog();

 private:
  // Construct a Hello World dialog
  explicit HelloWorldDialog();

  // Overridden from HtmlDialogUI::Delegate:
  virtual bool IsDialogModal() const OVERRIDE;
  virtual string16 GetDialogTitle() const OVERRIDE;
  virtual GURL GetDialogContentURL() const OVERRIDE;
  virtual void GetWebUIMessageHandlers(
      std::vector<WebUIMessageHandler*>* handlers) const OVERRIDE;
  virtual void GetDialogSize(gfx::Size* size) const OVERRIDE;
  virtual std::string GetDialogArgs() const OVERRIDE;
  virtual void OnDialogClosed(const std::string& json_retval) OVERRIDE;
  virtual void OnCloseContents(
      TabContents* source, bool* out_close_dialog) OVERRIDE;
  virtual bool ShouldShowDialogTitle() const OVERRIDE;

  DISALLOW_COPY_AND_ASSIGN(HelloWorldDialog);
};

#endif  // CHROME_BROWSER_UI_WEBUI_HELLO_WORLD_H_