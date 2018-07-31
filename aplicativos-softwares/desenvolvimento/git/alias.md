---
view: git-alias
title: "Alias para GIT"
description: "Alias para git em linha de comando"

---


# Git Aliases

```ini
[alias]

clone-last-commit = clone --depth=1
alias-list = ! git config -l | grep alias | cut -c 7-

lg1 = log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all
lg2 = log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all
lg = !"git lg1"

log-branch = log --all --graph --decorate --oneline --simplify-by-decoration

branch-tree = !cd "$(git rev-parse --git-dir)/refs/heads" && tree
```