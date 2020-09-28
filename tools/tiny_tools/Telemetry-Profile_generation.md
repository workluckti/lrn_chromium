# Telemetry: Profile Generation

By default, Telemetry runs all benchmarks in a fresh, clean profile. This isn't always desirable for benchmarking. To run with other types of profiles, use either --profile-type or --profile-dir.

* `--profile-type=`<br>
    `clean` (default behavior) -- a clean, new profile. Note that benchmarks may include initialization routines that only happen on the first run.<br>
    `default` -- the default profile associated with the browser. As far as Telemetry is concerned, this is a non-deterministic state.<br>
    `typical_user` -- a pre-recorded profile that represents a typical user's profile. Note that benchmarks may include profile upgrade routines.<br>
    `power_user` -- a pre-recorded profile that represents a power user's profile. Note that benchmarks may include profile upgrade routines.<br>
* `--profile-dir=`

A path to a profile to use. This is useful with generated profiles.

## Generated profiles
Because the canned profile-types may exhibit unrealistic behavior in benchmarks (due to profile initialization or update routines), it is useful to be able to generate a deterministic profile for benchmarking. To do so:
```sh
$ tools/perf/generate_profile --profile-type-to-generate=<PROFILE_TYPE> --output-dir=/path/to/output/profile
```
`<PROFILE_TYPE>` may be `small_profile`, `theme_profile` or `many_extensions_profile`.

Generated profile output directories should then be passed to `--profile-dir`. For example, to run the session_restore benchmark:
```sh
$ tools/perf/generate_profile --profile-type-to-generate=small_profile --output-dir=out/Release/generated_profile
```
```sh
$ tools/perf/run_benchmark --profile-dir=out/Release/generated_profile/small_profile session_restore.cold.typical_25
```
Profile generation is in the process of being updated to generate more realistic profiles. This is still a work in progress. To try it out, run:
```sh
$ tools/perf/generate_profile --profile-type-to-generate=large_profile --browser=exact --browser-executable={path_to_executable} --use-live-sites --output-dir=/path/to/output/profile
```