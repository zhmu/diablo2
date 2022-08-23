{include file="header.tpl"}
 <table class="itemtab">
  <tr>
   <td class="header" colspan="2">
    <a href="types.php">Types</a> / {$catname}
   </td>
  </tr>
  {foreach from=$types item=type}
   <tr>
    <td class="iteminfo">
     <div class="itemname">
      <img src="{$type.image}" alt="{$type.name}" /><br/>
      {$type.name}
     </div>
    </td>
    <td class="itemdescr">
     {if $type.tc!=""}
     Treasure class: <b class="{if $type.tc<50}low{elseif $type.tc>=75}high{else}medium{/if}tc">{$type.tc}</b><br/>
     {/if}
     {foreach from=$type.base item=prop}
      {$prop.name}:
      {if $prop.value}<b>{$prop.value}</b>{/if}
      {if $prop.min}<b>{$prop.min}-{$prop.max}</b>{/if}
      {if $prop.perlevel}<b>(Character level * {$prop.perlevel})</b>{/if}
      <br />
     {/foreach}
     {if $type.req_level ne ""}Required level: <b>{$type.req_level}</b><br/>{/if}
     {if $type.req_str ne ""}Required strength: <b>{$type.req_str}</b><br/>{/if}
     {if $type.req_dex ne ""}Required dexterity: <b>{$type.req_dex}</b><br/>{/if}
     <div class="typeprops">
      {foreach from=$type.properties item=prop}
       {if $prop.value}{if $prop.value>0}+{/if}{$prop.value}{/if}
       {if $prop.min}{$prop.min}-{$prop.max}{/if}
       {if $prop.perlevel}(Character level * {$prop.perlevel}){/if}
       {$prop.name}<br/>
      {/foreach}
    </td>
   </tr>
  {/foreach}
 </table>
{include file="footer.tpl"}
