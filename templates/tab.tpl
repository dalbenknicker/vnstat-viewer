
<div class="container">
  
  <ul class="nav nav-tabs">
     
    <li class="nav-item">
      <a href="#min" class="nav-link" id="mintab" role="tab" data-toggle="tab" aria-controls="min-tab" aria-selected="false">5Min</a>
    </li>
    <li class="nav-item">
      <a href="#hour" class="nav-link" id="hourtab" role="tab" data-toggle="tab" aria-controls="hour-tab" aria-selected="false">Hourly</a>
    </li>
    <li class="nav-item">
      <a href="#day" class="nav-link active" id="daytab" role="tab" data-toggle="tab" aria-controls="day-tab" aria-selected="true">Daily</a>
    </li>
    <li class="nav-item">
      <a href="#mon" class="nav-link" id="montab" role="tab" data-toggle="tab" aria-controls="mon-tab" aria-selected="false">Monthly</a>
    </li>
    <li class="nav-item">
      <a href="#year" class="nav-link" id="yeartab" role="tab" data-toggle="tab" aria-controls="year-tab" aria-selected="false">Yearly</a>
    </li>
    <li class="nav-item">
      <a href="#top" class="nav-link" id="toptab" role="tab" data-toggle="tab"aria-controls="top-tab" aria-selected="false">Top</a>
    </li>

  </ul>

  <div class="tab-content">

    <div role="tabpanel" class="tab-pane" id="min" aria-labelledby="mintab" aria-selected="false">

      <table class="table table-bordered">

        <thead>
          <tr>
            <th>Min</th>
            <th>Received</th>
            <th>Sent</th>
            <th>Total</th>
          </tr>
        </thead>

        <tbody>
          {foreach from=$vnstat->Data5Min() key=key item=value}
             <tr>
               <td>{$vnstat->TabTime2($value.time, MINTYP)}</td>
               <td>{$vnstat->TabValue($value.rx)}</td>
               <td>{$vnstat->TabValue($value.tx)}</td>
               <td>{$vnstat->TabValue($value.rx + $value.tx)}</td>
             </tr>
          {/foreach}
        </tbody>
         
      </table>

    </div>

    <div role="tabpanel" class="tab-pane" id="hour" aria-labelledby="hourtab" aria-selected="false">

      <table class="table table-bordered">

        <thead>
          <tr>
            <th>Hour</th>
            <th>Received</th>
            <th>Sent</th>
            <th>Total</th>
          </tr>
        </thead>
                
        <tbody>
          {foreach from=$vnstat->DataHour() key=key item=value}
             <tr>
               <td>{$vnstat->TabTime2($value.time, HOURTYP)}</td>
               <td>{$vnstat->TabValue($value.rx)}</td>
               <td>{$vnstat->TabValue($value.tx)}</td>
               <td>{$vnstat->TabValue($value.rx + $value.tx)}</td>
             </tr>
          {/foreach}
        </tbody>

      </table>

    </div>
      
    <div role="tabpanel" class="tab-pane active" id="day" aria-labelledby="daytab" aria-selected="true">

      <table class="table table-bordered">
             
        <thead>
          <tr>
            <th>Day</th>
            <th>Received</th>
            <th>Sent</th>
            <th>Total</th>
          </tr>
        </thead>
                
        <tbody>
          {foreach from=$vnstat->DataDay() key=key item=value}
             <tr>
               <td>{$vnstat->TabTime2($value.time, DAYTYP)}</td>
               <td>{$vnstat->TabValue($value.rx)}</td>
               <td>{$vnstat->TabValue($value.tx)}</td>
               <td>{$vnstat->TabValue($value.rx + $value.tx)}</td>
             </tr>
          {/foreach}
        </tbody>
         
      </table>

    </div>

    <div role="tabpanel" class="tab-pane" id="mon" aria-labelledby="montab" aria-selected="false">
        
      <table class="table table-bordered">
             
        <thead>
          <tr>
            <th>Month</th>
            <th>Received</th>
            <th>Sent</th>
            <th>Total</th>
          </tr>
        </thead>
                
        <tbody>
          {foreach from=$vnstat->DataMon() key=key item=value}
             <tr>
               <td>{$vnstat->TabTime2($value.time, MONTYP)}</td>
               <td>{$vnstat->TabValue($value.rx)}</td>
               <td>{$vnstat->TabValue($value.tx)}</td>
               <td>{$vnstat->TabValue($value.rx + $value.tx)}</td>
             </tr>
          {/foreach}
        </tbody>
              
      </table>
            
    </div>
      
    <div role="tabpanel" class="tab-pane" id="year" aria-labelledby="montab" aria-selected="false">

      <table class="table table-bordered">
             
        <thead>
          <tr>
            <th>Year</th>
            <th>Received</th>
            <th>Sent</th>
            <th>Total</th>
          </tr>
        </thead>
                
        <tbody>
          {foreach from=$vnstat->DataYear() key=key item=value}
             <tr>
               <td>{$vnstat->TabTime2($value.time, YEARTYP)}</td>
               <td>{$vnstat->TabValue($value.rx)}</td>
               <td>{$vnstat->TabValue($value.tx)}</td>
               <td>{$vnstat->TabValue($value.rx + $value.tx)}</td>
             </tr>
          {/foreach}
        </tbody>
      </table>
       
    </div>
      
    <div role="tabpanel" class="tab-pane" id="top" aria-labelledby="toptab" aria-selected="false">

      <table class="table table-bordered">
             
        <thead>
          <tr>
            <th>Top</th>
            <th>Received</th>
            <th>Sent</th>
            <th>Total</th>
          </tr>
        </thead>
                
        <tbody>
          {foreach from=$vnstat->DataTop() key=key item=value}
             <tr>
               <td>{$vnstat->TabTime2($value.time, TOPTYP)}</td>
               <td>{$vnstat->TabValue($value.rx)}</td>
               <td>{$vnstat->TabValue($value.tx)}</td>
               <td>{$vnstat->TabValue($value.rx + $value.tx)}</td>
             </tr>
          {/foreach}
                
        </tbody>
           
      </table>

    </div>

  </div>

</div>
