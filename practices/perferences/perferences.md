# Settings Code Modification
## startup urls
`// chrome/browser/prefs/session_startup_pref_unittest.cc`
```C++
TEST_F(SessionStartupPrefTest, URLListManagedOverridesUser) {
  auto url_pref_list1 = std::make_unique<base::ListValue>();
  url_pref_list1->Set(0, std::make_unique<base::Value>("chromium.org"));
  pref_service_->SetUserPref(prefs::kURLsToRestoreOnStartup,
                             std::move(url_pref_list1));

  auto url_pref_list2 = std::make_unique<base::ListValue>();
  url_pref_list2->Set(0, std::make_unique<base::Value>("chromium.org"));
  url_pref_list2->Set(1, std::make_unique<base::Value>("chromium.org"));
  url_pref_list2->Set(2, std::make_unique<base::Value>("chromium.org"));
  pref_service_->SetManagedPref(prefs::kURLsToRestoreOnStartup,
                                std::move(url_pref_list2));
```

`src\chrome\browser\prefs\session_startup_pref.cc`
```C++
void SessionStartupPref::RegisterProfilePrefs(
    user_prefs::PrefRegistrySyncable* registry) {
#if defined(OS_ANDROID)
  uint32_t flags = PrefRegistry::NO_REGISTRATION_FLAGS;
#else
  uint32_t flags = user_prefs::PrefRegistrySyncable::SYNCABLE_PREF;
#endif
  registry->RegisterIntegerPref(prefs::kRestoreOnStartup,
                                TypeToPrefValue(GetDefaultStartupType()),
                                flags);

+   base::ListValue url_pref_list;
+   url_pref_list.Set(0, std::make_unique<base::Value>("https://www.baidu.com"));

-  registry->RegisterListPref(prefs::kURLsToRestoreOnStartup, flags);
+  registry->RegisterListPref(prefs::kURLsToRestoreOnStartup, std::move(url_pref_list), flags);

}
```


## default search engine
`src/components/search_engines/template_url_prepopulate_data.cc`
```C++
std::vector<std::unique_ptr<TemplateURLData>> GetPrepopulatedEngines(
    PrefService* prefs,
    size_t* default_search_provider_index) {
  // If there is a set of search engines in the preferences file, it overrides
  // the built-in set.
  std::vector<std::unique_ptr<TemplateURLData>> t_urls =
      GetPrepopulatedTemplateURLData(prefs);
  if (t_urls.empty()) {
    t_urls = GetPrepopulationSetFromCountryID(
        country_codes::GetCountryIDFromPrefs(prefs));
  }
  if (default_search_provider_index) {
    const auto itr = std::find_if(
        t_urls.begin(), t_urls.end(),
-       [](const auto& t_url) { return t_url->prepopulate_id == google.id; });
+       [](const auto& t_url) { return t_url->prepopulate_id == baidu.id; });
    *default_search_provider_index =
        itr == t_urls.end() ? 0 : std::distance(t_urls.begin(), itr);
  }
  return t_urls;
}
```