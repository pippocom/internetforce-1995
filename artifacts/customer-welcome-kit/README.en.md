[🇮🇹 Italiano](README.md) · 🇬🇧 **English**

# Customer Welcome Kit

> **Internet Force 1995--1996 Historical Archive**\
> Historical reconstruction and technical documentation based on
> original Internet Force materials preserved by **Marco Iannacone**.\
> Author and archive curator: **Marco Iannacone** · https://pippo.com\
> License: [CC BY 4.0](../../LICENSE), with the exception for
> third-party software contained in the Welcome Kit described in the
> project license.

This directory brings together the original material of the **Internet Force
Welcome Kit**: the connection KIT distributed to customers, made up of 4 floppies,
the manual and the source code of the application and of the installation program.

## Structure

| Path | Contents |
|---|---|
| `floppy-images/` | the four Welcome Kit floppy images, the Windows 95 disk and `LEGGIMI.TXT` |
| `manual/` | `MANUALE_UTENTE_INTERNETFORCE.PDF`, 33 pages, produced on 18 March 1996 with Acrobat Distiller 1.0 for Macintosh; here too there is a real example of **Trumpet Winsock** configuration instructions for a customer (`trumpet_config-HOWTO_for_maoz.doc`) |
| `source/` | the application source (Visual Basic) and the development material of the installation program |

## Original distribution media

`DISK1.IMA` through `DISK4.IMA` are the original Welcome Kit media.
`WIN95.IMA` preserves the additional Windows 95 support disk. They are
historical FAT12 images and are kept unmodified.

## Development and sources

The Welcome Kit was developed by **Marco Iannacone** for Internet Force as an
**additional consultancy activity** alongside his ordinary role as
system/network administrator. Before that project Marco had not used **Visual
Basic**: he learned it specifically to build the Welcome Kit.

The [`source/`](source/README.en.md) directory preserves the application source
- including the `.FRM`, `.FRX`, `.BAS` and `.MAK` files of Easy! and of the
installation program - and the installer-related material, with some earlier
versions collected in `source/OLD_VER2/`. It therefore also offers a concrete
glimpse of how a small Windows/Visual Basic application was developed and
distributed in the 1990s.

## Easy!

The program had been called **Easy!** and had been designed and built by
**Marco Iannacone** as indicated in the files, with graphics
by Salvatore. Easy! provided Internet Force customers with a
launcher/interface for the Internet tools installed by the Welcome Kit.

The sources also preserve the setup program, which handled multi-disk
installation, directory creation, payload decompression and creation of
the Internet Force group in Windows Program Manager.

Files with extensions such as `.EX_`, `.DL_` and `.HL_` may be
Microsoft-compressed installation files. For example, `EUDORA.EX_`
contains an SZDD header and is not a missing executable.

## Third-party software

The Welcome Kit contains third-party software from the period, including Netscape and Eudora.
Preservation as historical material does not relicense those components
under CC BY 4.0; their original copyrights and licenses remain
applicable.
