# Ghost Remove Users

### Summary

This script can be used to manage the users in Ghost.  It has two functions: list users, and update author of posts.

## Setup

    cd ghost_remove_users
    bundle install
    $ bundle exec ./remove_users.rb
    Commands:
        remove_users.rb help [COMMAND]           # Describe available commands or one specific command
        remove_users.rb list_users               # List all Ghost users
        remove_users.rb update_posts --to-id=ID  # Update all posts to be owned by single user

## Usage

### list_users

The list users function is as simple as it sounds, it will output a table of your existing users.  The important piece of information here is the users ID.

    $ bundle exec ./remove_users.rb list_users

    Listing all Ghost users

    +--------------------------+-----------------------------------+-----------------------------------+-------------------------------------------------+
    |                                                                       Users                                                                        |
    +--------------------------+-----------------------------------+-----------------------------------+-------------------------------------------------+
    | id                       | name                              | slug                              | email                                           |
    +--------------------------+-----------------------------------+-----------------------------------+-------------------------------------------------+
    | 1                        | test                              | test                              | example@gmail.com                               |
    +--------------------------+-----------------------------------+-----------------------------------+-------------------------------------------------+
    | 2                        | Andy Boutte                       | andy-boutte                       | example@allaboutghost.com                       |
    +--------------------------+-----------------------------------+-----------------------------------+-------------------------------------------------+
    | 3                        | david                             | david                             | example@allaboutghost.com                       |
    +--------------------------+-----------------------------------+-----------------------------------+-------------------------------------------------+
    | 4                        | Info                              | info-2                            | example@allaboutghost.com                       |
    +--------------------------+-----------------------------------+-----------------------------------+-------------------------------------------------+

### update_posts

update_posts has two capabilities.  The default option is to migrate all posts to the provided user ID.  The second option is to migrate all posts for a single user to another user.

#### migrating all posts to single user

    $ bundle exec ./remove_users.rb update_posts --to-id 1

    Updating posts to be owned by 1

    Updated 105 posts

#### migrating posts of single user to another user

    $ bundle exec ./remove_users.rb update_posts --to-id 1 --from-id 4

    Updating posts to be owned by 1

    Updated 15 posts
