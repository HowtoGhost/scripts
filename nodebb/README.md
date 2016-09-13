# Migrating Comments to NodeBB

## Summary

We recently wanted to switch to having NodeBB manage our comments.  Using some NodeBB code it is pretty easy to have new posts comments end up in NodeBB.  We used this script to make NodeBB aware of our existing posts.

## Setup

    cd nodebb
    bundle install
    $ bundle exec ./nodebb.rb

## What it Does

The script starts out by pulling ghostforbeginners.com/sitemap-posts.xml to get the list of our existing posts.  Next we fire up FireFox using Selenium to log into our NodeBB installation so that we can add posts to it.  

Once we have those two initial setup tasks done we can iterate over the list of posts.  For each post up it in FireFox and click the button to add the URL into NodeBB
