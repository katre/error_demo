# Errors Swallowed By IgnoredPackagePrefixesFunction

Demonstrating https://github.com/bazelbuild/bazel/issues/12303.

This build fails because the repository is invalid, but shows the actual underlying error:

```
$ bazel build @broken//...
ERROR: broken_repo rule //external:broken must create a directory
INFO: Elapsed time: 0.095s
INFO: 0 processes.
FAILED: Build did NOT complete successfully (0 packages loaded)
``

This build fails because there is no applicable toolchain, and shows a useful
error message:

```
$ bazel build //:sample
ERROR: While resolving toolchains for target //:sample: no matching toolchains found for types //:toolchain_type
WARNING: errors encountered while analyzing target '//:sample': it will not be built
INFO: Analyzed target //:sample (0 packages loaded, 0 targets configured).
INFO: Found 0 targets...
ERROR: command succeeded, but not all targets were analyzed
INFO: Elapsed time: 0.114s, Critical Path: 0.02s
INFO: 1 process: 1 internal.
FAILED: Build did NOT complete successfully
```

This build however, fails without any type of useful error:

```
$ bazel build //:sample --extra_toolchains=@broken//...
INFO: Build option --extra_toolchains has changed, discarding analysis cache.
WARNING: errors encountered while analyzing target '//:sample': it will not be built
INFO: Analyzed target //:sample (0 packages loaded, 6 targets configured).
INFO: Found 0 targets...
ERROR: command succeeded, but not all targets were analyzed
INFO: Elapsed time: 0.130s, Critical Path: 0.02s
INFO: 1 process: 1 internal.
FAILED: Build did NOT complete successfully
```

It should ideally show both of the above messages, but at a minimum should tell
the user that the repository rule is invalid.
