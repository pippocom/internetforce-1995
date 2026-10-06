🇮🇹 **Italiano** · [🇬🇧 English](README.en.md)

# VIF — Virtual Interface per SunOS 4.x

> **Internet Force 1995–1996 Historical Archive**\
> Componente storico di sistema usato per aggiungere più indirizzi IP alle Sun
> con SunOS 4.1.x. Il bundle fu fornito a Marco Iannacone da Yahel Ben-David /
> Xpert UNIX Systems durante il lavoro su Internet Force.

## Perché questo materiale è qui

Internet Force doveva ospitare più siti Web su una sola macchina fisica.

Con HTTP/1.0 il virtual hosting affidabile richiedeva normalmente un IP
differente per ogni sito. SunOS 4.1.3/4.1.4 non offriva nativamente il modello
di IP aliasing che sarebbe poi apparso in Solaris 2.x.

Il pacchetto **VIF (Virtual Interface)** aggiungeva pseudo-interfacce di rete
al kernel:

```text
le0      Ethernet fisica
vif0     indirizzo virtuale
vif1     indirizzo virtuale
vif2     indirizzo virtuale
...
```

La versione 1.10 inclusa nel bundle era caricabile e scaricabile
dinamicamente su SunOS 4.1.3/4.1.4 mediante `modload`.

Il componente non è soltanto un reperto software: è parte della catena
operativa che rendeva possibile il virtual hosting Internet Force.

## Provenienza

La provenienza del bundle Internet Force è la seguente:

```text
Yahel Ben-David / Xpert UNIX Systems
             ↓
       Marco Iannacone
             ↓
        Internetforce
```

All'interno del pacchetto il codice documenta una genealogia precedente,
che parte dal lavoro di John Ioannidis e passa attraverso contributi pubblici
su mailing list, Usenet e FTP.

Vedi anche: [VIF e l'evoluzione della rete](../../docs/09-historical-notes.VIF-NETWORK-EVOLUTION.md).

## File conservati

I file tecnici del bundle sono in `source/`:

```text
source/VIF-1_10.GZ
source/VIF-1_01.GZ
source/VIF_MAN.GZ
source/VIF-INFO.TXT
source/IF_VIF.C
source/VIF.RC
source/VIF.HTM
source/NCSA.HTM
source/NCSA_PAT.Z
source/VIRTUAL-.HTM
```

Mantengono i timestamp e i formati storici del 1995.

## Contenuto del bundle

### `VIF-1_10.GZ`

Archivio VIF 1.10.

Contiene:

```text
CHANGES
INSTALL
INSTALL.ultrix
MANIFEST
Makefile.hp
Makefile.sun
README
README.ji
if_vif.c
ifalias_hpux10.c
master.add
vif_exec
vif.h
wrapper.c
```

Il README attribuisce il codice originale a **John Ioannidis** e la versione
distribuita a **Steinar Haug**.

La 1.10 dichiara supporto/test per:

```text
SunOS 4.1.3       sun4c
SunOS 4.1.3_U1    sun4m
SunOS 4.1.4       sun4m
HP-UX 9.05        HP 700
```

e riporta port/contributi anche per HP-UX e Ultrix.

SHA-256 del file interno:

```text
3046c574766ce06711d2b0c82169efec5663b832eab3dd7620423c0307f65b1e
```

### `VIF-1_01.GZ`

Versione precedente del pacchetto, 1.01, datata nel changelog 27 marzo 1995.

È utile per seguire l'evoluzione del codice fino alla 1.10.

### `VIF_MAN.GZ`

Archivio di documentazione/storia tecnica contenente:

```text
kernel.mods.sunos.txt
mip.txt
mip2.txt
```

Non è una semplice man page.

Conserva messaggi, forward e materiale tecnico che documentano come il codice
e le conoscenze associate circolassero in rete.

SHA-256:

```text
cc9e0dd3c7ca0fc98839873d95a0eb5b6dde46bcc380280d270d999e329c7ee2
```

### `VIF-INFO.TXT`

Versione condensata della spiegazione tecnica attribuita a John Ioannidis,
con correzioni per SunOS 4.1.x accreditate a Chuck Smoko e raccolte da
Bob Baggerman.

Descrive:

- il problema dei molti IP su una sola interfaccia;
- configurazione `vif0`, `vif1`, ...;
- host route;
- published ARP;
- integrazione originaria nel kernel BSD/SunOS.

### `IF_VIF.C`

Snapshot del sorgente C del driver Virtual Interface.

È codice kernel, non una utility user-space.

### `VIF.RC`

Script shell operativo che automatizza:

```text
modload del modulo
creazione /dev/vif
attach delle VIF
lettura del MAC di le0
ifconfig vifN
correzione delle route
published ARP
netstat finale
```

Il file recuperato contiene nomi placeholder e va quindi letto come script
di configurazione/modello, non come elenco degli indirizzi di produzione
Internet Force.

SHA-256:

```text
84fba75041cd977009c66863ec234adb0ab93ed430fdbcbdc9e1b0ba1401dcb0
```

### `VIF.HTM`

Istruzioni pratiche "VIF for SunOS 4.x".

Mostra un percorso estremamente concreto:

```text
compila if_vif.c
      ↓
crea vif.o
      ↓
adatta vif.rc
      ↓
installa vif.o + vif.rc
      ↓
richiama vif.rc da /etc/rc.local
```

È particolarmente utile per la documentazione narrativa perché rende visibile
come un amministratore installava davvero questa capacità sul sistema.

### `NCSA.HTM`

Documento di A. P. Barrett, 10 novembre 1994, sulle modifiche a NCSA HTTPd
1.3 per server multipli su host multihomed.

Descrive due funzioni:

```text
BindAddress
VirtualHost
```

e spiega come `VirtualHost` scelga configurazione e `DocumentRoot` in base
all'indirizzo locale che ha ricevuto la connessione.

### `NCSA_PAT.Z`

Archivio compresso contenente sorgenti NCSA HTTPd con supporto:

```text
APB_BIND_ADDRESS
APB_VIRTUAL_HOST
```

SHA-256:

```text
b9a9a05c9759e2a8d82817914e06e799aacb156fc201b910da5cb83be339cd86
```

### `VIRTUAL-.HTM`

Documentazione Apache sul virtual hosting.

Spiega esplicitamente che, a causa delle limitazioni HTTP/1.0, il server
deve avere un IP differente per ciascun virtual host e cita le virtual
interfaces come soluzione sui sistemi operativi che le supportano.

Questo file collega bene il problema di rete al problema Web.

## Installazione SunOS documentata nel bundle

Il flusso della versione 1.10 è:

```text
Makefile.sun
    ↓
if_vif.c + wrapper.c
    ↓
vif.o
    ↓
modload
    ↓
/dev/vif
    ↓
attach delle pseudo-interfacce
    ↓
ifconfig vifN <IP>
    ↓
host route
    ↓
published ARP
```

Il `Makefile.sun` usa:

```make
CFLAGS = -O -DDETACH -DKERNEL -DINET -D`arch -k`
```

e il target di installazione:

```make
modload vif.o -entry _vif_vdcmd -exec `pwd`/vif_exec
```

Il driver entra quindi effettivamente nel kernel SunOS.

## Relazione con Internet Force

Il pacchetto spiega il pezzo che mancava fra:

```text
DNS
→ www.pippo.com = 206.20.95.25
```

e:

```text
NCSA HTTPd
→ <VirtualHost 206.20.95.25>
```

VIF permetteva alla Sun di **possedere realmente** quell'indirizzo pur avendo
una sola Ethernet fisica.

La catena completa era:

```text
DNS
 ↓
IP dedicato al sito
 ↓
routing del firewall
 ↓
VIF sulla Sun
 ↓
NCSA VirtualHost
 ↓
DocumentRoot del sito
```

## Nota

Il bundle è materiale storico di terze parti/Xpert conservato come parte
dell'archivio tecnico Internet Force. I file in `source/` sono conservati come
recuperati; eventuali spiegazioni o correzioni stanno in questo README.
