# vnstat-viewer
vnstat-viewer ist eine php-Anwendung unter Verwendung von `Bootstrap` und `Google Charts`.
Angezeigt wird die Menge des Datenverkehrs an den Netzwerkschnittstellen.
Als Basis wurde [vnstat-dashboard](https://github.com/alexandermarston/vnstat-dashboard) verwendet und Anpassungen für `vnstat` der Version 2.4 vorgenommen.
Funktionsumfang:

* Tabellen und Charts unterschiedlicher Zeiteinheiten
* Selektion der Netzwerkschnittstelle

# Beispiel

![](https://github.com/dalbenknicker/vnstat-viewer/blob/master/example.png)

# Installation
```
$ cd tmp
$ git clone https://github.com/dalbenknicker/vnstat-viewer.git
$ cp -rp vnstat-viewer /srv/http/vnstat/
$ cd /srv/http/vnstat/
$ composer install
```

# Konfiguration
Die angezeigten Namen der Schnittstellen können verändert werden. Bei einer
konfigurierten ssh-Verbindung mit `public key` könnte z.b auch die Statistik
eines entfernten `host` abgerufen werden. Siehe hierzu [include/config.php](https://github.com/dalbenknicker/vnstat-viewer/blob/master/include/config.php)
```
<?php

// einige Debugausgaben
// $DEBUG = 1;
$DEBUG = 0;

// Zeitzone
date_default_timezone_set('Europe/Berlin');

// Auswertung von vnstat für einen entfernten host
// gültige ssh-Verbindung mit public-key
// $vnstat_bin_dir = 'ssh myrouter vnstat --json';
// oder
// $vnstat_bin_dir = "echo userpassword|su -c 'ssh myrouter vnstat --json' username";

//localhost
//$vnstat_bin_dir = '/usr/bin/vnstat --json';

//Namen der angezeigtn Schnittstellen ändern
$iface_doreplace = true;
$iface_replace = [
  
    "enp3s0" => "My WAN",
    "tun0"   => "My VPN",
    "virbr0" => "My Container",
    
];

?>

```





