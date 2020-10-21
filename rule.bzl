def _impl(ctx):
    pass

sample = rule(
    implementation = _impl,
    toolchains = ["//:toolchain_type"],
)
