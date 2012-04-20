# ActiveRecord::Uuid

Adds automatically-assigned UUIDs to your model and allows you to find by UUID directly.

## Configuration
Add the gem to your Gemfile:

```
gem 'activerecord-uuid'
```

Create a migration to inclue a uuid column:

```
class CreateFoos < ActiveRecord::Migration
  def up
    create_table :foos do |t|
      t.string :uuid # Store it as a string. See below to use native PostgreSQL UUID columns.
    end
  end
end
```

Use it in your ActiveRecord model:

```
class Foo < ActiveRecord::Base
  include ActiveRecord::Uuid
end
```

See it work:

```
Foo.create
 => #<Foo id: 1, uuid: "680d92fc-8b1e-11e1-a80a-70cd60fffe5d">
Foo.find(1)
 => #<Foo id: 1, uuid: "680d92fc-8b1e-11e1-a80a-70cd60fffe5d">
Foo.find("680d92fc-8b1e-11e1-a80a-70cd60fffe5d")
 => #<Foo id: 1, uuid: "680d92fc-8b1e-11e1-a80a-70cd60fffe5d">
```

## Native UUID Columns

This gem adds a Rails initializer that allows you to use native UUID types in PostgreSQL. To create a column in your migration:

```
class CreateFoos < ActiveRecord::Migration
  def up
    create_table :foos
    add_column :foos, :uuid, :uuid
  end
end
```

Note that this does not work with `create_table` and `change_table` block syntaxes. Feel free to add support and open a pull request.

Dumping your `db/schema.rb` file will not work with native UUID types, so instead you should use this line in your `config/application.rb` file to instead dump to `db/structure.sql`:

```
config.active_record.schema_format = :sql
```

## TODO

1. Allow configuration of UUID columns.
2. Figure out how to make native migrations work with `create_table` and `change_table`.
3. Write tests!

## Copyright

&copy; 2012 Adaptly. See LICENSE.txt for further details.

