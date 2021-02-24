# chromium build on macOS

官方文档：<br>
- [mac build instructions](https://chromium.googlesource.com/chromium/src/+/master/docs/mac_build_instructions.md)
- [working with release branches](https://www.chromium.org/developers/how-tos/get-the-code/working-with-release-branches)


拉取特定版本：<br>
```shell
# Make sure you are in 'src'.
# This part should only need to be done once, but it won't hurt to repeat it. The first
# time checking out branches and tags might take a while because it fetches an extra
# 1/2 GB or so of branch commits. 
gclient sync --with_branch_heads --with_tags

# You may have to explicitly 'git fetch origin' to pull branch-heads/
git fetch

# Checkout the branch 'src' tree.
git checkout -b branch_$BRANCH branch-heads/$BRANCH

# Checkout all the submodules at their branch DEPS revisions.
gclient sync --with_branch_heads --with_tags
```

额外脚本：

文件权限属性预处理：<br>
```shell
## preperations -> add executable property to following files
chmod +x build/mac/tweak_info_plist.py
chmod +x build/toolchain/mac/linker_driver.py
chmod +x build/util/version.py
chmod +x build/util/java_action.py
chmod +x build/util/generate_wrapper.py

chmod +x third_party/dom_distiller_js/protoc_plugins/json_values_converter.py
chmod +x chrome/tools/build/mac/verify_order
```