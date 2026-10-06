🇮🇹 **Italiano** · [🇬🇧 English](10-authentication-tacacs.en.md)

# Autenticazione (XTACACS)

> **Internet Force 1995–1996 Historical Archive**
> Ricostruzione e documentazione tecnica basate sui materiali originali Internet Force conservati da Marco Iannacone.
> Autore e curatore dell'archivio: Marco Iannacone · https://pippo.com
> Licenza: [CC BY 4.0](../LICENSE)

Ogni cliente dial-up, in ogni POP, era autenticato da un unico servizio centrale
su USERS invece che da account locali su ciascun access server. È ciò che
rendeva praticabile il dial-up distribuito: un account cliente funzionava su
qualsiasi POP, e aggiungere un POP non significava copiare utenti o password in
giro.

## Il demone

USERS eseguiva **XTACACS**, un'implementazione estesa di TACACS. Il demone
(`xtacacsd`, revisione 3.4, compilato nel 1995) era avviato al boot:

```
/etc/xtacacsd -ls
```

Il servizio TACACS di base era sulla porta UDP 49. Le opzioni `-l` e `-s`
abilitavano logging e supporto accounting aggiuntivi. Il demone validava nomi
utente e password contro il database degli account su USERS e decideva, per
utente e per host, se la sessione era permessa.

Il file di configurazione definiva policy globale e regole per gruppo - per
esempio una policy di password predefinita, se le password vuote erano
permesse, se era richiesto un controllo del name server, e regole come "l'utente
può fare login da qualsiasi host" o "questo gruppo può fare login da questi
dispositivi". Questo dava all'amministratore un unico posto dove esprimere la
policy di accesso per l'intero parco modem.

## Il lato access server

Ogni access server Cisco era configurato in modo identico rispetto
all'autenticazione. Le righe rilevanti erano:

```
tacacs-server host 206.20.95.4
tacacs-server extended
tacacs-server authenticate connections
tacacs-server authenticate slip always
tacacs-server notify connections
tacacs-server notify enable
tacacs-server notify logout
tacacs-server notify slip
```

Lette nel loro insieme, queste impostazioni dicevano all'access server di:

- usare il server XTACACS su USERS (`206.20.95.4`) con il protocollo esteso;
- richiedere l'autenticazione per le connessioni in ingresso e per SLIP;
- notificare al server l'inizio delle connessioni, gli enable, i logout e le
  sessioni SLIP, il che produceva la traccia di accounting.

Le linee dial-up stesse erano marcate `login tacacs`, così il chiamante era
autenticato prima che la linea consegnasse una sessione.

## Accounting

XTACACS faceva più della semplice autenticazione sì/no. Manteneva record di
login per ogni Cisco, così il comando UNIX standard `last` poteva produrre
report di connessione, e un helper dedicato all'accounting dial-up
(`xacctd_user`) girava su USERS accanto al demone. Insieme alle impostazioni
`notify` di cui sopra, questo dava un record per sessione di chi si era
collegato, quando e da quale access server - la base per l'accounting dei
clienti e per la pianificazione della capacità dei banchi modem.

## Rapporto con il resto del sistema

- **Provisioning:** un nuovo account cliente creato dagli strumenti di
  provisioning su USERS era immediatamente utilizzabile su ogni POP. Vedi
  [Provisioning dei clienti](12-customer-provisioning.md).
- **Firewall:** la regola 7 della policy FireWall-1 (`ts -> users : tacacs`)
  permetteva agli access server di raggiungere USERS per l'autenticazione.
- **Flusso dial-up:** l'autenticazione è lo step 4 della
  [sessione dial-up](02-dialup-session.md).

In seguito, con la crescita del servizio nel 1996, i POP più nuovi seguirono lo
stesso modello; il POP CNN fu l'eccezione che conferma la regola - inizialmente
puntava a un indirizzo di autenticazione locale prima che il disegno
centralizzato fosse ripristinato.

---

Vedi anche: [Server USERS](../systems/users/README.md) ·
[La sessione dial-up](02-dialup-session.md)

---

→ [Costruire un Internet Force POP, passo per passo](00-build-an-isp.md)
