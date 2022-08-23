1. Introduction

Back in the day, I used to play a lot of Diablo2. In order to keep track of the
items I had collected, I made a PHP/MySQL website so that both myself as my
friends could see what I still missed (and thus, whether it was worth to pick
up an item or just dispose of it :-)

2. Rewriting the site

However, as this website worked fine, 1.10 came out, which introduced a lot of
classy new items. As the game got a lot harder, I wanted to be able to search
for items with properties (for example, an overview of all items which give
+ to all resistances) - this was not feasible with the old approach (which just
stored item properties in a MySQL TEXT field), so I decided a rewrite was in
order.

3. Implementation

I chose the PostgreSQL database as it's much more feature-complete - and things
like referential integrity and column checks are very useful.

In order to easily import data, I chose to write everything down as XML which
I could then later import into the database using Perl scripts. The XML files
are provided in the xml/ folder, whereas the scripts are in the scripts/
folder.

For ease of use, a complete database dump with all items imported is provided
in sql/diablo2-filled.sql.

4. License

This work is licensed under the GPL license version 2 or up. All item-images
as provided in www/images/items/ are copyright Blizzard Entertainment.
