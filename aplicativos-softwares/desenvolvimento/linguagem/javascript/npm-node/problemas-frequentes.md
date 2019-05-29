https://raw.githubusercontent.com/wiki/npm/npm/Troubleshooting.md

Many common problems can be solved with one of these steps:

## Try the latest stable version of node

Node 0.4 and 0.6 are [no longer supported](https://github.com/npm/npm/issues/4379#issuecomment-31183058).

If you're experiencing issues while using a version of node which is unsupported (e.g 0.4.x or 0.6.x) or unstable (odd numbered versions e.g. 0.7.x, 0.9.x, 0.11.x), it's very possible your issue will be fixed by simply using the latest stable version of node.

### See what version of node you're running:

```
node -v
```

#### Updating node on Linux

For some Linux distributions (Debian/Ubuntu and RedHat/CentOS), the latest node version provided by the distribution may lag behind the stable version.  Here are [instructions from NodeSource](https://github.com/nodesource/distributions) on getting the latest node.

#### Updating node on Windows

Install the latest msi from <https://nodejs.org/download>

#### Updating node on OSX

Install the latest package from <https://nodejs.org/download>

or if you are using [homebrew](http://brew.sh/)

```
brew install node
```

#### Installing or updating node without elevated permissions

If you want to install/update node on a unix-like system but don't have root permissions, [here are a number of ways to do that](https://gist.github.com/isaacs/579814)!


## Try the latest stable version of npm

### See what version of npm you're running:

```
npm -v
```

### Upgrading on *nix (OSX, Linux, etc.)

_(You may need to prefix these commands with `sudo`, especially on Linux, or OS X if you installed Node using its default installer.)_

You can upgrade to the latest version of npm using:

```
npm install -g npm@latest
```

Or upgrade to the most recent LTS release:
```
npm install -g npm@lts
```

### Upgrading on Windows
_Microsoft wrote a small command line tool to automate the steps below. [You can go and download it here](https://github.com/felixrieseberg/npm-windows-upgrade) - or stick with the manual path outlined below._

___

By default, npm is installed alongside node in `C:\Program Files (x86)\nodejs`. npm's globally installed packages (including, potentially, npm itself) are stored separately in a user-specific directory (which is currently `C:\Users\<username>\AppData\Roaming\npm`). Because the installer puts `C:\Program Files (x86)\nodejs`  before `C:\Users\<username>\AppData\Roaming\npm` on your `PATH`, it will always use version of npm installed with node instead of the version of npm you installed using `npm -g install npm@<version>`. To get around this, you can do **one** of the following:

* Option 1: [edit your Windows installation's `PATH`](http://superuser.com/questions/284342/what-are-path-and-other-environment-variables-and-how-can-i-set-or-use-them) to put `%appdata%\npm` before `%ProgramFiles%\nodejs`.
Remember that you'll need to restart `cmd.exe` (and potentially restart Windows) when you make changes to `PATH` or how npm is installed.

* Option 2: remove both of
	* `%ProgramFiles%\nodejs\npm`
	* `%ProgramFiles%\nodejs\npm.cmd`

* Option 3: Navigate to `%ProgramFiles%\nodejs\node_modules\npm` and copy the `npmrc`file to another folder or the desktop.
Then open `cmd.exe` and run the following commands:
```bash
cd %ProgramFiles%\nodejs
npm install npm@latest
```

If you installed npm with the node.js installer, after doing one of the previous steps, do the following. 

* Option 1 or 2
    * Go into `%ProgramFiles%\nodejs\node_modules\npm` and copy the file named `npmrc` in the new npm folder, which should be `%appdata%\npm\node_modules\npm`. This will tell the new npm where the global installed packages are. 

* Option 3
    * Copy the npmrc file back into `%ProgramFiles%\nodejs\node_modules\npm`

*(See also the [point below](https://github.com/npm/npm/wiki/Troubleshooting#error-enoent-stat-cusersuserappdataroamingnpm-on-windows-7) if you're running Windows 7 and don't have the directory `%appdata%\npm`.)*

#### A brief note on the built-in Windows configuration

The Node installer installs, directly into the npm folder, a special piece of Windows-specific configuration that tells npm where to install global packages. When npm is used to install itself, it is supposed to copy this special `builtin` configuration into the new install. There was a bug in some versions of npm that kept this from working, so you may need to go in and fix that up by hand. Run the following command to see where npm will  install global packages to verify it is correct.

```
npm config get prefix -g
```

If it isn't set to `<X>:\Users\<user>\AppData\Roaming\npm`, you can run the below command to correct it:

```
npm config set prefix "${APPDATA}/npm" -g
```

Incidentally, if you would prefer that packages not be installed to your roaming profile (because you have a quota on your shared network, or it makes logging in or out from a domain sluggish), you can put it in your local app data instead:

```
npm config set prefix "${LOCALAPPDATA}/npm" -g
```

...as well as copying `%APPDATA%\npm` to `%LOCALAPPDATA%\npm` (and updating your `%PATH%`, of course).

Everyone who works on npm knows that this process is complicated and fraught, and we're working on making it simpler. Stay tuned.

## If your npm is broken

Reinstall npm:

```sh
curl -L https://www.npmjs.org/install.sh | sh
```

If you're on Windows and you have a broken installation, the easiest thing to do is to reinstall node from the official installer (remember [this note](https://github.com/npm/npm/wiki/Troubleshooting#upgrading-on-windows)).

## Try clearing the npm cache

Sometimes npm's cache gets confused. You can reset it using:

```
npm cache clean
```

------

## Common Errors

### No compatible version found

You have an outdated npm. [Please update to the latest stable npm](https://github.com/npm/npm/wiki/Troubleshooting#try-the-latest-stable-version-of-npm).

### Permission Error

```
npm ERR! code EPERM
```

```
npm ERR! code EACCES
```

* Fix the permissions of your cache with `sudo chown -R $(whoami) "$HOME/.npm"`.
* Try again with `sudo`. e.g. `sudo npm install express -g`. (You'll probably need to fix cache permissions afterwards, as above).
* [Reinstall node so it doesn't require sudo](https://gist.github.com/isaacs/579814).

### Travis projects using 0.8 can't upgrade to npm 2

In your `.travis.yml` replace this: 

``` yaml
before_install:
- npm install -g npm@latest
```

with this: 

``` yaml
before_install:
- '[ "${TRAVIS_NODE_VERSION}" != "0.8" ] || npm install -g npm@1.4.28'
- npm install -g npm@latest
```

This suggestion is based on [this Travis issue](https://github.com/travis-ci/travis-ci/issues/1785#issuecomment-31253761) and comes courtesy [@simondean](https://github.com/simondean).

### `Error: ENOENT, stat 'C:\Users\<user>\AppData\Roaming\npm'` on Windows 7

This is a consequence of [joyent/node#8141](https://github.com/joyent/node/issues/8141), and is an issue with the Node installer for Windows. The workaround is to ensure that `C:\Users\<user>\AppData\Roaming\npm` exists and is writable with your normal user account.

### No space

```
npm ERR! Error: ENOSPC, write
```

You are trying to install on a drive that either has no space, or has no permission to write.

* Free some disk space or
* Set the tmp folder somewhere with more space: `npm config set tmp /path/to/big/drive/tmp` or
* Build Node yourself and install it somewhere writable with lots of space.

### No git

```
npm ERR! not found: git
ENOGIT
```

You need to [install git](http://git-scm.com/book/en/Getting-Started-Installing-Git).

### running a Vagrant box on Windows fails due to path length issues

**[@drmyersii](https://github.com/drmyersii)** went through what sounds like a lot of painful trial and error to come up with a working solution involving Windows long paths and some custom Vagrant configuration:

> [This is the commit that I implemented it in](https://github.com/renobit/vagrant-node-env/commit/bdf15f2f301e2b1660b839875e34f172ea8be227), but I'll go ahead and post the main snippet of code here:
> 
> ```ruby
> config.vm.provider "virtualbox" do |v|
>     v.customize ["sharedfolder", "add", :id, "--name", "www", "--hostpath", (("//?/" + File.dirname(__FILE__) + "/www").gsub("/","\\"))]
> end
> 
> config.vm.provision :shell, inline: "mkdir /home/vagrant/www"
> config.vm.provision :shell, inline: "mount -t vboxsf -o uid=`id -u vagrant`,gid=`getent group vagrant | cut -d: -f3` > www /home/vagrant/www", run: "always"
> ```
> 
> In the code above, I am appending ```\\?\``` to the current directory absolute path. This will actually force the Windows API to allow an increase in the MAX_PATH variable (normally capped at 260). Read more about [max path](https://msdn.microsoft.com/en-us/library/windows/desktop/aa365247%28v=vs.85%29.aspx#maxpath). This is happening during the sharedfolder creation which is intentionally handled by VBoxManage and not Vagrant's "synced_folder" method. The last bit is pretty self-explanatory; we create the new shared folder and then make sure it's mounted each time the machine is accessed or touched since Vagrant likes to reload its mounts/shared folders on each load.

### npm only uses `git:` and `ssh+git:` URLs for GitHub repos, breaking proxies

**[@LaurentGoderre](https://github.com/LaurentGoderre)** fixed this with [some Git trickery](https://github.com/npm/npm/issues/5257#issuecomment-60441477):

> I fixed this issue for several of my colleagues by running the following two commands:
> 
> ```
> git config --global url."https://github.com/".insteadOf git@github.com:
> git config --global url."https://".insteadOf git://
> ```
> 
> One thing we noticed is that the `.gitconfig` used is not always the one expected so if you are on a machine that modified the home path to a shared drive, you need to ensure that your `.gitconfig` is the same on both your shared drive and in `c:\users\[your user]\`

### SSL Error

```
npm ERR! Error: 7684:error:140770FC:SSL routines:SSL23_GET_SERVER_HELLO:unknown protocol:openssl\ssl\s23_clnt.c:787:
```

You are trying to talk SSL to an unencrypted endpoint. More often than not, this is due to a [proxy](https://docs.npmjs.com/misc/config#proxy) [configuration](https://docs.npmjs.com/misc/config#https-proxy) [error](https://docs.npmjs.com/misc/config#cafile) (see also [this helpful, if dated, guide](http://jjasonclark.com/how-to-setup-node-behind-web-proxy)). In this case, you do **not** want to disable `strict-ssl` – you may need to set up a CA / CA file for use with your proxy, but it's much better to take the time to figure that out than disabling SSL protection.

```
npm ERR! Error: SSL Error: CERT_UNTRUSTED
```

```
npm ERR! Error: SSL Error: UNABLE_TO_VERIFY_LEAF_SIGNATURE
```

This problem will happen if you're running Node 0.6. Please upgrade to node 0.8 or above. [See this post for details](http://blog.npmjs.org/post/71267056460/fastly-manta-loggly-and-couchdb-attachments).

You could also try these workarounds: `npm config set ca ""` or `npm config set strict-ssl false`

```
npm ERR! Error: SSL Error: SELF_SIGNED_CERT_IN_CHAIN
```

[npm no longer supports its self-signed certificates](http://blog.npmjs.org/post/78085451721/npms-self-signed-certificate-is-no-more)

Either:

* upgrade your version of npm `npm install npm -g --ca=""`
* tell your current version of npm to use known registrars `npm config set ca=""`

If this does not fix the problem, then you may have an SSL-intercepting proxy.
(For example, Kaspersky: 
[#7439 (comment)](https://github.com/npm/npm/issues/7439#issuecomment-76024878)
and
[#16132 (comment)](https://github.com/npm/npm/issues/16132#issuecomment-288857431))

```
npm ERR! code UNABLE_TO_GET_ISSUER_CERT_LOCALLY
```

This error means that there's a TLS certificate in the chain that is signed by
an unknown certificate authority (CA). Presumably, this is the certificate used
by one's HTTPS proxy. The solution is to configure the
[`cafile`](https://docs.npmjs.com/misc/config#cafile) value:

``` bash
$ npm config set cafile /path/to/your/file.pem
```

If you need to, you can generate a `.pem` file from a `.crt` one with:

``` bash
$ openssl x509 -inform der -in /path/to/the.crt -out /path/to/the/file.pem
```

For more discussion on this error, see
[#9580](https://github.com/npm/npm/issues/9580) and
[nodejs/node#3742](https://github.com/nodejs/node/issues/3742).

### SSL-intercepting proxy

Unsolved. See https://github.com/npm/npm/issues/9282

### Not found / Server error

```
npm http 404 https://registry.npmjs.org/faye-websocket/-/faye-websocket-0.7.0.tgz
npm ERR! fetch failed https://registry.npmjs.org/faye-websocket/-/faye-websocket-0.7.0.tgz
npm ERR! Error: 404 Not Found
```

```
npm http 500 https://registry.npmjs.org/phonegap
```

* It's most likely a temporary npm registry glitch. Check [npm server status](http://status.npmjs.org/) and try again later.
* If the error persists, perhaps the published package is corrupt. Contact the package owner and have them publish a new version of the package.

### Invalid JSON

```
Error: Invalid JSON
```

```
npm ERR! SyntaxError: Unexpected token <
```

```
npm ERR! registry error parsing json
```

* Possible temporary npm registry glitch, or corrupted local server cache.
Run `npm cache clean` and/or try again later. 
* This can be caused by corporate proxies that give HTML
responses to `package.json` requests. Check npm's proxy [configuration](https://npmjs.org/doc/misc/npm-config.html).
* Check that it's not a problem with a package you're trying to install
(e.g. invalid `package.json`).

### Many `ENOENT` / `ENOTEMPTY` errors in output

npm is written to use resources efficiently on install, and part of this is that it tries to do as many things concurrently as is practical. Sometimes this results in race conditions and other synchronization issues. As of npm 2.0.0, a very large number of these issues were addressed. If you see `ENOENT lstat`, `ENOENT chmod`, `ENOTEMPTY unlink`, or something similar in your log output, try updating npm to the latest version. If the problem persists, look at [npm/npm#6043](https://github.com/npm/npm/issues/6043) and see if somebody has already discussed your issue.

### `cb() never called!` when using shrinkwrapped dependencies

Take a look at [issue #5920](https://github.com/npm/npm/issues/5920). ~~We're working on fixing this one, but it's a fairly subtle race condition and it's taking us a little time. You might try moving your `npm-shrinkwrap.json` file out of the way until we have this fixed.~~ This has been fixed in versions of npm newer than `npm@2.1.5`, so update to `npm@latest`.

### `npm login` errors

Sometimes `npm login` fails for no obvious reason.  The first thing to do is to log in at <https://www.npmjs.com/login> and check that your e-mail address on `npmjs.com` matches the 
email address you are giving to `npm login`.

If that's not the problem, or if you are seeing the message `"may not mix password_sha and pbkdf2"`, then 

1. Log in at https://npmjs.com/
2. Change password at https://npmjs.com/password – you can even "change" it to the same password
3. Clear login-related fields from `~/.npmrc` – e.g., by running `sed -ie '/registry.npmjs.org/d' ~/.npmrc`
4. `npm login`

and it generally seems to work.

See <https://github.com/npm/npm/issues/6641#issuecomment-72984009> for the history of this issue.

### `npm` hangs on Windows at `addRemoteTarball`

Check if you have two temp directories set in your `.npmrc`:

```
> npm config ls -l 
```

Look for lines defining the `tmp` config variable.  If you find more than one, remove all but one of them.

See <https://github.com/npm/npm/issues/7590> for more about this unusual problem.

### Other

* Some strange issues can be resolved by simply running `npm cache clean` and trying again.
* If you are having trouble with `npm install`, use the `-verbose` option to have more details.