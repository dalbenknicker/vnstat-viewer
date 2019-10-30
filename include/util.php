<?php

function mylog($message)
{
  if ($GLOBALS["DEBUG"])
  {
      printf ("Log: %s", $message);
      printf ("<br/br>");
  }
}

function GetPrefix($kb)
{
  $units = ['TB', 'GB', 'MB', 'KB', 'B'];
  $scale = 1024 * 1024 * 1024 * 1024;
  $ui = 0;

  while ((($kb < $scale) && ($scale > 1)))
  {
     $ui++;
     $scale = $scale / 1024;
  }

  return $units[$ui];
}    

function formatBytes($bytes, $decimals = 2)
{
   $base     = log(floatval($bytes), 1024);
   $suffixes = ['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];

   return round(pow(1024, $base - floor($base)), $decimals) .' '. $suffixes[floor($base)];
} 

function _formatBytesTo($bytes, $delimiter, $decimals = 2)
{
   if ($bytes == 0)
   {
       return '0';
   }

   $k = 1024;
   $dm = $decimals < 0 ? 0 : $decimals;
   $sizes = ['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];

   $i = array_search($delimiter, $sizes);

   return ($bytes / pow($k, $i));
   // return number_format(($bytes / pow($k, $i)), $decimals);
}


?>
