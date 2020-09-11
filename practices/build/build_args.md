 
`gn args out/Release_x64`
```gn
is_debug = false
is_component_build = false
is_official_build = false
target_cpu = "x64"
enable_nacl = false
symbol_level = 0
blink_symbol_level = 0
ffmpeg_branding = "Chrome"
enable_iterator_debugging = false
proprietary_codecs = true
```
`ninja -C out/Release_x64 chrome -j4`


`gn args out/Release_x86`
```gn
is_debug = false
is_component_build = false
is_official_build = false
target_cpu = "x86"
enable_nacl = false
symbol_level = 0
blink_symbol_level = 0
ffmpeg_branding = "Chrome"
enable_iterator_debugging = false
proprietary_codecs = true
```
`ninja -C out/Release_x86 chrome -j4`

