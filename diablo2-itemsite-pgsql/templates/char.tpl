{include file="header.tpl"}
 <table class="itemtab">
  <tr>
   <td colspan="2" class="header">
    <a href="chars.php">Charachters</a> / {$char.name}
   </td>
  </tr>
  <tr>
   <td>Name</td>
   <td>{$char.name}</td>
  </tr>
  <tr>
   <td>Class</td>
   <td>{$char.fullclass}</td>
  </tr>
  <tr>
   <td>Level</td>
   <td>{$char.level}</td>
  </tr>
  <tr>
   <td>Version</td>
   <td>{if $char.version==109}1.09{elseif $char.version==110}1.10{else}1.11{/if}</td>
  </tr>
  <tr>
   <td colspan="2" class="ownerinfo">
   Items owned:
   </td>
   {foreach from=$items item=item}
    {include file="item-details.tpl"}
   {/foreach}
  </tr>
 </table>
{include file="footer.tpl"}
