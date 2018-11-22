# pandoc-compile

`pandoc-compile` is a program that automatically compiles all `.md` files 
in a folder into another folder as PDF.
It's intended use is to generate gitlab-ci artifacts

## Docker usage

The Program is intended to be run in a gitlab-runner

It needs the following Environment Variables to work like it should:

- `TEMPLATELINK` __can__ be set to a link of a pandoc template (for latex)
    - example: `TEMPLATELINK=https://raw.githubusercontent.com/Wandmalfarbe/pandoc-latex-template/master/eisvogel.tex`
- `PANDOCCMD` can be set to a custom pandoc command
    - example: `PANDOCCMD=pandoc --listings`

### A full `gitlab-ci.yml` should look something like this

```yaml
image: ragon000/pandoc-compile
variables:
  TEMPLATELINK: "https://raw.githubusercontent.com/Wandmalfarbe/pandoc-latex-template/master/eisvogel.tex"
  PANDOCCMD: "pandoc --listings --pdf-engine=xelatex"
pdf:
  script: 
  - pandoc.sh
  artifacts:
    paths:
    - ./build/*
    expire_in: 1 week
```
