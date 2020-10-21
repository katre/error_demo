def _impl(repo_ctx):
    # Error: no file written
    pass

broken_repo = repository_rule(implementation = _impl)
