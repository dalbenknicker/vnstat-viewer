<?php

class iface
{
   public $id;
   public $name;
   public $alias;
}

class vdata
{
  public $data;
  public $max;
  public $prefix;
  public $idx;
}

class vnstat
{
   public    $id_iface;
   protected $_path;
   protected $_data;
   public    $vnstat_version;
   public    $json_version;
   protected $interfaces = [];

   protected $vdata_5min;
   protected $vdata_hour;
   protected $vdata_day;
   protected $vdata_mon;
   protected $vdata_year;
   protected $vdata_top;
   
   public $dia;

   public function __construct ($Path)
   {
      //mylog("vnstat constructor...");
      
      if (!isset($Path))
      {
         mylog("Path invalid");
         exit(1);
      }
      
      $this->_path    = $Path;
      $this->id_iface = 0;
      $this->dia      = 0;
    
      $stream = popen("$this->_path", 'r');
      if (!is_resource($stream))
      {
         mylog("stream invalid");
         exit(1);
      }
      
      $buffer = '';

      while (!feof($stream))
      {
         $buffer .= fgets($stream);
      }

      pclose($stream);
      
      $this->_data = json_decode($buffer, true);

      if (json_last_error() != JSON_ERROR_NONE)
      {
          mylog("json failed...");
          exit(1);
          // throw new Exception('JSON is invalid');
      }

      $this->ReadVersion();
      $this->ReadInterfaces();
   }

   protected function ReadVersion()
   {
      $this->vnstat_version = $this->_data['vnstatversion'];
      $this->json_version   = $this->_data['jsonversion'];

      mylog(sprintf("Version vnstat-viewer: %s", $GLOBALS['vnstat_version']));
      mylog(sprintf("Version vnstat: %s", $this->vnstat_version));
      mylog(sprintf("Version json  : %s", $this->json_version));
   }

   protected function ReadInterfaces()
   {
      mylog("Read Interfaces...");
      
      $this->interfaces = array();
      $id = 0;
      
      foreach($this->_data['interfaces'] as $interface)
      {
         $iface = new iface();
         
         $iface->id    = $id++;
         $iface->name  = $interface['name'];
         $iface->alias = $interface['alias'];
         if (!strlen($iface->alias))
             $iface->alias = sprintf ("%s", $iface->name);

         if ($GLOBALS['iface_doreplace'])
         {
           if (array_key_exists($iface->name, $GLOBALS['iface_replace']))
           {
             //mylog(sprintf("Key exist: %s  Value:%s", $iface->name, $GLOBALS['iface_replace'][$iface->name]));
             $iface->alias = $GLOBALS['iface_replace'][$iface->name];
           }
           //else
           //   mylog(sprintf("Key not exist: %s", $iface->name));
         }
         
         array_push($this->interfaces, $iface);
      }
      
      mylog(sprintf ("'%d' interfaces found", count($this->interfaces)));
   }

   protected function ReadLowData($datkey, $phourmin, $pday, $pmon): vdata
   {
     $obj = new vdata();

     $item      = $this->interfaces[$this->id_iface];
     $interface = $item->name;
     //mylog(sprintf("ReadLowData for Interface: '%s'", $interface));

     $arrayIndex = array_search($interface, array_column($this->_data['interfaces'], 'name'));
     //mylog(sprintf ("'%d' Index found", $arrayIndex));

     $obj->max = 0;
     $i        = 0;

     foreach ($this->_data['interfaces'][$arrayIndex]['traffic'][$datkey] as $traffic)
     {
         if (is_array($traffic))
         {
           $hour  = $min = 0;
           $day   = 1;
           $month = 1;
           
           if ($phourmin)
           {
             $hour  = $traffic['time']['hour'];
             $min   = $traffic['time']['minute'];
           }

           if ($pday)
               $day   = $traffic['date']['day'];

           if ($pmon)
               $month = $traffic['date']['month'];
               
           $year  = $traffic['date']['year'];

           $rx    = $traffic['rx'];
           $tx    = $traffic['tx'];

           $time = mktime($hour, $min, 0, $month, $day, $year);

           $obj->data[$i]['time'] = $time;
           $obj->data[$i]['rx']   = $rx;
           $obj->data[$i]['tx']   = $tx;
           $i++;

           $max = $rx + $tx;
           if ($max > $obj->max)
           {
              $obj->max    =  $max;
              $obj->prefix = GetPrefix($max);
              $obj->idx    = $i;
           }   

         }
     }

     return $obj;
   }

   public function ReadData()
   {
     mylog("ReadData...");

     $this->vdata_5min   = $this->ReadLowData('fiveminute', true, true, true);
     $this->vdata_hour   = $this->ReadLowData('hour', true, true, true);
     $this->vdata_day    = $this->ReadLowData('day', false, true, true);
     $this->vdata_mon    = $this->ReadLowData('month', false, false, true);
     $this->vdata_year   = $this->ReadLowData('year', false, false, false);
     $this->vdata_top    = $this->ReadLowData('top', false, true, true);
   }

   public function DiaStart($value)
   {
     $this->dia = $value;
//     mylog(sprintf("DiaType:%d", $value));
   }

   public function DiaTimeYear($value)
   {
    $time = getdate(time());
    $year = $time['year'] - $value;

    return sprintf("Date(%d,%d,%d,%d,%d)", $year, 0, 1, 0, 0);
   }
   
   public function DiaTime($value)
   {
    $time = getdate($value);
    
    $day  = $time['mday'];
    $mon  = $time['mon'];
    $year = $time['year'];
    $hour = $time['hours'];
    $min  = $time['minutes'];

    return sprintf("Date(%d,%d,%d,%d,%d)", $year, $mon-1, $day, $hour, $min);
   }

   public function DiaValue($value)
   {
     switch ($this->dia)
     {
       case MINTYP:
            return _formatBytesTo($value, $this->vdata_5min->prefix);
            break;
       case HOURTYP:
            return _formatBytesTo($value, $this->vdata_hour->prefix);
            break;
       case DAYTYP:
            return _formatBytesTo($value, $this->vdata_day->prefix);
            break;
       case MONTYP:
            return _formatBytesTo($value, $this->vdata_mon->prefix);
            break;
       case YEARTYP:
            return _formatBytesTo($value, $this->vdata_year->prefix);
            break;
       case TOPTYP:
            return _formatBytesTo($value, $this->vdata_year->prefix);
            break;
     }
     
     return 0;
   }

   public function TabTime2($value, $data)
   {
    switch ($data)
    {
       case MINTYP:
            return date('d.m.Y H:i:s', $value);
            break;
       case HOURTYP:
            return date('d.m.Y H:i', $value);
            break;
       case TOPTYP:     
       case DAYTYP:
            return date('d.m.Y', $value);
            break;
       case MONTYP:
            return date('m.Y', $value);
            break;
      case YEARTYP:
           return date('Y', $value);
           break;
     }

     return date('d.m.Y H:i:s', $value);
     
   }

   public function TabValue($value)
   {
    return formatBytes($value);
   }


   public function Data5Min()
   {
     return $this->vdata_5min->data;
   }

   public function Data5MinPrefix()
   {
     return $this->vdata_5min->prefix;
   }

   public function Data5MinMax()
   {
     return $this->vdata_5min->max;
   }

   public function DataHour()
   {
     return $this->vdata_hour->data;
   }

   public function DataHourPrefix()
   {
     return $this->vdata_hour->prefix;
   }

   public function DataDay()
   {
     return $this->vdata_day->data;
   }

   public function DataDayPrefix()
   {
     return $this->vdata_day->prefix;
   }

   public function DataMon()
   {
     return $this->vdata_mon->data;
   }

   public function DataMonPrefix()
   {
     return $this->vdata_mon->prefix;
   }

   public function DataYear()
   {
     return $this->vdata_year->data;
   }

   public function DataYearPrefix()
   {
     return $this->vdata_year->prefix;
   }

   public function DataTop()
   {
     return $this->vdata_top->data;
   }

   public function DataTopPrefix()
   {
     return $this->vdata_top->prefix;
   }

   public function GetUsedIfaceName()
   {
      $item      = $this->interfaces[$this->id_iface];
      return $item->alias;
   }

   public function GetInterfaces()
   {
    return $this->interfaces;
   }
    
}

?>
