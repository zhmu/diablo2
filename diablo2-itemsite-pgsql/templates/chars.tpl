{include file="header.tpl"}
 <table class="itemtab">
  <tr>
   <td class="header" colspan="2">
    Charachters
   </td>
  </tr>
 {foreach name=charit from=$chars item=char}
  {if $smarty.foreach.charit.index%2==0}
   <tr>
   {if $smarty.foreach.charit.last}
    <td colspan="2">
   {else}
    <td>
   {/if}
  {else}
   <td>
  {/if}
   <a href="char.php?id={$char.charid}">{$char.name}</a> - {$char.fullclass} level {$char.level}{if $char.charachter>109} 1.10+{/if}
  </td>
  {if $smarty.foreach.charit.index%2==1}<tr>{/if}
 {/foreach}
 </table>
{include file="footer.tpl"}
