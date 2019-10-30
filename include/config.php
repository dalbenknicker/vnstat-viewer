<?php

// Ausgabe von einigen Debugausgaben mit mylog("Message"))
$DEBUG = 0;

// Zeitzone
date_default_timezone_set('Europe/Berlin');

// Auswertung von vstat für einen entfernten host
// gültige ssh-Verbindung mit public-key
// $vnstat_bin_dir = 'ssh myrouter vnstat';
// default localhost
$vnstat_bin_dir = '/usr/bin/vnstat';

// Anzeige der Schnittstellennamen ändern
$iface_doreplace = true;
$iface_replace = [
  
    "enp3s0" => "My WAN",
    "tun0"   => "My VPN",
    "virbr0" => "My Container",
    
];

?>
