<?php

$DEBUG = 1;

define ('MINTYP',  0);
define ('HOURTYP', 1);
define ('DAYTYP',  2);
define ('MONTYP',  3);
define ('YEARTYP', 4);
define ('TOPTYP',  5);

date_default_timezone_set('Europe/Berlin');

$vnstat_version = "1.0";
//$vnstat_bin_dir = '/usr/bin/vnstat';
$vnstat_bin_dir = 'ssh router vnstat';

$iface_doreplace = true;
$iface_replace = [
  
    "enp3s0" => "My WAN",
    "tun0"   => "My VPN",
    "virbr0" => "My Container",
    
];

?>
