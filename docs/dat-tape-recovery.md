🇮🇹 **Italiano** · [🇬🇧 English](dat-tape-recovery.en.md)

# Recuperare nel 2026 un DAT DDS-1 scritto nell'ambiente SunOS

> **Internet Force 1995–1996 Historical Archive**  
> Approfondimento tecnico sul recupero della cassetta DAT sopravvissuta con il backup della workstation `marco`.  
> Autore e curatore dell'archivio: **Marco Iannacone** · https://pippo.com  
> Licenza: [CC BY 4.0](../LICENSE)

Una parte importante dell'archivio Internet Force è riemersa nel 2026 da una singola cassetta DAT conservata per quasi trent'anni. Il nastro conteneva una copia della workstation **`marco`** (che conteneva anche copie di configurazioni dei vari server) ed era stato scritto all'epoca utilizzando un'unità DAT Sun collegata via SCSI al sistema SunOS **DVLP**, impiegato per i backup.

Recuperare i dati non richiedeva necessariamente di ricostruire una workstation Sun originale. Era però necessario risolvere alcuni problemi distinti: compatibilità fisica del supporto DDS, modalità con cui il drive Linux leggeva i record sul nastro, formato dell'archivio creato da GNU `tar` e successiva interpretazione dei singoli file recuperati.

## Il supporto fisico: DDS-1

La cassetta conservata era identificata sull'etichetta come **DDS-1**. Questa informazione era importante nella scelta del lettore: le generazioni DDS successive mantennero una certa compatibilità all'indietro, ma non indefinitamente.

DDS-2 può leggere DDS-1 e DDS-3 può leggere DDS-2 e DDS-1; con DDS-4 la retrocompatibilità con DDS-1 non è più garantita in generale. Per prudenza decisi quindi di cercare un lettore vicino alla generazione del supporto originale, invece di affidarmi a un drive molto più recente.

Durante questa fase utilizzai **DeepSeek** come supporto tecnico per ricostruire le compatibilità fra generazioni DDS e individuare una scelta prudente del drive da noleggiare. L'IA fu usata come ausilio alla ricerca e al troubleshooting, non come fonte dei dati storici recuperati.

Nel 2026 lessi quindi il nastro con un drive DAT USB noleggiato e collegato a una macchina Linux.

## Il formato logico: GNU tar su SunOS

Sui sistemi Sun non utilizzavo soltanto gli strumenti standard forniti con SunOS. Avevo compilato e installato **GNU tar**, che offriva funzionalità più comode, fra cui la possibilità di comprimere direttamente gli archivi con `gzip` usando l'opzione `-z`, per esempio:

```text
gtar -czvf ...
```

Questa informazione si è rivelata utile anche nel recupero del nastro trent'anni dopo.

GNU `tar` organizza l'archivio in blocchi logici da 512 byte raggruppati in record. Nelle versioni dell'epoca il blocking factor predefinito era tipicamente **20**, cioè record da:

```text
20 × 512 = 10.240 byte
```

Il valore poteva essere modificato in compilazione o esplicitamente con l'opzione `-b`, quindi non va considerato una proprietà universale di ogni archivio `tar`. Era però il valore standard tipico di GNU `tar` e costituiva uno dei primi parametri da verificare durante il recupero.

Lo stesso meccanismo di blocking veniva applicato anche agli archivi compressi. GNU `tar` 1.12, contemporaneo a quell'ambiente, documentava inoltre l'uso di `-z` anche con dispositivi fisici come i tape drive.

## Block size e lettura da Linux

Sul lato Linux era necessario distinguere il **blocking factor dell'archivio** dalla **dimensione dei blocchi gestita dal dispositivo a nastro**.

Il driver SCSI tape di Linux  SCSI (anche se collegati via USB tramite il protocollo USB Mass Storage / UAS)  può lavorare in modalità a blocco fisso oppure variabile. Impostando una dimensione pari a zero si richiede, quando supportata dal drive, la modalità **variable block size**:

```text
mt -f /dev/st0 setblk 0
```

In questa modalità il programma che legge il nastro può ricevere i record con la dimensione con cui erano stati originariamente scritti. Se necessario, GNU `tar` può inoltre essere istruito esplicitamente a usare un blocking factor di 20:

```text
tar -xvf /dev/st0 -b 20
```

Per un archivio scritto direttamente in forma compressa con `-z`, il comando equivalente comprende anche la decompressione gzip:

```text
tar -xzvf /dev/st0 -b 20
```

Un errore di lettura non implica quindi automaticamente che il contenuto del nastro sia corrotto. Fra le prime cose da verificare ci sono la compatibilità del drive, la modalità fixed/variable block e il blocking factor usato dall'archivio.

## SPARC, x86 ed endianness

Il fatto che il nastro fosse stato scritto attraverso un drive collegato a un sistema Sun non impediva a Linux di estrarre l'archivio. `tar` conserva i file come sequenze di byte e la struttura dell'archivio è indipendente dall'architettura della CPU che lo legge.

File di testo, sorgenti, script, HTML, configurazioni, posta e documentazione potevano quindi essere recuperati normalmente, salvo problemi separati di codifica o di formati applicativi ormai obsoleti.

La situazione è diversa per i **file binari dipendenti dalla piattaforma**. Un eseguibile SunOS/SPARC non può essere eseguito direttamente su una macchina Linux x86-64 perché utilizza un'altra architettura di CPU e un'altra ABI; non è sufficiente semplicemente “invertire i byte”.

L'endianness può invece diventare rilevante per database, file binari applicativi o strutture serializzate che memorizzavano direttamente valori numerici nel formato nativo della macchina. In questi casi possono servire strumenti specifici, emulatori oppure script di conversione. Durante il recupero ho sviluppato, con assistenza dell'IA, alcuni script e procedure di analisi.

È inoltre importante ricordare che il DAT conteneva il backup della workstation Linux `marco`, ma includeva anche archivi e materiali creati o transitati attraverso l'ambiente Sun **DVLP**. Non tutti i file binari presenti sul nastro appartenevano quindi necessariamente alla stessa piattaforma.

## Un recupero necessariamente imperfetto

La lettura del DAT non produsse un'immagine perfetta e completa della workstation originaria.

Molti file furono recuperati normalmente; altri risultarono vuoti, danneggiati o contenuti in vecchi archivi che non fu possibile ricostruire integralmente. In altri casi sopravvissero soltanto frammenti testuali o binari comunque sufficienti a identificare nomi, configurazioni o strutture.

Non è possibile attribuire retrospettivamente ogni problema a una sola causa. Dopo quasi trent'anni potevano concorrere lo stato fisico del supporto, la compatibilità del drive utilizzato, il modo in cui il nastro era stato scritto, il blocking dei record e lo stato originario dei singoli archivi.

Il DAT va quindi considerato una delle fonti dell'archivio Internet Force, non una fotografia completa dell'infrastruttura. Il suo recupero ha però permesso di riportare alla luce una quantità di materiale che altrimenti sarebbe probabilmente andata definitivamente perduta.

## Riferimenti tecnici

- GNU tar 1.12 manual, *Creating and Reading Compressed Archives*: https://ftp.gnu.org/old-gnu/Manuals/tar-1.12/html_node/tar_120.html
- GNU tar 1.12 manual, blocking e record size: https://ftp.gnu.org/old-gnu/Manuals/tar-1.12/html_mono/tar.html
- Linux `st(4)`, SCSI tape driver e `MTSETBLK`: https://man7.org/linux/man-pages/man4/st.4.html
- HPE, compatibilità DDS-1 / DDS-2 / DDS-3 e rottura della retrocompatibilità con DDS-4: https://support.hpe.com/hpesc/public/docDisplay?docId=ns101.0.12783017.3054776en_us&docLocale=en_US

Per il contesto generale sulla provenienza dei materiali, vedere [Provenienza dell'archivio e recupero dei materiali](archive-provenance.md).
