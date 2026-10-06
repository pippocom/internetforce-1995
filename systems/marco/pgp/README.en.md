[🇮🇹 Italiano](README.md) · 🇬🇧 **English**

# PGP on workstation `marco`

> **Internet Force 1995–1996 Historical Archive**
> Historical reconstruction and technical documentation based on original Internet Force materials preserved by Marco Iannacone.
> Author and archive curator: Marco Iannacone · https://pippo.com
> License: [CC BY 4.0](../../../LICENSE)

This directory preserves the PGP public keyring recovered from workstation
`marco` and the historical PGP 2.6.3i package.

## Context

PGP was part of **Marco Iannacone's personal security practice before
Internet Force** and continued to be used during Internet Force. The public keyring
recovered from Linux workstation `marco` contains two personal public keys
created in 1995:

```text
1995-09-17  RSA 768 bit   Marco Iannacone (ianna@iol.it)
1995-10-11  RSA 1024 bit  Marco Iannacone (ianna@internetforce.com>
```

The first user ID documents PGP use with the **Italia On Line** account that
preceded the Internet Force identity; the second documents a key associated with
the Internet Force address. The user ID is preserved exactly as it appears in the
historical keyring, including the mismatched closing character.

A `pippo.com` identity was later added, but **this particular keyring snapshot
does not contain it**: the artifact documents an earlier stage of that evolution.

## Why it matters

PGP was not an Internet Force service: it was personal software on the
administrator's workstation, and its use was **continuous** - it began before
Internet Force and continued during Internet Force. The keyring is preserved because it contains **public keys only**: a public key
is not a secret, and no secret keyring is included.

## PGP 2.6.3i package

The repository also preserves the historical **PGP 2.6.3i** package (18 January
1996, based on MIT PGP 2.6.2 and modified for international use):
[`pgp263is.tar`](pgp263is.tar). The package contains `readme.1st`, `readme.usa`,
`setup.doc`, `pgp263ii.tar` and `pgp263ii.asc`. It is **third-party historical
software**, with its own original licence.

## Files

- `PUBRING.PGP` — original recovered PGP public keyring (public keys only).
- `KEYRING_METADATA.tsv` — modern metadata extraction for readability.
- `pgp263is.tar` — historical PGP 2.6.3i package.

## Where it belongs

PGP was part of the `marco` workstation environment; see
[Marco's workstation](../README.md),
[Development and DVLP](../../../docs/07-development.en.md) and
[Historical notes](../../../docs/09-historical-notes.en.md).
