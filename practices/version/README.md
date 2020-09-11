# version content


版本数值文件： `src\chrome\VERSION`

```
MAJOR=78
MINOR=0
BUILD=3904
PATCH=97
+ MAIN=1
+ SUB=0
+ PHASE=3
+ STEP=5
```

其中`MAJOR`, `MINOR`, `BUILD`, `PATCH`为浏览器内核版本，不可修改，不然会出现网页兼容性问题。<br>
添加的 `MAIN`, `SUB`, `PHASE`, `STEP` 可以作为显示产品发布版本的信息。


版本宏定义头文件模板： `src\components\version_info\version_info_values.h.version`
```c++
// Copyright (c) 2010 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef COMPONENTS_VERSION_INFO_VERSION_INFO_VALUES_H_
#define COMPONENTS_VERSION_INFO_VERSION_INFO_VALUES_H_

#define PRODUCT_NAME "@PRODUCT_FULLNAME@"
#define PRODUCT_VERSION "@MAJOR@.@MINOR@.@BUILD@.@PATCH@"
+ #define RELEASE_VERSION "@MAIN@.@SUB@.@PHASE@.@STEP@" // add release version
#define LAST_CHANGE "@LASTCHANGE@"
#define IS_OFFICIAL_BUILD @OFFICIAL_BUILD@

#endif  // COMPONENTS_VERSION_INFO_VERSION_INFO_VALUES_H_
```
添加的根据 `MAIN`, `SUB`, `PHASE`, `STEP` 生成作为显示产品发布版本的信息的宏 `RELEASE_VERSION`。<br>
其中 `IS_OFFICIAL_BUILD` 是否为`true`, 取决于编译选项 `is_official_build` 是否为 `true`。


添加获取发布版本号函数：<br>
`src\components\version_info\version_info.h`
```c++
// Returns the release version number, e.g. "1.0.3.5".
std::string GetReleaseVersionNumber();
```
`src\components\version_info\version_info.cc`
```c++
// Get release version number
std::string GetReleaseVersionNumber() {
  return RELEASE_VERSION;
}
```

修改关于页面显示的版本号：<br>
`src\chrome\browser\ui\webui\settings\about_handler.cc`
```c++
...

  html_source->AddString(
      "aboutBrowserVersion",
      l10n_util::GetStringFUTF16(
          IDS_SETTINGS_ABOUT_PAGE_BROWSER_VERSION,
-         base::UTF8ToUTF16(version_info::GetVersionNumber()),
+         base::UTF8ToUTF16(version_info::GetReleaseVersionNumber()), //change to release version
          l10n_util::GetStringUTF16(version_info::IsOfficialBuild()
                                        ? IDS_VERSION_UI_OFFICIAL
                                        : IDS_VERSION_UI_UNOFFICIAL),
          base::UTF8ToUTF16(chrome::GetChannelName()),
          l10n_util::GetStringUTF16(sizeof(void*) == 8
                                        ? IDS_VERSION_UI_64BIT
                                        : IDS_VERSION_UI_32BIT)));

...
```

函数 `version_info::IsOfficialBuild()` 会返回宏 IS_OFFICIAL_BUILD 的值:<br>
`src\components\version_info\version_info.cc`
```c++
bool IsOfficialBuild() {
  return IS_OFFICIAL_BUILD;
}
```
