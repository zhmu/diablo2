   <tr>
    <td class="iteminfo">
     <div class="itemname">
      <a href="item.php?id={$item.itemid}">
       <img src="{$item.image}" alt="{$item.name}" /><br/>
       {$item.name}<br/>
      </a>
     </div>
     <a class="{if $item.itemsetid eq ""}unique{else}set{/if}itemlink" href="type.php?id={$item.itemcatid}">{$item.itemtype}</a><br/>
     {if $item.itemsetid != ""}<a class="{if $item.total==$item.owned}setcomplete{elseif $item.owned==0}setnone{else}setpartial{/if}" href="set.php?id={$item.itemsetid}">{$item.itemset}</a>{/if}
     {if $item.version != "109"}{if $item.version == 110}<b>1.10+</b>{elseif $item.version == 111}<b>1.11+</b>{else}???{/if}
     {/if}
    </td>
    <td class="itemdescr">
     {if $item.tc!=""}
     Treasure class: <b class="{if $item.tc<50}low{elseif $item.tc>=75}high{else}medium{/if}tc">{$item.tc}</b><br/>
     {/if}
     {foreach from=$item.base item=prop}
      {$prop.name}:
      {if $prop.value}<b>{$prop.value}</b>{/if}
      {if $prop.min}<b>{$prop.min}-{$prop.max}</b>{/if}
      {if $prop.perlevel}<b>(Character level * {$prop.perlevel})</b>{/if}
      <br />
     {/foreach}
     {foreach from=$item.cacheprops item=prop}
      {$prop.name}:
      {if $prop.value}<b class="itemprops">{$prop.value}</b>{/if}
      {if $prop.min}<b class="itemprops">{$prop.min}-{$prop.max}</b>{/if}
      <br />
     {/foreach}
     {if $item.req_level ne ""}Required level: <b>{$item.req_level}</b><br/>{/if}
     {if $item.req_str ne ""}Required strength: <b>{$item.req_str}</b><br/>{/if}
     {if $item.req_dex ne ""}Required dexterity: <b>{$item.req_dex}</b><br/>{/if}
     Amount owned: {if $item.amount==0}<b class="noneowned">{else}{if $item.numether==$item.amount}<b class="etherowned">{else}<b class="itemowned">{/if}{/if}{$item.amount}</b><br/>
     <div class="itemprops">
      {foreach from=$item.properties item=prop}
       {if $prop.value}{if $prop.value>0}+{/if}{$prop.value}{/if}
       {if $prop.min}{$prop.min}-{$prop.max}{/if}
       {if $prop.perlevel}(Character level * {$prop.perlevel}){/if}
       {$prop.name}<br/>
      {/foreach}
     </div>
     <div class="itemprops">
     {foreach from=$item.spells item=spell}
      {if $spell.type=="C"}
       Level {if $spell.lval!=""}{$spell.lval}{else}{$spell.lmin} - {$spell.lmax}{/if} {$spell.name} ({$spell.num_charges} charges)
      {elseif $spell.type=="S"}
       +{if $spell.lval!=""}{$spell.lval}{else}{$spell.lmin} - {$spell.lmax}{/if} to {$spell.name} ({$spell.class} only)
      {else}
       {if $spell.pval!=""}{$spell.pval}{else}{$spell.pmin} - {$spell.pmax} {/if} % Chance to Cast Level {if $spell.lval!=""}{$spell.lval}{else}{$spell.lmin} - {$spell.lmax}{/if} {$spell.name} {if $spell.type=="O"}on striking{elseif $spell.type=="W"}when struck{elseif $spell.type=="A"}on Attack{elseif $spell.type=="I"}when you die{elseif $spell.type=="L"}when you level-up{elseif $spell.type=="K"}when you kill an enemy{/if}
      {/if}
      <br/>
     {/foreach}
     </div>
    </td>
   </tr>
