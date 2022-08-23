{include file="header.tpl"}
 <table class="itemtab">
  <tr>
   <td class="header" colspan="2">
    {if $item.itemsetid!=""}
    <a href="sets.php">Sets</a> / <a href="set.php?id={$item.itemsetid}">{$item.setname}</a> / {$item.name}
    {else}
    <a href="cats.php">Items</a> / <a href="category.php?id={$item.itemcatid}">{$item.catname}</a> / {$item.name}
    {/if}
   </td>
  </tr>
  {include file="item-details.tpl"}
  <tr>
   <td colspan="2" class="ownerinfo">
    Owned by:<br/>
    <p>
    {foreach from=$item.owner item=owner}
     <a href="char.php?id={$owner.charid}">{$owner.name}</a>{if $owner.amount>1} ({$owner.amount}){/if}<br/>
    {foreachelse}
     <b>Nobody</b>
    {/foreach}
    </p>
   </td>
  </tr>
 </table>
{include file="footer.tpl"}
