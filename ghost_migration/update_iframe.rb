#!/usr/bin/env ruby

require 'sequel'
require 'awesome_print'

db = Sequel.connect("sqlite://iframe.db")

theme_post_tags = db[:posts_tags].filter(:tag_id => '130')

theme_post_tags.all.each do |theme_post_tag|

	theme_post_ids = theme_post_tag[:post_id]

	theme_post_ids = db[:posts].filter(:id => theme_post_ids)

	theme_post_ids.each do |theme_post_id|

		id = theme_post_id[:id]
		slug = theme_post_id[:slug]
		html = theme_post_id[:html]
		markdown = theme_post_id[:markdown]

		puts html

		# html - <iframe class="themedemo" src="
		# markdown - <iframe class="themedemo" src="
		updated_markdown = markdown.gsub('<iframe class="themedemo" src="','<iframe class="themedemo" src="https://iframe.ghostforbeginners.com/index.php/')
		updated_html = html.gsub('<iframe class="themedemo" src="','<iframe class="themedemo" src="https://iframe.ghostforbeginners.com/index.php/')

		# theme_post_ids.where('id = ?', id).update(:html => updated_html)
	end
end
