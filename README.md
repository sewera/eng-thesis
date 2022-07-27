# Engineering thesis

## Generate

```sh
make
```

## Watch mode

```sh
make watch
```

## Tips

- Use [Semantic Line Breaks](https://sembr.org/)

Based on [ArturB/WUT-Thesis](https://github.com/ArturB/WUT-Thesis),
with additional cleanup and refactoring.

---

## TODO

- [ ] Update citations to commits, and group them properly (see refactoring.tex)
- [ ] Add appendix references

## Troubleshooting

When `latexindent` fails, some perl modules may be missing.
In my case, on Arch Linux, it was:

```sh
sudo pacman -S \
  perl-eval-closure \
  perl-file-homedir \
  perl-log-log4perl \
  perl-namespace-autoclean \
  perl-params-validationcompiler \
  perl-specio \
  perl-unicode-linebreak \
  perl-yaml-tiny
```
