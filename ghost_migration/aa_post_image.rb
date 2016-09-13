#!/usr/bin/env ruby

require 'sequel'
require 'awesome_print'

db = Sequel.connect("sqlite:///Users/aboutte/Documents/Dropbox/Ghost_Project/ghost_migration/aa_post_image.db")

posts = db[:posts]
posts.all.each do |post|

	# Check and see if the post is a theme post

	post_tags = db[:posts_tags].select().where(:post_id=>post[:id]).all

	post_tags.each do |post_tag|
		if post_tag[:tag_id] == 130

			ap post


			id = post[:id]
			slug = post[:slug]
			image = post[:image]

			puts "Working on #{id} #{slug} with image set to #{image}"
			result = db[:posts].where(:id => id).update(:image => "/content/themes/allghostthemes/assets/images/#{slug}.jpg")
		end
	end
end
