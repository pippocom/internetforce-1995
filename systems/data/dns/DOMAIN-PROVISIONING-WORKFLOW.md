🇮🇹 **Italiano** · [🇬🇧 English](DOMAIN-PROVISIONING-WORKFLOW.en.md)

# Aggiungere un nuovo dominio cliente (workflow)

> **Internet Force 1995–1996 Historical Archive**
> Ricostruzione e documentazione tecnica basate sui materiali originali Internet Force conservati da Marco Iannacone.
> Autore e curatore dell'archivio: Marco Iannacone · https://pippo.com
> Licenza: [CC BY 4.0](../../../LICENSE)

> **Documento moderno.** Questa è una spiegazione didattica, non un file
> storico. La sequenza operativa deriva dal HOWTO originale recuperato
> [`new_dns-HOWTO.txt`](new_dns-HOWTO.txt), conservato qui accanto come
> artefatto **ORIGINALE**. Dove utile sono riportati brevi estratti originali.

Questo workflow descrive come Internet Force trasformava un nuovo dominio
cliente in un sito realmente servito: dalla registrazione/delega fino al
`VirtualHost` di NCSA e al test finale. È lo stesso percorso dei documenti
[DNS](../../../docs/03-dns.md) e
[Web, FTP, news e mailing list](../../../docs/05-web-news-ftp.md), ma visto dal
punto di vista di chi doveva eseguirlo.

Il modello è quello descritto in
[VIF su SunOS](../../sun-vif/README.md): con HTTP/1.0 ogni sito aveva bisogno
del proprio indirizzo IP, che la Sun doveva possedere tramite le interfacce
virtuali VIF.

## 1. Registrare e delegare il dominio

Un dominio non esiste per Internet finché non è registrato e delegato. Il HOWTO
originale non documenta la pratica di registrazione, che è descritta in
[Registrazione domini InterNIC/GARR](../../../artifacts/domain-registration/README.md):
per `.com` la registrazione avveniva tramite InterNIC, per `.it` secondo la
struttura gestita tramite GARR. Solo dopo la delega le query per il dominio
possono arrivare ai nameserver Internet Force.

## 2. Rendere Internet Force autoritativo

Internet Force ospitava il dominio sui propri nameserver BIND-4. Il file di zona
si costruiva a partire da un file sorgente (`.source`) del dominio. Il HOWTO
originale mostrava il caso `canalemoda.source`:

```text
@  IN   SOA     canalemoda.com dnsmaster.internetforce.com. (
                1996041801       ; Serial
                10800            ; Refresh 3 hours
                3600             ; Retry 1 hour
                604800           ; Expire after a week
                86400 )  ; Minimum ttl 1 day
                                NS      harley.ios.com.
                                NS      users.internetforce.com

>E www                  A       206.20.95.20
localhost               A       127.0.0.1
```

Il record `NS` verso il server di registrazione (`harley.ios.com`) e quello
verso `users.internetforce.com` dichiarano chi risponde per il dominio; il
record `www` associa il nome al futuro indirizzo IP del sito. La struttura e la
sintassi delle zone sono spiegate in [DNS](../../../docs/03-dns.md).

## 3. Aggiornare `named.boot`

Il dominio doveva essere dichiarato nel file di boot di BIND-4, per esempio:

```text
primary   canalemoda.com                        primary/canalemoda.com
```

Il `named.boot` recuperato è in [`named.boot`](named.boot).

## 4. Generare la zona

Le zone non si scrivevano a mano: si generavano dal sorgente con
`makezones` e il `Makefile` del flusso DNS (vedi
[`named-data/Makefile`](named-data/Makefile)), aggiungendo la nuova regola di
generazione. Il HOWTO originale documenta anche gli errori tipici, per esempio
l'obbligo di usare TAB nel `Makefile`.

## 5. Scegliere l'indirizzo IP del sito

A ogni sito ospitato corrispondeva un indirizzo dedicato (per esempio
`206.20.95.20`). La mappa completa degli indirizzi virtuali è visibile nella
zona inversa [`db.206.20.95`](named-data/primary/db.206.20.95).

## 6. Assicurarsi che l'indirizzo esista sulla Sun (VIF)

L'indirizzo doveva esistere realmente sulla macchina web. Il HOWTO originale
ricorda di usare `ifconfig le0` per leggere l'indirizzo Ethernet fisico della
Sun (`users: 8:0:20:74:ff:4f`, `data: 8:0:20:77:cb:64`), necessario al
published ARP delle interfacce VIF. Il funzionamento completo è descritto in
[VIF su SunOS](../../sun-vif/README.md).

## 7. Instradare il nuovo indirizzo sul firewall

Poiché DATA e USERS stavano dietro interfacce separate di FireWall-1, il nuovo
indirizzo doveva essere instradato verso il segmento giusto. Il HOWTO originale
mostra l'aggiunta in `rc.route`:

```text
ifconfig qe0 fw-data netmask 255.255.255.192
route delete intfnet fw-data
route add host data fw-data 0
route add host 206.20.95.20 fw-data 0
```

La configurazione pubblica di riferimento è
[`../../firewall/network/rc.route`](../../firewall/network/rc.route).

## 8. Aggiornare la reverse DNS (PTR)

Il HOWTO originale aggiunge il PTR nel sorgente `internetforce.source`:

```text
; PTR record (added by marco following yogo's suggestion)
20.95.20.206    PTR     www.canalemoda.com.
```

Il PTR rende il nome risolvibile a partire dall'indirizzo; la zona inversa è
[`db.206.20.95`](named-data/primary/db.206.20.95).

## 9. Configurare il `VirtualHost` di NCSA

Infine NCSA HTTPd associa l'indirizzo al sito con un blocco `VirtualHost`, per
esempio:

```text
<VirtualHost 206.20.95.20>
ServerName www.canalemoda.com
DocumentRoot /usr/local/etc/httpd/htdocs/cmoda/
</VirtualHost>
```

La configurazione completa è in
[`../web/httpd.conf`](../web/httpd.conf), spiegata in
[Web, FTP, news e mailing list](../../../docs/05-web-news-ftp.md).

## 10. Testare

Il HOWTO originale testa la generazione delle zone (`makezones`) e ricarica
`named` con `kill -HUP`. In termini moderni il controllo finale era: la zona si
genera senza errori, `named` ricarica, il nome risolve all'indirizzo scelto, il
firewall instrada quell'indirizzo e il `VirtualHost` serve il `DocumentRoot`
corretto.

---

Vedi anche: [DNS](../../../docs/03-dns.md) ·
[Web, FTP, news e mailing list](../../../docs/05-web-news-ftp.md) ·
[VIF su SunOS](../../sun-vif/README.md) ·
HOWTO originale [`new_dns-HOWTO.txt`](new_dns-HOWTO.txt)
