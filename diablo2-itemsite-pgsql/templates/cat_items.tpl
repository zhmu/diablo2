{include file="header.tpl"}
 <table class="itemtab">
  <tr>
   <td class="header" colspan="2">
    <a href="cats.php">Items</a> / {$catname}
   </td>
  </tr>
  {foreach from=$items item=item}
   {include file="item-details.tpl"}
  {/foreach}
 </table>
{include file="footer.tpl"}
