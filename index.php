<?php

$vnstat_version = "1.0";

define ('MINTYP',  0);
define ('HOURTYP', 1);
define ('DAYTYP',  2);
define ('MONTYP',  3);
define ('YEARTYP', 4);
define ('TOPTYP',  5);

require __DIR__ . '/vendor/autoload.php';
require __DIR__ . '/include/config.php';
require __DIR__ . '/include/util.php';
require __DIR__ . '/include/vnstat.php';

$smarty = new Smarty;

$smarty->template_dir = 'templates';
$smarty->compile_dir  = 'tmp';

$vnstat = new vnstat($vnstat_bin_dir);

mylog("List Interfaces...");
foreach ($vnstat->GetInterfaces() as $value)
{
  mylog(sprintf("Id:%d  Name:%s (%s)", $value->id, $value->name, $value->alias));
}

if (isset($_GET['var1']))
{
   $vnstat->id_iface = rawurldecode($_GET['var1']);
   mylog(sprintf("Current iFace:%d", $vnstat->id_iface));
}
else
{
  $vnstat->id_iface = 0;
  mylog("Get is not...");
}

$vnstat->ReadData();

$smarty->assignByRef('vnstat', $vnstat);
$smarty->assign('version', $vnstat_version);
$smarty->display('main.tpl');

?>
