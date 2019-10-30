
<nav class="navbar sticky-top navbar-light bg-light">
  
  <div class="container">
    
     <a class="navbar-brand" href="#">{$vnstat->GetUsedIfaceName()}</a>

     <div class="dropdown">

        <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
           Interface-Selection
        </button>

        <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
           {foreach from=$vnstat->GetInterfaces() item=value}
               <a class="dropdown-item" href="?var1={$value->id}">{$value->name}</a>
           {/foreach}
<!--
           <a class="dropdown-item" href="?var1=hz1">1.Eintrag</a>
           <a class="dropdown-item" href="?var1=hz2">2.Eintrag</a>
           <a class="dropdown-item" href="?var1=hz3">3.Eintrag</a>
           <a class="dropdown-item" href="?var1=hz4">4.Eintrag</a>
           <a class="dropdown-item" href="?var1=hz5">5.Eintrag</a>
-->
        </div>

    </div>
       
  </div>
  
</nav>
