{include file="header.tpl"}
 <table class="itemtab">
  <tr>
   <td class="header" colspan="2">
    Types
   </td>
  </tr>
 {foreach name=typeit from=$types item=type}
  {if $smarty.foreach.typeit.index%2==0}<tr>{/if}
   <td class="ownerinfo">
     <a href="type.php?id={$type.itemcatid}">{$type.name}</a>
    </td>
  {if $smarty.foreach.typeit.index%2==1}</tr>{/if}
 {/foreach}
 </table class="itemtab">
{include file="footer.tpl"}
