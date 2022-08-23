{include file="header.tpl"}
 <table class="itemtab">
  <tr>
   <td class="header" colspan="2">
    Sets
   </td>
  </tr>
 {foreach name=setit from=$sets item=set}
  {if $smarty.foreach.setit.index%2==0}<tr>{/if}
   <td class="ownerinfo">
     <a class="set{if $set.amount==0}none{elseif $set.amount==$set.total}complete{/if}" href="set.php?id={$set.itemsetid}">{$set.name}</a><br/>
     Items owned: {$set.amount} / {$set.total}
    </td>
  {if $smarty.foreach.setit.index%2==1}</tr>{/if}
 {/foreach}
 </table>
{include file="footer.tpl"}
