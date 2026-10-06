[🇮🇹 Italiano](19-web-permissions-and-cgi.md) · 🇬🇧 **English**

# Web permissions and CGI

> **Internet Force 1995–1996 Historical Archive**
> Historical reconstruction and technical documentation based on original Internet Force materials preserved by Marco Iannacone.
> Author and archive curator: Marco Iannacone · https://pippo.com
> License: [CC BY 4.0](../LICENSE)

## What problem this solves

Internet Force's web hosted static pages, customer personal areas, virtual sites
and **CGI programs**. A CGI is a program the web server runs instead of sending an
html file: for it to work the right file must be in the right place (on the server), with the correct
**owner** and **permissions**, under a safe execution model. This chapter explains
that model on DATA and USERS.

## From static document to Web application

Today a “Web page” is often the final result of a fairly complex chain
involving applications, frameworks, databases, templates, APIs, and code
running both on the server and in the browser. The early Web was
conceptually much simpler.

The **browser** was the client: it requested a resource over HTTP,
received HTML, and interpreted it to build what the user saw. The
**Web server** played the opposite role: it accepted the request,
located the corresponding resource, and returned it to the browser.

In the most common case that resource was simply an **HTML file already
present on the filesystem**. The server did not have to construct the
page or interpret its contents: it read the file and sent it. If the
HTML referenced images, the browser then requested those files
separately from the server.

The Web therefore began primarily as a system for publishing and
linking **documents**.

### HTML and images: when the Web was made of files

Web pages also looked very different from contemporary ones. **GIF**
was ubiquitous for logos, buttons, icons, bars, backgrounds, and other
interface elements, thanks to its compact indexed palette and support
for transparency. **JPEG** was already available and was particularly
useful for photographs and continuous-tone images, but much of the
graphical furniture of a 1990s website ended up in `.gif` files.

By the middle of the decade, **animated GIFs** had also become
widespread: several images stored in a single file and displayed
sequentially by the browser. For several years they became an almost
unavoidable part of the Web landscape, from tiny “new” indicators to
purely decorative animations.

The preserved [1997 snapshot of
pippo.com](../systems/marco/personal-web/pippo.com-1997/snapshot/index.html)
belongs squarely to that generation of the Web: HTML, frames, GIF
images and animations were elements of the page itself, rather than the
output of a modern front-end application.
A concrete example is [`titolo.gif`](../systems/marco/personal-web/pippo.com-1997/snapshot/titolo.gif),
the animated GIF used on the original page.

The important distinction is that **HTML and images were normally
ready-made files**. In the simplest case the server did not generate the
page: it served it.

### SSI: the server starts changing the document

It soon became useful to produce pages containing at least some
changing information without having to write a complete application.

NCSA HTTPd already supported **Server-Side Includes (SSI)**, also known
as *server-parsed HTML*. Instead of immediately sending the requested
file, the server could recognise some documents as requiring processing,
often through the `.shtml` extension, read them, and interpret special
directives embedded in the HTML before sending the result to the
browser.

SSI could, for example, automatically insert the contents of another
file, display a date or other information about a document and, when
enabled by the administrator, even execute a command or invoke a
program.

The model therefore changed slightly:

**browser → HTTP request → Web server → HTML file + SSI processing →
resulting HTML → browser**

The browser still received ordinary HTML. The difference was that the
file stored on disk no longer had to be identical to the document sent
over the network.

This was a very early and simple form of **server-side processing**.

### CGI: a URL could execute a program

The next step was much more powerful. With the **Common Gateway
Interface (CGI)**, an HTTP request could start an actual program on the
server.

CGI was not a programming language. It was an interface between the Web
server and an external program. The server passed request information to
the program through environment variables and, depending on the request
method, standard input. The program executed its logic and wrote the
response to standard output, normally CGI/HTTP headers followed by
HTML.

The program itself could be written in C, Perl, shell, or any other
language available on the system.

The `cgi-bin` directory became the customary place in which these
programs were installed, but it was not an intrinsic requirement of
CGI: the Web server configuration determined which directories or files
could be executed as CGI programs.

On Unix this immediately introduced a question of **permissions**. The
program had to be executable by the user running the Web server, its
location had to be configured for CGI execution, and the program could
only read or modify resources allowed by the Unix permissions under
which it ran.

A URL therefore no longer necessarily identified a document:

**browser → HTTP request → Web server → CGI program → generated HTML →
browser**

What the browser saw was still HTML. But that document might never have
existed as a file.

Internet Force used and developed CGI programs to add interactivity to
websites; some of the surviving scripts and related information are
documented in the [recovered Web software
documentation](../systems/data/web/cgi-and-web-software.en.md).

### PHP/FI: the program enters the page

CGI had a very clear model: the HTML document was one thing, while a
program generating HTML was another.

Almost at the same time, another idea began to emerge: keep the page
looking much like an ordinary HTML document, but embed **instructions to
be executed on the server** directly inside it.

PHP initially began as a collection of CGI programs. In 1995, FI
(*Forms Interpreter*) introduced syntax embedded in HTML; in 1996,
PHP/FI combined those ideas into what was increasingly becoming a
genuine Web scripting language.

Internet Force installed **PHP/FI in March 1996**, initially using it as
CGI. In that model the Web server recognised pages requiring processing
and passed them to the PHP/FI program; the parser executed the embedded
instructions and produced the HTML finally sent to the browser.

The model therefore became:

**browser → Web server → page containing HTML + server-side code →
PHP/FI → resulting HTML → browser**

From the browser's point of view, very little had changed. It still
received HTML. The fundamental transformation happened **beforehand, on
the server**.

The static document was beginning to turn into something resembling a
Web application.

### From CGI to Web-server modules

CGI also had a cost: in its classic model, handling a request required
starting an external process. As applications and traffic grew,
integrating this functionality more tightly with the Web server became
attractive.

Apache, which later replaced NCSA HTTPd at Internet Force, had a
modular architecture. PHP/FI could already be built as an **Apache
module in 1996**: in that configuration the parser was no longer
started as a separate CGI program but ran directly inside the `httpd`
process.

These techniques did not replace one another in a neat sequence.
Static HTML, SSI, CGI and embedded scripting continued to coexist. They
nevertheless illustrate the direction in which the Web was evolving:

**static file → server-parsed document → program generating HTML → code
embedded in the page → logic integrated into the Web server**

Internet Force passed through precisely this transition. Its Web service
began with **NCSA HTTPd** and manually authored HTML pages; CGI programs
were developed when interactivity was needed; **PHP/FI** arrived in
March 1996; NCSA HTTPd was later replaced by **Apache**, and the Web
environment continued evolving towards applications backed by
persistent data.

Within only a few years, the Web server had gone from being primarily a
distributor of files to becoming an environment in which a document
could be assembled, modified or generated at request time. The browser
continued to receive HTML: what was changing radically was what happened
**beforehand, on the server**.

## How Internet Force implemented it

- Pages were edited, uploaded to **DVLP** for testing, then released to **USERS**
  (personal pages) or **DATA** (customer/virtual sites): see
  [Development and DVLP](07-development.en.md).
- The CGI mapping was defined in the NCSA HTTPd configuration (`srm.conf`): the
  script directory and its public alias.
- Permission consistency was maintained by a system script, `fixperms`, which
  restored the correct owner on system binaries and fixed the cases flagged by the
  security checker (Tiger/COPS).
- The third-party CGIs Internet Force actually used are documented in the dedicated
  inventory, with name, version (where known), historical role, local
  configuration/customization and official upstream link.

## Components and hosts

- **DATA** — central web server (`www1.intf.com`), customer and virtual sites.
- **USERS** — user personal pages.
- **DVLP** — content testing before publication.

## Representative evidence

Example from the recovered system script `fixperms`, enforcing the correct owner
on binaries:

```sh
BINDIR="/etc /sbin /usr/bin /usr/etc /usr/lib"
for d in $BINDIR
do
        chown root `find $d \! -perm -4000 -a -perm -0111 -a -type f -print`
        chgrp staff `find $d \! -perm -2000 -a -perm -0111 -a -type f -print`
done
```

→ Complete script: [`systems/firewall/system/fixperms`](../systems/firewall/system/fixperms)
→ Web server CGI configuration:
[`systems/data/web/srm.conf`](../systems/data/web/srm.conf) ·
[`systems/users/system/httpd/srm.conf`](../systems/users/system/httpd/srm.conf)

## Third-party CGIs used by Internet Force

Historical use is documented without redistributing upstream code:

- **Matt Wright — Random Image Displayer** (`advert.cgi`), version 1.2, used for
  Internet Force's random site banners. Matt Wright's terms require permission for
  redistribution, so the source is **not** published; its use and configuration
  are. Official link: <https://www.scriptarchive.com/>.
- Other third-party scripts kept as working copies (`guestbook.cgi`, `ssis.pl`)
  and EFF/Selena Sol material.

Full inventory: [`systems/data/web/cgi-and-web-software.en.md`](../systems/data/web/cgi-and-web-software.en.md).

## Security aspects

Running CGIs as the web-server user, file ownership and account confinement are
covered in [Security](06-security.en.md). In particular the `chroot` /
restricted-shell model and the `ftpusers` list show how Internet Force reduced the
privileges of exposed processes.

## Related original material

- [`systems/data/web/cgi-and-web-software.en.md`](../systems/data/web/cgi-and-web-software.en.md) — CGI inventory.
- [`systems/data/web/scripts/`](../systems/data/web/scripts/README.en.md) — recovered scripts.
- [`systems/firewall/system/fixperms`](../systems/firewall/system/fixperms) — permissions.
- [`docs/05-web-news-ftp.en.md`](05-web-news-ftp.en.md) — web server and virtual hosting.

---

← [Build a POP](00-build-an-isp.en.md) ·
Previous: [Web server](05-web-news-ftp.en.md) ·
Next: [Virtual hosting (VIF)](../systems/sun-vif/README.en.md) →
