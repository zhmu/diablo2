{include file="header.tpl"}
 <table class="itemtab">
  <tr>
   <td class="header" colspan="2">
    Items
   </td>
  </tr>
 {foreach name=catit from=$cats item=cat}
  {if $smarty.foreach.catit.index%2==0}<tr>{/if}
   <td class="ownerinfo">
     <a class="set{if $cat.numowned==0}none{elseif $cat.numowned==$cat.numitems}complete{/if}" href="category.php?id={$cat.itemcatid}">{$cat.name}</a><br/>
     Items owned / total: {$cat.numowned} / {$cat.numitems}<br/>
    </td>
  {if $smarty.foreach.catit.index%2==1}</tr>{/if}
 {/foreach}
 </table class="itemtab">
{include file="footer.tpl"}
