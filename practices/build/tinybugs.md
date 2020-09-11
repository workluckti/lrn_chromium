```sh
$ gn help
gn.py: Could not find checkout in any parent of the current path.
This must be run inside a checkout.
```
Add `src/.gclient`:
```
solutions = [
  { "name"        : "src",
    "url"         : "http://src.chromium.org/svn/trunk/src",
    "deps_file"   : "DEPS",
    "managed"     : True,
    "custom_deps" : {
    },
    "custom_vars": {},
  },
]
```