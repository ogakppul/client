# 설치 방법
## nodejs 21 이상 설치
## elm 설치
https://github.com/elm/compiler/blob/master/installers/linux/README.md
```bash
# Move to your Desktop so you can see what is going on easier.
#
cd ~/Desktop/

# Download the 0.19.1 binary for Linux.
#
# +-----------+----------------------+
# | FLAG      | MEANING              |
# +-----------+----------------------+
# | -L        | follow redirects     |
# | -o elm.gz | name the file elm.gz |
# +-----------+----------------------+
#
curl -L -o elm.gz https://github.com/elm/compiler/releases/download/0.19.1/binary-for-linux-64-bit.gz

# There should now be a file named `elm.gz` on your Desktop.
#
# The downloaded file is compressed to make it faster to download.
# This next command decompresses it, replacing `elm.gz` with `elm`.
#
gunzip elm.gz

# There should now be a file named `elm` on your Desktop!
#
# Every file has "permissions" about whether it can be read, written, or executed.
# So before we use this file, we need to mark this file as executable:
#
chmod +x elm

# The `elm` file is now executable. That means running `~/Desktop/elm --help`
# should work. Saying `./elm --help` works the same.
#
# But we want to be able to say `elm --help` without specifying the full file
# path every time. We can do this by moving the `elm` binary to one of the
# directories listed in your `PATH` environment variable:
#
sudo mv elm /usr/local/bin/

# Now it should be possible to run the `elm` binary just by saying its name!
#
elm --help
```
## 
## webpack 설치
```bash
npm install -g webpack
npm install webpack --save-dev
npm install -g webpack-dev-server
```
## npm audit fix와 npm audit fix --force 실행
```bash
npm audit fix
npm audit fix --force
```
## npm install config
```bash
npm install config
```
## config 파일 이름 변경하기
config-example.js를 config.js로 변경
## npm install
```bash
npm install
```
![](./docs/images/screenshot-alien-screenplay.png)

# Gingko Writer [![Web Deploy](https://github.com/gingko/client/actions/workflows/web-deploy.yml/badge.svg)](https://github.com/gingko/client/actions/workflows/web-deploy.yml)

Writing software to help organize and draft complex documents. Anything from novels and screenplays to legal briefs and graduate theses.

This is a ground-up rewrite of [GingkoApp.com](https://gingkoapp.com). The latest version is available online at [gingkowriter.com](https://gingkowriter.com).

The desktop version (on branch [desktop](https://github.com/gingko/client/tree/desktop)), is currently **well behind** the web app version. It will eventually be brought up to par, but if you need it now, it's available to download on [the releases page](https://github.com/gingko/client/releases) (for Linux, Windows, and Mac).

## Contributions Welcome!

If you want to help **translate Gingko Writer**, you can join [the translation project](https://poeditor.com/join/project/k8Br3k0JVz).

For code contributions, see [CONTRIBUTING.md](./CONTRIBUTING.md) for a guide to getting started.

---

### Installation & Dev Environment

Prerequisites:

* Git : https://git-scm.com/downloads
* Node : https://nodejs.org/en/
* Elm-Platform : https://guide.elm-lang.org/install.html

```bash
npm install
npm start
```

