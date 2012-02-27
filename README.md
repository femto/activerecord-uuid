# Description

* Add Postgres ActiveRecord UUID to your app
* db/schema.rb is replaced with db/development_structure.sql
* `rake db:schema:*` is now useless, use `rake db:structure:` instead

# Configuration

* Any model which includes a UUID field must include ActiveRecord::Uuid::Mixin
* For some heretofore unknown reason, you can't use uuid fields in a create table, only in change_table... 

# Copyright

Copyright (c) 2012 Adaptly. See LICENSE.txt for further details.

