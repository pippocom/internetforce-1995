[🇮🇹 Italiano](dat-tape-recovery.md) · 🇬🇧 **English**

# Recovering in 2026 a DDS-1 DAT written in a SunOS environment

> **Internet Force 1995–1996 Historical Archive**  
> Technical note on the recovery of the surviving DAT cassette containing the backup of workstation `marco`.  
> Author and archive curator: **Marco Iannacone** · https://pippo.com  
> License: [CC BY 4.0](../LICENSE)

An important part of the Internet Force archive resurfaced in 2026 from a single DAT cassette preserved for almost thirty years. The tape contained a copy of workstation **`marco`** (containing also some copies of server different configurations) and had originally been written using a Sun DAT drive connected by SCSI to the SunOS system **DVLP**, which was used for backups.

Recovering the data did not necessarily require rebuilding an original Sun workstation. It did, however, require solving several distinct problems: physical DDS media compatibility, the way the Linux tape driver read records from the tape, the archive format produced by GNU `tar`, and the later interpretation of individual recovered files.

## The physical medium: DDS-1

The surviving cassette was labelled **DDS-1**. This mattered when choosing a reader: later DDS generations retained some backward compatibility, but not indefinitely.

DDS-2 can read DDS-1 and DDS-3 can read DDS-2 and DDS-1; with DDS-4, backward compatibility with DDS-1 is no longer generally guaranteed. As a precaution, I therefore looked for a drive close to the generation of the original medium rather than relying on a much newer device.

During this stage I used **DeepSeek** as a technical aid to reconstruct DDS-generation compatibility and identify a cautious choice of drive to rent. AI was used to support research and troubleshooting, not as a source of the recovered historical data.

In 2026 the tape was therefore read with a rented USB DAT drive connected to a Linux machine.

## The logical format: GNU tar on SunOS

On the Sun systems I did not rely only on the tools supplied with SunOS. I had compiled and installed **GNU tar**, which provided more convenient features, including direct `gzip` compression through the `-z` option, for example:

```text
gtar -czvf ...
```

This detail also became useful when recovering the tape thirty years later.

GNU `tar` organises an archive into 512-byte logical blocks grouped into records. In versions from that period the default blocking factor was typically **20**, corresponding to records of:

```text
20 × 512 = 10,240 bytes
```

The value could be changed at build time or explicitly with the `-b` option, so it should not be treated as a universal property of every `tar` archive. It was, however, GNU `tar`'s typical default and one of the first parameters worth checking during recovery.

The same blocking mechanism also applied to compressed archives. GNU `tar` 1.12, contemporary with this environment, also documented use of `-z` with physical devices such as tape drives.

## Block size and reading under Linux

On Linux it was necessary to distinguish the archive's **blocking factor** from the **block size handled by the tape device**.

The Linux SCSI tape driver  SCSI (even when connected vvia USB with USB Mass Storage / UAS protocol)  can operate in fixed- or variable-block mode. Setting the block size to zero requests **variable block size** mode when supported by the drive:

```text
mt -f /dev/st0 setblk 0
```

In this mode the application reading the tape can receive records with the size in which they were originally written. If necessary, GNU `tar` can also be explicitly told to use a blocking factor of 20:

```text
tar -xvf /dev/st0 -b 20
```

For an archive written directly in compressed form with `-z`, the equivalent command also includes gzip decompression:

```text
tar -xzvf /dev/st0 -b 20
```

A read error therefore does not automatically mean that the tape contents are corrupt. Among the first things to check are drive compatibility, fixed/variable block mode and the archive's blocking factor.

## SPARC, x86 and endianness

The fact that the tape had been written through a drive attached to a Sun system did not prevent Linux from extracting the archive. `tar` stores files as byte sequences and the archive structure is independent of the CPU architecture reading it.

Text files, source code, scripts, HTML, configuration files, mail and documentation could therefore be recovered normally, apart from separate issues such as character encoding or obsolete application formats.

The situation is different for **platform-dependent binary files**. A SunOS/SPARC executable cannot run directly on a Linux x86-64 machine because it targets a different CPU architecture and ABI; simply “swapping the bytes” would not make it executable.

Endianness can instead matter for databases, application binary files or serialised structures that stored numeric values directly in the machine's native representation. In those cases, dedicated tools, emulators or conversion scripts may be required. Some analysis scripts and procedures used during recovery were developed with AI assistance.

It is also important to remember that the DAT contained the backup of the Linux workstation `marco`, but also included archives and material created on or passed through the Sun **DVLP** environment. Binary files on the tape did not therefore necessarily all belong to the same platform.

## An inevitably imperfect recovery

Reading the DAT did not produce a perfect and complete image of the original workstation.

Many files were recovered normally; others were empty, damaged, or stored inside old archives that could not be completely reconstructed. In some cases only textual or binary fragments survived, while still preserving enough information to identify names, configurations or structures.

It is not possible to assign every problem retrospectively to a single cause. After almost thirty years, the physical condition of the medium, drive compatibility, the original writing process, record blocking and the state of individual archives may all have contributed.

The DAT should therefore be regarded as one source within the Internet Force archive rather than a complete image of the infrastructure. Its recovery nevertheless brought back a substantial body of material that would otherwise probably have been lost permanently.

## Technical references

- GNU tar 1.12 manual, *Creating and Reading Compressed Archives*: https://ftp.gnu.org/old-gnu/Manuals/tar-1.12/html_node/tar_120.html
- GNU tar 1.12 manual, blocking and record size: https://ftp.gnu.org/old-gnu/Manuals/tar-1.12/html_mono/tar.html
- Linux `st(4)`, SCSI tape driver and `MTSETBLK`: https://man7.org/linux/man-pages/man4/st.4.html
- HPE, DDS-1 / DDS-2 / DDS-3 compatibility and the break in backward compatibility with DDS-4: https://support.hpe.com/hpesc/public/docDisplay?docId=ns101.0.12783017.3054776en_us&docLocale=en_US

For the broader provenance context, see [Archive provenance and material recovery](archive-provenance.en.md).
