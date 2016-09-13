#!/usr/bin/env ruby

require 'sequel'
require 'awesome_print'
require 'thor'
require 'terminal-table'

DB = Sequel.connect('sqlite:///Users/aboutte/Desktop/ghost.db')

# returns and array of users
def user_owner?(id)
  # find the role id for owner
  owner_id = DB[:roles].select.where(:name=>'Owner').all[0][:id]

  # I am not sure if a user can have more than one roll so I am going to assume it can
  users_roles = DB[:roles_users].select.where(:user_id=>id).all
  users_roles.each do |users_role|
    if users_role[:role_id] == owner_id
      return true
    else
      next
    end
  end
  return false
end

# returns true or false whether the user is the owner or not
def user_exist?(id)
  DB[:users].select.where(:id=>id).all
end

def update_author(to_id, posts)
  count = 0
  posts.each do |post|
    DB[:posts].where(:id => post[:id]).update(:author_id => to_id)
    count += 1
  end

  puts "Updated #{count} posts"

end

class MyCLI < Thor
  desc 'list_users', 'List all Ghost users'
  def list_users()
    puts "\nListing all Ghost users\n\n"

    users = DB[:users]

    rows = []
    users.all.each do |user|
      rows << [user[:id], user[:name], user[:slug], user[:email]]
      rows << :separator
    end

    table = Terminal::Table.new
    table.title = 'Users'
    table.headings = %w(id name slug email)
    table.style = { 'width' => 150 }
    table.align_column(1, :right)
    rows.pop
    table.rows = rows
    puts table
  end

  option :to_id, :required => true, :type => :numeric, :desc => 'ID of user to migrate posts to', :banner => 'ID'
  option :from_id, :required => false, :type => :numeric, :desc => 'ID of user to migrate posts from', :banner => 'ID'
  desc 'update_posts', 'Update all posts to be owned by single user'
  def update_posts()

    to_id = options[:to_id]
    from_id = options[:from_id]

    puts "\nUpdating posts to be owned by #{to_id}\n\n"

    unless user_exist?(to_id).size == 1
      puts "Attempting to migrate posts to id #{to_id}, but id does not exist.  Exiting"
      abort
    end

    unless from_id.nil?
      unless user_exist?(from_id).size == 1
        puts "Attempting to migrate posts from id #{from_id}, but id does not exist or was not provided.  Exiting."
        abort
      end
    end

    # if we are migration all posts to a single user make sure that user is the owner
    # so that we can delete the rest of the users
    unless from_id
      unless user_owner?(to_id)
        puts "User id #{to_id} is not the owner.  Make #{to_id} the owner and rerun script.  Exiting."
        abort
      end
    end

    if from_id.nil?
      # if from_id is nil we want to select the entore posts table
      query = true
    else
      # setup the database query if we are migrating from from_id
      query = { :author_id=>from_id }
    end


    # build list of posts based on from_id
    posts = DB[:posts].select.where(query).all
    update_author(to_id, posts)
  end
end


MyCLI.start(ARGV)
