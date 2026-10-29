[🇮🇹 Italiano](archive-provenance.md) · 🇬🇧 **English**

# Archive provenance and material recovery

> **Internet Force 1995–1996 Historical Archive**\
> Historical reconstruction and technical documentation based on original Internet Force materials preserved by Marco Iannacone.\
> Author and archive curator: **Marco Iannacone** · https://pippo.com
> License: [CC BY 4.0](../LICENSE)

The repository does not originate from one complete backup of the Internet Force infrastructure. It has been reconstructed by Marco from surviving material recovered progressively from several sources.

This provenance explains why some groups of files are unusually complete while others are fragmentary.

## Internet Force operational backups

Internet Force used a DAT drive attached to **DVLP** for system tape backups. The tapes used for those procedures belonged to the company and remained with Internet Force; they are not part of the archive available today.

Recovered documentation nevertheless preserves traces of the procedures themselves, including references to `gtar`, `dump` and DVLP as an operational point for tape backups.

## The DAT cassette that “remained”

One separate DAT cassette had "remained" with me; it contained a copy of my **`marco`** workstation made at the time, and the cassette survived for almost
thirty years. The original tape had been written with a Sun DAT drive connected
by SCSI to **DVLP**, the SunOS system used for backups.

In 2026 I read the cassette with a USB DAT drive I had rented, connected to a Linux machine.
I extracted the content with `tar`, also using `gzip` where I needed to identify or verify the compression. Recovery produced substantial additional
material: configuration copies, documentation, mail, source code, utilities and
personal working files that were absent from the first archive set.

For technical details on DDS drive selection, the historical use of **GNU tar** on SunOS, record blocking and reading the tape under Linux, see [Recovering in 2026 a DDS-1 DAT written in a SunOS environment](dat-tape-recovery.en.md).

## Incomplete recovery

Part of the DAT content consists of `tar` archives created on the Sun **DVLP** system or otherwise processed through that environment.

The recovery results were mixed: some files extracted normally, some are
zero-byte, and some appear as `.tar.Z` archives that could no longer be opened;
in some cases the material emerged only as damaged binary or text blobs, or with
unhelpful names.

To interpret these fragments — headers, strings and possible file structures —
I sometimes used **DeepSeek** through **OpenCode** as an aid. The AI-assisted
interpretation was used to understand and identify what had been recovered, decode and convert to readable format or extract partial surviving files.
It was never used to silently fabricate missing historical files.

The exact cause has not yet been established. It may involve media condition, the original writing process, the `tar` implementation/variant used at the time, a partial incompatibility of the rented DAT, or a combination of factors. The repository therefore does not attribute the problem to one specific software incompatibility.

## Interpreting missing files

An important consequence is:

> **the absence of a file from the recovered archive does not imply that the file never existed.**

Incomplete directories, zero-byte entries and partial trees may still preserve useful information about original names, structure and workflow.

Where useful, a note may describe the state of a file - fully recovered, only partly recovered, truncated or unreadable - to guide the reader. That describes what survived, not the historical value of the document.

## Material preserved by other participants

The archive also continues to grow through original material preserved by people who took part in Internet Force. In 2026 **Pascal Schait**, a founding shareholder of the company, supplied two additional surviving items:

- the **Business Price List dated 15 June 1996**, documenting the commercial offer for connectivity, static IP and LAN services, domains, DNS, Web-page production and hosting;
- photographs of the **original Welcome Kit v1.0 packaging**, including the box, manual and physical floppies.

These materials are preserved respectively under
[`artifacts/company/business-services-price-list-1996/`](../artifacts/company/business-services-price-list-1996/README.en.md)
and [`artifacts/customer-welcome-kit/`](../artifacts/customer-welcome-kit/README.en.md).

## An evolving archive

The 2026 DAT recovery and the appearance of additional material preserved by people involved at the time explain why new artifacts continue to be added after the initial reconstruction. Each new item is compared with the other sources and integrated with its provenance recorded.

For the partial Hypertxt source copies found on workstation `marco`, see [Hypertxt source provenance](../systems/marco/hypertxt/PROVENANCE.en.md).

## The Codemotion article and repository

In October 2026 Marco Iannacone published the Codemotion article
[*The Archaeology of an ISP: How an Internet Provider Really Worked in 1995*](../publications/codemotion-2026/README.en.md)
together with the Internet Force 1995–1996 repository and the reconstruction data. The article describes the recovery of the archive and operation of the infrastructure; a digital copy of the Italian edition is preserved in the repository together with links to the Codemotion editions.

## Reconstruction inputs

For this reconstruction I reorganised material that came from several input archives into the repository; the original wrappers are not published. I drafted the technical guides by comparing them against the files in my private reference archive, which is not published.
