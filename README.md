## fzf-contrib v0.1.0beta [MIT]

`fzf-contrib`(1) stores and organizes useful code snippets around the general-purpose fuzzy finder [fzf](https://github.com/junegunn/fzf).

### Project Structure

#### fzf-contrib(5) repo

```
# tree  -a -P "*" -n --noreport -L 20 --charset=ascii "$PWD"
/home/user1/var/code/projects/fzf-contrib
|-- INFO.csv
|-- README.md
|-- fzf-contrib
`-- src
    |-- .gitkeep
    |-- ag-results.vim
    |-- cd-dir-file.sh
    |-- cd-dir-hidden.sh
    |-- cd-dir.sh
    |-- completion-cmdl.vim
    |-- ctags-search.bash
    |-- edit-file.sh
    |-- git-checkout-branch.sh
    |-- git-checkout-commit.sh
    |-- grep-file-contents.sh
    |-- history-repeat-edit.bash
    |-- history-repeat.bash
    |-- history-repeat2.bash
    |-- history-repeat3.bash
    |-- kill-process.sh
    |-- locate.tmux
    |-- mru.vim
    |-- open-file.sh
    |-- search-buffer-lines.vim
    |-- tags-jump.vim
    |-- tmux-pane-switch.sh
    |-- tmux-session-select.sh
    |-- z.bash
    `-- z1.bash
```

Any src file needs to have an accurate filename with a filename extension, and a shebang formed like this:

```
#!/usr/bin/env <COMMAND WITHOUT ARGS>
#!/usr/bin/env sh
#!/usr/bin/env vim
```

Further, it should be recorded in the file called `INFO.csv`. The fields are:

```
name
applications
tags
description
```

#### fzf-custom dir/repo

It is intended to use selected code snippets in a second directory, independent from `fzf-contrib`(5) repo. The environment variable `FZF_CONTRIB_DIR` points to `${XDG_DATA_HOME:-${HOME}/.local/share}/fzf-custom` by default:

```
# tree  -a -P "*" -n --noreport -L 20 --charset=ascii "$PWD"
/home/user1/share/fzf-custom
|-- INFO.csv
|-- LINKS.txt
|-- rc
|   |-- .gitkeep
|   |-- bash
|   |   |-- .gitkeep
|   |   |-- z.bash
|   |   `-- z1.bash
|   |-- fish
|   |   `-- .gitkeep
|   |-- mksh
|   |   `-- .gitkeep
|   |-- tmux
|   |   `-- .gitkeep
|   |-- vim
|   |   `-- .gitkeep
|   `-- zsh
|       `-- .gitkeep
`-- src
    |-- ag-results.vim
    |-- cd-dir-file.sh
    |-- cd-dir-hidden.sh
    |-- cd-dir.sh
    |-- completion-cmdl.vim
    |-- ctags-search.bash
    |-- edit-file.sh
    |-- git-checkout-branch.sh
    |-- git-checkout-commit.sh
    |-- grep-file-contents.sh
    |-- history-repeat-edit.bash
    |-- history-repeat.bash
    |-- history-repeat2.bash
    |-- history-repeat3.bash
    |-- kill-process.sh
    |-- locate.tmux
    |-- mru.vim
    |-- open-file.sh
    |-- search-buffer-lines.vim
    |-- tags-jump.vim
    |-- tmux-pane-switch.sh
    |-- tmux-session-select.sh
    |-- z.bash
    `-- z1.bash
```

Files are stored in `src` and will be manually loaded / hard linked into several `rc` subdirectories. `LINKS.txt` tracks all linking; it may be used if `fzf-custom` is a git repository and we need to relink into `rc` in a git hook post script.

### `fzf-contrib`(1) command

`fzf-contrib`(1) follows the Shell and Utilities portion of the POSIX specification. It is written to copy files from `fzf-contrib` to `fzf-custom` and to maintain several code snippets inside `fzf-custom`.

#### Install

* Do `git clone https://github.com/D630/fzf-contrib.git`
* Copy the shell script `fzf-contrib` elsewhere into `<PATH>`
* `cd fzf-contrib && ./fzf-contrib init`

Explicitly required:
- sh-compatible Shell like `dash`(1) or something similar
- `cat`(1)
- `cp`(1)
- `find`(1)
- `grep`(1)
- `ln`(1)
- `ls`(1)
- `mkdir`(1)
- `rm`(1)
- `sed`(1)
- `touch`(1)
- `tr`(1)

#### Help

```
fzf-contrib v0.1.0beta
usage: fzf-contrib <subcommand> [<arguments>]

Subcommands:
add <src> [d=<dest>]            Copy a src file from <fzf-contrib/src> to
                                <FZF_CONTRIB_DIR/src>
help                            Show this instruction
info [<pattern>]                Output records from INFO.csv
init                            Initialize src dir from the <fzf-contrib>
                                repo; copy its contents to
                                <FZF_CONTRIB_DIR/src>
load <src> [a=<app>] [d=<dest>] Hard link a src file from
                                <FZF_CONTRIB_DIR/src> into
                                <FZF_CONTRIB_DIR/rc>
reload                          Remove all hardlinks in <FZF_CONTRIB_DIR/rc>
                                and source <FZF_CONTRIB_DIR/LINKS.txt>.
                                Use this command in a hook script like
                                <.git/hooks/post-merge>
uload [<src>] [a=<app>]         Remove hard link from <FZF_CONTRIB_DIR/rc>
version                         Print version

Arguments:
<app>                           Name of application and subdirectory in
                                <FZF_CONTRIB_DIR/rc>. Delimite apps with
                                comma: 'zsh,mksh,bash'
<dest>                          New name of the current script in
                                <FZF_CONTRIB_DIR/rc>
<pattern>                       Grep BRE pattern
<src>                           Basename of the script in the current
                                src dir

Environment variables:
FZF_CONTRIB_DIR
    ${XDG_DATA_HOME:-${HOME}/.local/share}/fzf-custom

```

#### Examples

To initialize `fzf-custom` and add new snippets to `fzf-contrib/src`:

```
% cd fzf-contrib/
% ./fzf-contrib info | less
% ./fzf-contrib init
> Create '/home/user1/share/fzf-custom/src'
> Copy '/home/user1/var/code/projects/fzf-contrib/INFO.csv' -> '/home/user1/share/fzf-custom/INFO.csv'
> Copy '/home/user1/var/code/projects/fzf-contrib/src/ag-results.vim' -> '/home/user1/share/fzf-custom/src/ag-results.vim'
> Copy '/home/user1/var/code/projects/fzf-contrib/src/cd-dir-file.sh' -> '/home/user1/share/fzf-custom/src/cd-dir-file.sh'
> Copy '/home/user1/var/code/projects/fzf-contrib/src/cd-dir-hidden.sh' -> '/home/user1/share/fzf-custom/src/cd-dir-hidden.sh'
> [...]
% ./fzf-contrib info z.bash | less
% ./fzf-contrib add z.bash
> Copy '/home/user1/var/code/projects/fzf-contrib/src/z.bash' -> '/home/user1/share/fzf-custom/src/z.bash'
% ./fzf-contrib add z.bash d=Z
> Copy '/home/user1/var/code/projects/fzf-contrib/src/z.bash' -> '/home/user1/share/fzf-custom/src/Z'
```

Edit `z.bash`:

```
% cd
% ls ~/share/fzf-custom
> INFO.csv  rc  src
% <EDITOR> ~/share/fzf-custom/src/z.bash
```

Load `z.bash` based on shebang:

```
% fzf-contrib load z.bash
> Create '/home/user1/share/fzf-custom/src/z.bash' -> '/home/user1/share/fzf-custom/rc/bash/z.bash'
```

Load `z.bash` based on shebang and rename it to `Z`:

```
% fzf-contrib load z.bash d=Z
> Create '/home/user1/share/fzf-custom/src/z.bash' -> '/home/user1/share/fzf-custom/rc/bash/Z'
```

Load `kill-process.sh` based on shebang. Since `bash`(1), `mksh`(1) and `zsh`(1) are sh-compatible, the script is loaded three times:

```
% fzf-contrib load kill-process.sh
> Create '/home/user1/share/fzf-custom/src/kill-process.sh' -> '/home/user1/share/fzf-custom/rc/bash/kill-process.sh'
> Create '/home/user1/share/fzf-custom/src/kill-process.sh' -> '/home/user1/share/fzf-custom/rc/mksh/kill-process.sh'
> Create '/home/user1/share/fzf-custom/src/kill-process.sh' -> '/home/user1/share/fzf-custom/rc/zsh/kill-process.sh'
```

Unload/Remove `kill-process.sh` from `fzf-custom/rc/{mksh,zsh}`:

```
% fzf-contrib uload kill-process.sh a=mksh,zsh
> Remove '/home/user1/share/fzf-custom/src/kill-process.sh' -> '/home/user1/share/fzf-custom/rc/mksh/kill-process.sh'
> Remove '/home/user1/share/fzf-custom/src/kill-process.sh' -> '/home/user1/share/fzf-custom/rc/zsh/kill-process.sh'
```

Load `kill-process.sh` into `fzf-custom/rc/mksh`:

```
% fzf-contrib load kill-process.sh a=mksh
> Create '/home/user1/share/fzf-custom/src/kill-process.sh' -> '/home/user1/share/fzf-custom/rc/mksh/kill-process.sh'
```

Load `kill-process.sh` into `fzf-custom/rc/zsh` and rename it into `KILL.zsh`:

```
% fzf-contrib load kill-process.sh a=zsh d=KILL.zsh
> Create '/home/user1/share/fzf-custom/src/kill-process.sh' -> '/home/user1/share/fzf-custom/rc/zsh/KILL.zsh'
```

Unload/Remove all links inside `fzf-custom/rc`:

```
% fzf-contrib uload
> rm: remove regular file ‘/home/user1/share/fzf-custom/LINKS.txt’?
> Remove '/home/user1/share/fzf-custom/LINKS.txt'
> Remove '/home/user1/share/fzf-custom/rc/zsh/KILL.zsh'
> Remove '/home/user1/share/fzf-custom/rc/mksh/kill-process.sh'
> Remove '/home/user1/share/fzf-custom/rc/bash/kill-process.sh'
> Remove '/home/user1/share/fzf-custom/rc/bash/z.bash'
> Remove '/home/user1/share/fzf-custom/rc/bash/Z'
```

#### Using selected code snippets

Source the scripts inside `fzf-custom/rc/<APP>` into your configuration file. For example, you may put the following into `.bashrc`:

```sh
declare snippet=
for snippet in "${FZF_CONTRIB_DIR}"/rc/bash/*
do
    source "$snippet"
done
unset -v snippet
```

#### To do

- better `fzf-contrib info`
- update `INFO.csv` after `fzf-contrib load` and `fzf-contrib uload`
- nicer names of arguments
- determine wheater the current directory is a .git repo and/or `fzf-contrib`
- example how to use `fzf-contrib reload`

### Bugs & Requests

Report it on https://github.com/D630/fzf-contrib/issues
