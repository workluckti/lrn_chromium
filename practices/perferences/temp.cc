// chrome/browser/prefs/session_startup_pref_unittest.cc

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