echo "Build Start $(date) ..."|tee build.log

############### macOS ################
# Release_mac
gn gen out/Release|tee -a build.log
echo "ninja start at $(date)"|tee -a build.log
ninja -C out/Release chrome -j 4|tee -a build.log
echo "Release Done $(date)"|tee -a build.log
# Official_mac
# gn gen out/Official_x64|tee -a build.log
# echo "ninja start at $(date)"|tee -a build.log
# ninja -C out/Official chrome -j 4|tee -a build.log
# echo "Official Done $(date)"|tee -a build.log
# Debug
# gn gen out/Debug|tee -a build.log
# echo "ninja start at $(date)"|tee -a build.log
# ninja -C out/Debug chrome -j 4|tee -a build.log
# echo "Debug Done $(date)"|tee -a build.log

############## Windows ###############
# Release_x64
# gn gen out/Release_x64|tee -a build.log
# echo "ninja start at $(date)"|tee -a build.log
# ninja -C out/Release_x64 mini_installer -j 4|tee -a build.log
# echo "Release_x64 Done $(date)"|tee -a build.log
# Release_x86
# gn gen out/Release_x86|tee -a build.log
# echo "ninja start at $(date)"|tee -a build.log
# ninja -C out/Release_x86 mini_installer -j 4|tee -a build.log
# echo "Release_x86 Done $(date)"|tee -a build.log
# Official_x64
# gn gen out/Official_x64|tee -a build.log
echo "ninja start at $(date)"|tee -a build.log
ninja -C out/Official_x64 mini_installer -j 4|tee -a build.log
echo "Official_x64 Done $(date)"|tee -a build.log
# Official_x86
# gn gen out/Official_x86|tee -a build.log
# echo "ninja start at $(date)"|tee -a build.log
# ninja -C out/Official_x86 mini_installer -j 4|tee -a build.log
# echo "Official_x86 Done $(date)"|tee -a build.log
# Debug
# gn gen out/Debug|tee -a build.log
# echo "ninja start at $(date)"|tee -a build.log
# ninja -C out/Debug mini_installer -j 4|tee -a build.log
# echo "Debug Done $(date)"|tee -a build.log

echo "Build End $(date)"|tee -a build.log