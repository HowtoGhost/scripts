#!/usr/bin/env ruby

require 'selenium-webdriver'
require 'awesome_print'
require 'sitemap-parser'

url = "https://www.ghostforbeginners.com/sitemap-posts.xml"

sitemap = SitemapParser.new url
links = sitemap.to_a

driver = Selenium::WebDriver.for :firefox

# first log into nodebb
nodebb_url = 'https://community.ghostforbeginners.com/login'
username = 'GhostforBeginners'
password = ENV['NODEBB_PASSWORD']

driver.navigate.to nodebb_url
username_element = driver.find_element(:id, "username")
username_element.send_keys username
password_element = driver.find_element(:id, "password")
password_element.send_keys password
driver.find_element(:id, "login").click;

sleep 15

counter = 0

links.each do |link|
	puts "Working on (#{counter}/#{links.count}): #{link}"
	begin
		driver.navigate.to link
	rescue => e
		puts "Exception (likely a readtimeout): #{e}"
	end
	sleep 2
	begin # Too lazy to figure out how to detect if the element is on the page
		element = driver.find_element(:class, 'btn-primary')
		element.click
	rescue => e
		puts "Exception (likely could not find element): #{e}"
	end
	counter = counter + 1
end
