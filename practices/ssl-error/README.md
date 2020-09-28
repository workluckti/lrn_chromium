`components/security_interstitials_strings.grdp`
```xml
  <!-- SSL error page -->
  <message name="IDS_SSL_V2_TITLE" desc="The tab title for the SSL interstitial.">
    Privacy error
  </message>
  <message name="IDS_SSL_V2_HEADING" desc="The large heading at the top of the SSL interstitial.">
    Your connection is not private
  </message>
  <message name="IDS_SSL_V2_PRIMARY_PARAGRAPH" desc="The primary explanatory paragraph for the SSL interstitial.">
    Attackers might be trying to steal your information from <ph name="BEGIN_BOLD">&lt;strong&gt;</ph><ph name="SITE">$1<ex>google.com</ex></ph><ph name="END_BOLD">&lt;/strong&gt;</ph> (for example, passwords, messages, or credit cards). <ph name="BEGIN_LEARN_MORE_LINK">&lt;a href="#" id="learn-more-link"&gt;</ph>Learn more<ph name="END_LEARN_MORE_LINK">&lt;/a&gt;</ph>
  </message>
  <message name="IDS_SSL_V2_RECURRENT_ERROR_PARAGRAPH" desc="A paragraph for an SSL interstitial that the user has seen multiple times in a browsing session.">
    Warnings may be common while websites update their security. This should improve soon.
  </message>
```

`components/security_interstitials/core/ssl_error_ui.cc`
```C++
  // Shared values for both the overridable and non-overridable versions.
  load_time_data->SetBoolean("bad_clock", false);
  load_time_data->SetBoolean("hide_primary_button", false);
  load_time_data->SetString("tabTitle",
                            l10n_util::GetStringUTF16(IDS_SSL_V2_TITLE));
  load_time_data->SetString("heading",
                            l10n_util::GetStringUTF16(IDS_SSL_V2_HEADING));
  load_time_data->SetString(
      "primaryParagraph",
      l10n_util::GetStringFUTF16(
          IDS_SSL_V2_PRIMARY_PARAGRAPH,
          common_string_util::GetFormattedHostName(request_url_)));
  load_time_data->SetString(
      "recurrentErrorParagraph",
      l10n_util::GetStringUTF16(IDS_SSL_V2_RECURRENT_ERROR_PARAGRAPH));
  load_time_data->SetBoolean("show_recurrent_error_paragraph",
                             controller_->HasSeenRecurrentError());
```


`official-docs\docs-en\security\autoupgrade-mixed.md`


net::ERR_CERT_COMMON_NAME_INVA

`src\third_party\blink\web_tests\http\tests\mixed-autoupgrade\optionally\image-upgrade-console-message.https-expected.txt`


Vscode search: `Mixed Content: The page at` <br>
`src\third_party\blink\renderer\core\loader\mixed_content_checker.cc`
```c++
// static
ConsoleMessage* MixedContentChecker::CreateConsoleMessageAboutFetchAutoupgrade(
    const KURL& main_resource_url,
    const KURL& mixed_content_url) {
  String message = String::Format(
      "Mixed Content: The page at '%s' was loaded over HTTPS, but requested an "
      "insecure element '%s'. As part of an experiment this request was "
      "automatically upgraded to HTTPS, For more information see "
      "https://chromium.googlesource.com/chromium/src/+/master/docs/security/"
      "autoupgrade-mixed.md",
      main_resource_url.ElidedString().Utf8().c_str(),
      mixed_content_url.ElidedString().Utf8().c_str());
  return ConsoleMessage::Create(mojom::ConsoleMessageSource::kSecurity,
                                mojom::ConsoleMessageLevel::kWarning, message);
}

// static
ConsoleMessage*
MixedContentChecker::CreateConsoleMessageAboutWebSocketAutoupgrade(
    const KURL& main_resource_url,
    const KURL& mixed_content_url) {
  String message = String::Format(
      "Mixed Content: The page at '%s' was loaded over HTTPS, but attempted "
      "to connect to the insecure WebSocket endpoint '%s'. As part of an "
      "experiment this request was automatically upgraded to HTTPS, For more "
      "information see "
      "https://chromium.googlesource.com/chromium/src/+/master/docs/security/"
      "autoupgrade-mixed.md",
      main_resource_url.ElidedString().Utf8().c_str(),
      mixed_content_url.ElidedString().Utf8().c_str());
  return ConsoleMessage::Create(mojom::ConsoleMessageSource::kSecurity,
                                mojom::ConsoleMessageLevel::kWarning, message);
}

...

// static
void MixedContentChecker::UpgradeInsecureRequest(
  ...
            MixedContentChecker::CreateConsoleMessageAboutFetchAutoupgrade(
                fetch_client_settings_object->GlobalObjectUrl(),
                resource_request.Url()));
  ...
      resource_request.SetIsAutomaticUpgrade(false);// [@LT]: turn off automatic upgrade
  ...

  // We set the UpgradeIfInsecure flag even if the current request wasn't
  // upgraded (due to already being HTTPS), since we still need to upgrade
  // redirects if they are not to HTTPS URLs.
  resource_request.SetUpgradeIfInsecure(false);// [@LT]: turn off automatic upgrade

  KURL url = resource_request.Url();

  ...

    url.SetProtocol("https");
    if (url.Port() == 80)
      url.SetPort(443);
    // resource_request.SetUrl(url); // [@LT]: turn off automatic upgrade
  }
  ...
```  