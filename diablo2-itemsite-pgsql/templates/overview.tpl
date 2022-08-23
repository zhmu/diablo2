{include file="header.tpl"}
<form action="overview.php" method="post">
 <table class="itemtab">
  <tr>
   <td class="header" colspan="2"><a href="/overview.php">Overview</a></td>
  </tr>
  <tr>
   <td>Sort on</td>
   <td>
    <select name="sort">
     <option value="0"{if $in.sort==0} selected{/if}>Item name</option>
     <option value="1"{if $in.sort==1} selected{/if}>Amount owned</option>
    </select>
   </td>
  </tr>
  <tr>
   <td colspan="2"><input type="checkbox" name="only109"{if $in.only109!=""} checked{/if}>Only 1.09 items</input></td>
  </tr>
  <tr>
   <td colspan="2">
    <input type="submit" name="generate" value="Generate" />
   </td>
  <tr>
 </table>
 </form>
 <table class="itemtab">
  <tr>
   <td class="header" colspan="2">Item Overview</td>
  </tr>
 {foreach from=$items item=item}
   <tr class="overviewrow">
    <td>
     {if $item.itemset eq ""}
      <a class="uniqueitem" href="item.php?id={$item.itemid}">{$item.name}</a>
     {else}
      <a class="setitem" href="item.php?id={$item.itemid}">{$item.name}</a>
     {/if}
     <br/><div class="itemtype">{$item.itemtype}
     {if $item.itemset ne ""} - <a href="set.php?id={$item.itemsetid}">{$item.itemset}</a>{/if}
     </div>
    </td>
    <td>{if $item.amount==0}<b class="havenone">{$item.amount}</b>{elseif $item.amount>1}<b class="haveplenty">{$item.amount}</b>{else}{$item.amount}{/if}</td>
   </tr>
 {/foreach}
 </table>
{include file="footer.tpl"}
