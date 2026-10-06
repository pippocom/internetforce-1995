🇮🇹 **Italiano** · [🇬🇧 English](BACKUP.en.md)

# DVLP e i backup su DAT

> **Internet Force 1995–1996 Historical Archive**\
> Ricostruzione e documentazione tecnica basate sui materiali originali Internet Force conservati da Marco Iannacone.\
> Autore e curatore dell’archivio: **Marco Iannacone** · https://pippo.com
> Licenza: [CC BY 4.0](../../LICENSE)


DVLP non era soltanto il server di sviluppo. Aveva anche un ruolo operativo nelle procedure di backup Internet Force.

A DVLP era collegata un’unità **DAT** utilizzata per le copie su nastro dei sistemi. La documentazione recuperata conserva procedure basate su strumenti Unix come `gtar` e `dump`.

Questo rende DVLP un punto interessante dell’architettura: sviluppo, conservazione delle configurazioni e backup su nastro convergevano sulla stessa macchina, pur mantenendo separati i servizi di produzione.

Il dispositivo era `/dev/rst0` (o `/dev/nrst0` per accodare senza riavvolgere);
i comandi completi (`gtar`/`dd`, `dump`, ripristino) sono in
[Operazioni e backup](../../docs/14-operations-and-backup.md). Il **modello
esatto del drive** e la **frequenza/rotazione** dei backup non sono registrati
nel materiale recuperato: resta una lacuna nota, non una procedura da inventare.

I nastri operativi appartenevano a Internet Force e non sono oggi disponibili nell’archivio.

Per il quadro completo vedere:

- [Operazioni e backup](../../docs/14-operations-and-backup.md)
- [Provenienza dell’archivio](../../docs/archive-provenance.md)
