{include file="header.tpl"}
<form action="search.php" method="post">
 <table class="itemtab">
  <tr>
   <td class="header" colspan="2">
    <a href="search.php">Search</a>
   </td>
  </tr>
  <tr>
   <td>Item Category</td>
   <td>
    <select name="itemcat">
     <option value=""{if $in.itemcatid==""} selected{/if}>[ any ]</option>
     {foreach from=$itemcats item=cat}
      <option value="{$cat.itemcatid}"{if $in.itemcatid==$cat.itemcatid} selected{/if}>{$cat.name}</option>
     {/foreach}
     </select>
   </td>
  </tr>
  <tr>
   <td>Charachter Level</td>
   <td><input type="text" name="clevel" value="{$in.clevel}" /></td>
  </tr>
  <tr>
   <td colspan="2"><input type="checkbox" name="onlyfound"{if $in.onlyfound!=""} checked{/if}>Only search for items that have been found</input></td>
  </tr>
  <tr>
   <td colspan="2"><input type="checkbox" name="only109"{if $in.only109!=""} checked{/if}>Only 1.09 items</input></td>
  </tr>
  <tr>
   <td class="header" colspan="2">Modifiers</td>
  </tr>
{foreach from=$in.mods item=mod}
  <tr>
   <td>
    <input type="hidden" name="domod[{$mod.num}]" value="!" />
    <input type="submit" name="delmod[{$mod.num}]" value="[delete]" />
    <select name="mod[{$mod.num}]">
     {foreach from=$itemprops item=prop}
      <option value="{$prop.itempropid}"{if $mod.id==$prop.itempropid} selected{/if}>{$prop.name}</option>
     {/foreach}
    </select>
   </td>
   <td>
    <select name="modop[{$mod.num}]">
     {foreach from=$modops item=op}
      <option value="{$op.id}"{if $op.id==$mod.op} selected{/if}>{$op.name}</option>
     {/foreach}
    </select>
    <input name="modval[{$mod.num}]" value="{$mod.value}" />
   </td>
  </tr>
{/foreach}
  <tr>
   <td colspan="2">
    <input type="submit" name="addmod" value="Add Modifier">
   </td>
  </tr>
  <tr>
   <td class="header" colspan="2">Spells</td>
  </tr>
{foreach from=$in.spells item=spl}
  <tr>
   <td>
    <input type="hidden" name="dospell[{$spl.num}]" value="!" />
    <input type="submit" name="delspell[{$spl.num}]" value="[delete]" />
    <select name="spellop[{$spl.num}]">
     {foreach from=$spellops item=op}
      <option value="{$op.id}"{if $op.id==$spl.op} selected{/if}>{$op.name}</option>
     {/foreach}
    </select>
    <select name="spell[{$spl.num}]">
     {foreach from=$spells item=spell}
      <option value="{$spell.spellid}"{if $spl.id==$spell.spellid} selected{/if}>{$spell.name}</option>
     {/foreach}
    </select>
   </td>
   <td>
   </td>
  </tr>
{/foreach}
  <tr>
   <td colspan="2">
    <input type="submit" name="addspell" value="Add Spell">
   </td>
  </tr>
  <tr>
   <td colspan="2">
    <input type="submit" name="search" value="Search" />
   </td>
  <tr>
 </table>
</form>
{if $numitems!=""}
<table class="itemtab">
 <tr>
  <td class="header" colspan="2">
   Results
  </td>
 </tr>
 {foreach from=$items item=item}
  {include file="item-details.tpl"}
 {/foreach}
 <tr>
  <td class="header" colspan="2">
   {$numitems} item{if $numitems!=1}s{/if} found
  </td>
 </tr>
</table>
{/if}
{include file="footer.tpl"}
