

# Secret vars

Run with `SECRET_` variables in config files, and use flux var substitution, to aid in readability

As `password: ${SECRET_PASSWORD}` is more leigable than

```
volumemount example
```

# Secrets

`secret.sops.yaml` for sops secrets
`secret.ymal` for non-sops

Prefer open secrets with variable replacements over full encryption for ease of reading