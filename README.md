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

- [ ] describe the `domain` package in core,
- [ ] write about the decisions made in the project,
- [ ] read e-book notes, and decide on the necessary notes,
- [ ] describe the `components` dir in ui.

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

To properly set up the line wrapping in the `listings` package,
all of the above options have to be set up:

```latex
\lstdefinestyle{codestyle}{
    breakatwhitespace=false,
    breaklines=true,
    prebreak=\space,
    postbreak=\space
}
\lstset{style=codestyle}
```

The current `listings` setup is as follows:

```latex
% Code listings
\RequirePackage[dvipsnames]{xcolor} % 68 additional named colors (CMYK)
\RequirePackage{listings}
\lstdefinestyle{codestyle}{
    commentstyle=\color{darkgray},
    keywordstyle=\color{Mulberry},
    stringstyle=\color{RoyalBlue},
    numberstyle=\tiny\color{Gray},
    basicstyle=\footnotesize\bfseries\ttfamily,
    breakatwhitespace=false,
    breaklines=true,
    prebreak=\space\raisebox{0ex}[0ex][0ex]{\ensuremath{\hookleftarrow}},
    postbreak=\raisebox{0ex}[0ex][0ex]{\ensuremath{\hookrightarrow}}\space,
    captionpos=b,
    keepspaces=true,
    numbers=left,
    numbersep=5pt,
    showspaces=false,
    showstringspaces=false,
    showtabs=false,
    tabsize=4,
}
\lstset{style=codestyle}
% listings custom syntax
%% diff
\lstdefinelanguage{diff}{
    morecomment=[f][\color{RoyalBlue}]{@@}, % group identifier
    morecomment=[f][\color{BrickRed}]-,     % deleted lines
    morecomment=[f][\color{OliveGreen}]+,   % added lines
    morecomment=[f][\color{Mulberry}]{---}, % diff header lines (must appear after +,-)
    morecomment=[f][\color{Mulberry}]{+++},
}
```
