# git-pandoc-compiler

`git-pandoc-compiler` is a program that automatically compiles all `.md` files 
in a git repo into another git repo as PDF.
This has to be triggered via a webhook (for example of your gitlab server)

## Docker usage

The Program is intended to be run in a Docker Container

It needs the following Environment Variables to work like it should:

- `GITURL` has to be set to the Source repo
    - example: `GITURL=ssh://git@gitlab.com/user/repo.git`
- `CGITURL` has to be set to the Sink repo
    - example: `CGITURL=ssh://git@gitlab.com/user/repo-compiled.git`
- `TEMPLATELINK` __can__ be set to a link of a pandoc template (for latex)
    - example: `TEMPLATELINK=https://raw.githubusercontent.com/Wandmalfarbe/pandoc-latex-template/master/eisvogel.tex`

In addition the ssh key volume should be mounted

- ```bash -v "./pandocssh:/root/.ssh"```

And the Port for the Webhook should either be exposed or on the same docker network as the gitlab server
(the later one is advised as the software may not be very secure)

- ```bash -p "3000:3000" ```

A hostname should be set, because the container generates its git username and email out of it

- ```bash --hostname "pancompile" ```

### A full docker command should look something like this

```bash
docker run -d \
    -v "/tmp/dockerssh:/root/.ssh" \
    -e "GITURL=ssh://git@gitlab.com/user/docs.git" \
    -e "CGITURL=ssh://git@gitlab.com/user/docs-compiled.git" \
    -e "TEMPLATELINK=https://raw.githubusercontent.com/Wandmalfarbe/pandoc-latex-template/master/eisvogel.tex" \
    -p "3000:3000" --hostname "asdf" \
    --name asdf \
    gitlab.com/ragon000/git-pandoc-compiler
```
