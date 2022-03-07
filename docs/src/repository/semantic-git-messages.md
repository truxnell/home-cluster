# Semantic Commit Messages

In this repo, I have made some effort to use semantic commit messaging to be a bit more descriptive/declaritive of what my changes do.
Despite being a personal project, it still aids in readability of your own changes, and helps track why and how changes are made in a glancable format. 

Examples:

- `fix(images): update helm values ghcr.io/k8s-at-home/prowlarr to v0.2.0.1560`
- `docs: draft mullvad images`
- `feat: enable qbittorrent`
- `fix: tpyo`

> Below is sourced form [https://gist.github.com/joshbuchea/6f47e86d2510bce28f8e7f42ae84c716](https://gist.github.com/joshbuchea/6f47e86d2510bce28f8e7f42ae84c716) with some minor amendmends

## Semantic commit rundown
See how a minor change to your commit message style can make you a better programmer.

Format: `<type>(<scope>): <subject>`

`<scope>` is optional.  ! after scope/type indicates breaking change.  This may be found in renovatebot commits mainly.

## Example

```
feat: add hat wobble
^--^  ^------------^
|     |
|     +-> Summary in present tense.
|
+-------> Type: chore, docs, feat, fix, refactor, style, or test.
```

More Examples:

- `feat`: (new feature for the user, not a new feature for build script)
- `fix`: (bug fix for the user, not a fix to a build script)
- `docs`: (changes to the documentation)
- `style`: (formatting, missing semi colons, etc; no production code change)
- `refactor`: (refactoring production code, eg. renaming a variable, not a bugfix or feature)
- `test`: (adding missing tests, refactoring tests; no production code change)
- `chore`: (updating grunt tasks etc; no production code change)
- `ci`: (continuous integration tasks)
- `build`: (build tasks)
- `perf`: (changes that affect performance)

References:

- https://www.conventionalcommits.org/
- https://seesparkbox.com/foundry/semantic_commit_messages
- http://karma-runner.github.io/1.0/dev/git-commit-msg.html