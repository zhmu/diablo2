{include file="header.tpl"}
 <table class="itemtab">
  <tr>
   <td class="header" colspan="2">
    <a href="sets.php">Sets</a> / {$setname}
   </td>
  </tr>
  {foreach from=$setitems item=item}
   {include file="item-details.tpl"}
  {/foreach}
 </table>
{include file="footer.tpl"}
