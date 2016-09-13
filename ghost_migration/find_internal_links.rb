#!/usr/bin/env ruby

require 'sequel'
require 'awesome_print'

db = Sequel.connect("sqlite:///Users/aboutte/Documents/Dropbox/Ghost_Project/ghost_migration/aa_post_image.db")

posts = db[:posts]
posts.all.each do |post|
	# Check and see if the post is a theme post
	if post[:html].include?('ghostforbeginners.com')
		puts "slug: #{post[:slug]} has internal link to gfb"
	end
end
