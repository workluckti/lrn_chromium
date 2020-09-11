# External exe Progam operation

## Launch

`base/process/launch.h`
```c++
// Launch a process via the command line |cmdline|.
// See the documentation of LaunchOptions for details on |options|.
//
// Returns a valid Process upon success.
//
// Unix-specific notes:
// - All file descriptors open in the parent process will be closed in the
//   child process except for any preserved by options::fds_to_remap, and
//   stdin, stdout, and stderr. If not remapped by options::fds_to_remap,
//   stdin is reopened as /dev/null, and the child is allowed to inherit its
//   parent's stdout and stderr.
// - If the first argument on the command line does not contain a slash,
//   PATH will be searched.  (See man execvp.)
BASE_EXPORT Process LaunchProcess(const CommandLine& cmdline,
                                  const LaunchOptions& options);
```


`src\chrome\browser\browser_process_impl.cc`
```c++
g_browser_process = this; // global browser process

...
void BrowserProcessImpl::Init() {
  ...
  //launch
  base::FilePath exe_dir;
  constexpr base::FilePath::CharType kExecutable[] =
    FILE_PATH_LITERAL("program.exe");
  CHECK(base::PathService::Get(base::DIR_CURRENT, &exe_dir));
  DLOG(INFO) << "[@LT]" << exe_dir;
  base::CommandLine exe_command_line(exe_dir.Append(kExecutable));
  exe_command_line.AppendArg("arg-one");
  DLOG(INFO) << "[@LT]" << exe_command_line.GetCommandLineString();
  base::LaunchOptions exe_launch_options;
  exe_launch_options.current_directory = exe_dir;
  exe_launch_options.grant_foreground_privilege = true;
  base::Process exe_process_ = base::LaunchProcess(
                exe_command_line, exe_launch_options);
```


## Shut down

`base/process/process.h`
```c++
  // Terminates the process with extreme prejudice. The given |exit_code| will
  // be the exit code of the process. If |wait| is true, this method will wait
  // for up to one minute for the process to actually terminate.
  // Returns true if the process terminates within the allowed time.
  // NOTE: On POSIX |exit_code| is ignored.
  bool Terminate(int exit_code, bool wait) const;
```

`src\chrome\browser\browser_process_impl.cc`
```c++
...

void BrowserProcessImpl::StartTearDown() {
  TRACE_EVENT0("shutdown", "BrowserProcessImpl::StartTearDown");
  // TODO(crbug.com/560486): Fix the tests that make the check of
  // |tearing_down_| necessary in IsShuttingDown().
  tearing_down_ = true;
  DCHECK(IsShuttingDown());
  // terminate exe process implement function
  exe_process_.Terminate(0, false);

...
```

