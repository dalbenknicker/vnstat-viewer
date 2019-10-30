
<script type="text/javascript">

   google.charts.load('current', { packages: [ 'bar' ] });
   google.charts.load("current", { packages: [ 'corechart' ] });

   google.charts.setOnLoadCallback(drawMinChart);
   google.charts.setOnLoadCallback(drawHourlyChart);
   google.charts.setOnLoadCallback(drawDailyChart);
   google.charts.setOnLoadCallback(drawMonthlyChart);
   google.charts.setOnLoadCallback(drawYearlyChart);


   function drawMinChart()
   {
     {$vnstat->DiaStart(MINTYP)}     
     var data = new google.visualization.DataTable();

     data.addColumn('date',   'Min');
     data.addColumn('number', 'Traffic In');
     data.addColumn('number', 'Traffic Out');
     data.addColumn('number', 'Total Traffic');
     data.addRows([

       {foreach from=$vnstat->Data5Min() key=key item=value}
          [new {$vnstat->DiaTime($value.time)}, {$vnstat->DiaValue($value.rx)}, {$vnstat->DiaValue($value.tx)}, {$vnstat->DiaValue($value.rx + $value.tx)}],
       {/foreach}
     
     ]);
   
     let options = {
            
         title: '5Min Network Traffic',
         orientation: 'horizontal',
         legend: { position: 'right' },
         explorer: { 
            axis: 'horizontal',
            maxZoomIn: 8.0,
            maxZoomOut: 3.0
         },
         vAxis: {
             title: 'Data',
             format: '##.## {$vnstat->Data5MinPrefix()}'
         },
         hAxis: {
             title: '5Min',
             direction: -1,
             format: 'HH:mm',
             ticks:[
                      {foreach from=$vnstat->Data5Min() key=key item=value}
                         new {$vnstat->DiaTime($value.time)},
                      {/foreach}
                   ]
        }
     };

     var formatDate = new google.visualization.DateFormat({ pattern: 'dd/MM/yyyy HH:mm' });
     formatDate.format(data, 0);

     var formatNumber = new google.visualization.NumberFormat({ pattern: '##.## {$vnstat->Data5MinPrefix()}' });
     formatNumber.format(data, 1);
     formatNumber.format(data, 2);
     formatNumber.format(data, 3);

     let chart = new google.visualization.BarChart(document.getElementById('minNetworkTrafficGraph'));
     chart.draw(data, google.charts.Bar.convertOptions(options));
     
   }


   function drawHourlyChart()
   {
     {$vnstat->DiaStart(2)}
     
     var data = new google.visualization.DataTable();

     data.addColumn('date',   'Hour');
     data.addColumn('number', 'Traffic In');
     data.addColumn('number', 'Traffic Out');
     data.addColumn('number', 'Total Traffic');
   
     data.addRows([
       {foreach from=$vnstat->DataHour() key=key item=value}
          [new {$vnstat->DiaTime($value.time)}, {$vnstat->DiaValue($value.rx)}, {$vnstat->DiaValue($value.tx)}, {$vnstat->DiaValue($value.rx + $value.tx)}],
       {/foreach}
     ]);
   
     let options = {
            
                title: 'Hourly Network Traffic',
                orientation: 'horizontal',
                legend: { position: 'right' },
                explorer: { 
                    axis: 'horizontal',
                    maxZoomIn: 4.0,
                    maxZoomOut: 3.0
            	},
                vAxis: {
                    title: 'Data',
                    format: '##.## {$vnstat->DataHourPrefix()}'
                },
                hAxis: {
                    title: 'Hour',
                    format: 'HH:mm',
                    direction: -1,
                    ticks:[
                      {foreach from=$vnstat->DataHour() key=key item=value}
                         new {$vnstat->DiaTime($value.time)},
                      {/foreach}
                   ]
                }
    };
            
    var formatDate = new google.visualization.DateFormat({ pattern: 'dd/MM/yyyy HH:mm' });
    formatDate.format(data, 0);
            
    var formatNumber = new google.visualization.NumberFormat({ pattern: '##.## {$vnstat->DataHourPrefix()}' });
    formatNumber.format(data, 1);
    formatNumber.format(data, 2);
    formatNumber.format(data, 3);
   
    let chart = new google.visualization.BarChart(document.getElementById('hourlyNetworkTrafficGraph'));
    chart.draw(data, google.charts.Bar.convertOptions(options));
    
  }


  function drawDailyChart()
  {
    {$vnstat->DiaStart(3)}
    
    var data = new google.visualization.DataTable();

    data.addColumn('date',   'Day');
    data.addColumn('number', 'Traffic In');
    data.addColumn('number', 'Traffic Out');
    data.addColumn('number', 'Total Traffic');

    data.addRows([
   
       {foreach from=$vnstat->DataDay() key=key item=value}
          [new {$vnstat->DiaTime($value.time)}, {$vnstat->DiaValue($value.rx)}, {$vnstat->DiaValue($value.tx)}, {$vnstat->DiaValue($value.rx + $value.tx)}],
       {/foreach}
   
    ]);
            
    let options = {
         title: 'Daily Network Traffic',
         orientation: 'horizontal',
         legend: { position: 'right' },
         explorer: { 
            axis: 'horizontal',
            maxZoomIn: 4.0,
            maxZoomOut: 3.0
         },
         vAxis: {
            title: 'Data',
            format: '##.## {$vnstat->DataDayPrefix()}'
         },
         hAxis: {
            title: 'Day',
            format: 'dd/MM/YYYY',
            direction: -1
         }
    };
            
    var formatDate = new google.visualization.DateFormat({ pattern: 'dd/MM/yyyy' });
    formatDate.format(data, 0);
            
    var formatNumber = new google.visualization.NumberFormat({ pattern: '##.## {$vnstat->DataDayPrefix()}' });
    formatNumber.format(data, 1);
    formatNumber.format(data, 2);
    formatNumber.format(data, 3);

    let chart = new google.visualization.BarChart(document.getElementById('dailyNetworkTrafficGraph'));
    chart.draw(data, google.charts.Bar.convertOptions(options));
   
  }

  function drawMonthlyChart()
  {
    {$vnstat->DiaStart(4)}
    
    var data = new google.visualization.DataTable();

    data.addColumn('date', 'Month');
    data.addColumn('number', 'Traffic In');
    data.addColumn('number', 'Traffic Out');
    data.addColumn('number', 'Total Traffic');

    data.addRows([
       {foreach from=$vnstat->DataMon() key=key item=value}
          [new {$vnstat->DiaTime($value.time)}, {$vnstat->DiaValue($value.rx)}, {$vnstat->DiaValue($value.tx)}, {$vnstat->DiaValue($value.rx + $value.tx)}],
       {/foreach}
    ]);

    data.addRow([new {$vnstat->DiaTimeYear(0)}, 0, 0, 0]);

    let options =
    {
        title: 'Monthly Network Traffic',
        orientation: 'horizontal',
        legend: { position: 'right' },
        explorer: { 
            axis: 'horizontal',
            maxZoomIn: 4.0,
            maxZoomOut: 3.0
        },
        vAxis: {
            title: 'Data',
            format: '##.## {$vnstat->DataMonPrefix()}'
        },
         hAxis: {
            title: 'Month',
            format: 'MMMM YYYY',
            direction: -1
         }
    };

    var formatDate = new google.visualization.DateFormat({ pattern: 'MMMM YYYY' });
    formatDate.format(data, 0);
            
    var formatNumber = new google.visualization.NumberFormat({ pattern: '##.## {$vnstat->DataMonPrefix()}' });
    formatNumber.format(data, 1);
    formatNumber.format(data, 2);
    formatNumber.format(data, 3);

    let chart = new google.visualization.BarChart(document.getElementById('monthlyNetworkTrafficGraph'));
    chart.draw(data, google.charts.Bar.convertOptions(options));
    
  }

  function drawYearlyChart()
  {
    {$vnstat->DiaStart(5)}
    
    var data = new google.visualization.DataTable();

    data.addColumn('date', 'Year');
    data.addColumn('number', 'Traffic In');
    data.addColumn('number', 'Traffic Out');
    data.addColumn('number', 'Total Traffic');

    data.addRows([
       {foreach from=$vnstat->DataYear() key=key item=value}
          [new {$vnstat->DiaTime($value.time)}, {$vnstat->DiaValue($value.rx)}, {$vnstat->DiaValue($value.tx)}, {$vnstat->DiaValue($value.rx + $value.tx)}],
       {/foreach}
    ]);

    data.addRow([new {$vnstat->DiaTimeYear(1)}, 0, 0, 0]);

    let options =
    {
        title: 'Yearly Network Traffic',
        orientation: 'horizontal',
        legend: { position: 'right' },
        explorer: { 
            axis: 'horizontal',
            maxZoomIn: 4.0,
            maxZoomOut: 3.0
        },
        vAxis: {
            title: 'Data',
            format: '##.## {$vnstat->DataYearPrefix()}'
        },
         hAxis: {
            title: 'Year',
            format: 'YYYY',
            direction: -1
         }
    };

    var formatDate = new google.visualization.DateFormat({ pattern: 'YYYY' });
    formatDate.format(data, 0);
            
    var formatNumber = new google.visualization.NumberFormat({ pattern: '##.## {$vnstat->DataYearPrefix()}' });
    formatNumber.format(data, 1);
    formatNumber.format(data, 2);
    formatNumber.format(data, 3);

    let chart = new google.visualization.BarChart(document.getElementById('yearlyNetworkTrafficGraph'));
    chart.draw(data, google.charts.Bar.convertOptions(options));
    
  }

</script>
