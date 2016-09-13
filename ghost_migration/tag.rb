#!/usr/bin/env ruby

require 'sequel'
require 'awesome_print'

# Update specific slugs to have a specific tag

theme_slugs = ['comingsoon',
'add-theme',
'blog',
'rosette',
'friendly',
'huckleberry',
'mesquared',
'flatted',
'aeroplane',
'journalist',
'roboto',
'timeline',
'chroma',
'almera',
'eidolon',
'parade',
'typastic',
'inky-blog',
'chronicle',
'paper-pencil',
'kuntilanak',
'ghex',
'goody',
'bluebird',
'penoolis',
'demonstrate',
'justly',
'mono',
'aperture',
'uhuru',
'omikron',
'interstellar',
'helios',
'brasil',
'poly',
'magma',
'pastelico',
'bubble',
'vntg',
'flora',
'hardcover',
'eleni',
'responsive-flat',
'various',
'featured',
'hey',
'hypnotica',
'travelfly',
'gravity',
'ghost-diary',
'delicious',
'ghost-book',
'vision',
'activa',
'brave',
'flatina',
'mixmatch',
'blogging-story',
'annisa',
'word',
'trek',
'scarlet',
'aerology',
'red-dragon',
'mantanization',
'companion',
'superb',
'astro',
'interactive',
'heimdallr',
'chimira',
'mochi',
'hoar',
'authadox',
'baldr',
'bhoot',
'vernal',
'the-great-adventure',
'olymp2014',
'mjolnir',
'phantom_',
'plattan',
'nuevo',
'journal',
'yabu-no-naka',
'stories',
'dining-around',
'min',
'mobel',
'foto',
'echo',
'been-there',
'negative-space',
'message',
'path',
'royale',
'tophat',
'unblock',
'roux',
'lector',
'cardstock',
'kapow',
'wudan',
'pixl8',
'the-ranger',
'gadgetry',
'studio-lite',
'boots',
'glampagne',
'frosty',
'quill',
'grid-pulp',
'the-owl',
'big-talk',
'outlaw',
'supernova',
'icandy',
'sublime',
'ocean-leaf',
'rapture',
'earth',
'spacy',
'absolute',
'generous',
'deportivo',
'eskon',
'floro',
'launchramp',
'unique',
'artee',
'kcalb',
'cody',
'sreleque',
'typesome',
'digitus',
'snow',
'radon',
'ideam',
'higz',
'orca',
'wharton',
'longform-lite',
'rainier-lite',
'grand',
'oslo-lite',
'lytton-lite',
'readymade-lite',
'monument',
'summer',
'motret',
'isolde',
'yathra',
'purus',
'literary-materia',
'imaginary-material',
'alpha',
'boceto',
'readable',
'goblin',
'jrny',
'the-founder',
'stiky',
'wordsmith-masonry',
'exo',
'nightlight',
'hacker',
'anima',
'orbit',
'corpress',
'eston',
'gunter',
'aventurine',
'coastal',
'uno-zen',
'swan',
'beats',
'artisan',
'inspirio',
'solaris',
'ahab',
'astuto',
'atypix',
'exquisite',
'eva',
'kachilla',
'stup',
'kepriben',
'simplet',
'blogy',
'stone-clarity',
'pencraft',
'hoist-ghost',
'blogbox',
'naong-2',
'corvus',
'dw-timeline',
'ares',
'minto',
'journey',
'b',
'hybrid',
'kappas',
'coder',
'broken-heart',
'grave',
'mori',
'promenade',
'kraves',
'pellere',
'oni',
'start',
'peoples-media-theme',
'angsty',
'minimal',
'herald',
'type',
'coder-ghost-theme',
'glimmer',
'nectaria',
'aspire',
'fatso',
'odin',
'ghoststa',
'grey',
'triangle-ghost-theme',
'willow',
'mention',
'upholsterygeist',
'guapo',
'josephine',
'readlein',
'nerdy',
'moustachey',
'mots',
'heroic',
'yokai',
'fruity',
'toffee',
'curri',
'rain',
'fixy',
'penman',
'logbook',
'photosession',
'gridy',
'mason',
'stretch',
'zenzero',
'traveler',
'draugur',
'uno',
'ghost-hut',
'whisper',
'magnum',
'temple-of-faith',
'sticko',
'starter-ghost',
'rolls-royce',
'ghostbooty',
'orre',
'bootstrap-scroll',
'genius',
'the-shell',
'lesswords',
'pixelpusher',
'capsergray',
'safira',
'solar',
'my-journey',
'wondershot',
'pillar-of-faith',
'willsong',
'gonzague',
'incorporated',
'ghost-stories',
'wordsmith',
'xenon',
'ghostrayder',
'ghostwriter',
'tepid',
'ghostentista',
'swaze',
'gonnamake',
'glattony',
'biosvision',
'purity',
'n-coded',
'innocent',
'ghios7',
'ghostbacker',
'gavickpro',
'abstraction',
'readium',
'aside',
'krypton',
'bentley',
'landscape',
'scientific',
'blockster',
'steam',
'mnml',
'abc',
'saga',
'teller',
'ducentis',
'ghost-author',
'oak',
'futura',
'jass',
'crisp',
'starmap',
'tellus',
'placidity',
'ghostbox',
'cover',
'ascend',
'brage',
'rifyll',
'secret',
'fairytale',
'mapache',
'attila',
'quarter',
'suave',
'gamma',
'ghostwall',
'nonus',
'dragonfly',
'flaty',
'boston',
'ghostscroll',
'ghostium',
'casper',
'decode',
'slimpost',
'the-classy',
'bleak',
'monoid',
'caesar',
'codex',
'slider',
'marquis',
'vlevet',
'stack',
'privado',
'hit-the-road',
'kohi',
'fauxghost',
'blog-theme',
'interphase',
'ghostion',
'vapor',
'momentum',
'forest',
'sylva',
'curio',
'vasha']

theming_slugs = ['the-best-free-ghost-themes-january-2016',
'how-to-install-a-ghost-theme',
'easy-theme-development-with-sample-ghost-content',
'top-10-ghost-themes-december-2013',
'top-10-free-ghost-themes-december-2013',
'top-10-ghost-themes-for-photographers',
'best-two-column-ghost-themes-january-2014',
'best-single-column-ghost-themes',
'the-best-free-ghost-themes-february-2014',
'all-ghost-themes-the-complete-matrix-of-ghost-themes',
'top-10-best-ghost-themes-april-2014',
'how-to-setup-piwiks-custom-variables-in-ghost',
'15-high-quality-ghost-themes',
'why-there-are-so-many-ghost-themes-being-made',
'managing-your-ghost-theme-with-git',
'the-best-free-ghost-themes-january-2015',
'using-ghosts-navigation-feature',
'how-to-manage-common-resources-between-themes',
'nodebb-comments-on-ghost',
'how-to-add-a-menu-to-your-ghost-blog',
'have-a-static-home-page-with-ghost',
'how-to-add-google-analytics-to-ghost',
'how-to-enable-comments-on-a-ghost-blog',
'how-to-add-floating-share-buttons',
'how-to-add-a-favicon-to-your-ghost-blog',
'ghost-theme-structure',
'ghost-handlebars-overview',
'how-to-add-bootstrap-to-ghost',
'display-post-images-on-home-page',
'how-to-change-post-excerpt-length',
'how-to-embed-a-twitter-feed-into-ghost',
'how-to-add-a-search-box-to-your-ghost-blog',
'custom-error-page',
'using-sass-with-ghost',
'using-bower-with-ghost',
'add-post-tags-to-home-page',
'add-an-image-lightbox-to-ghost',
'adding-and-linking-to-jscss-assets',
'setup-code-injection',
'creating-partials-files',
'custom-featured-post-styling',
'custom-home-page',
'custom-static-pages',
'custom-tag-pages',
'custom-pagination',
'ghost-themes-overview',
'where-to-start-with-ghost-themes',
'what-is-handlebars',
'adding-search-to-ghost-using-ghosthunter',
'add-numbered-pagination-to-ghost',
'add-comments-to-ghost-using-livefyre',
'add-a-fixed-nav-menu-to-ghost',
'add-comments-to-ghost-using-facebook',
'add-a-fixed-sidebar-to-your-ghost-blog',
'add-search-to-ghost-using-swiftype',
'how-to-style-certain-posts-differently-using-tags',
'load-posts-dynamically-using-ghosts-api',
'how-to-add-posts-onto-a-static-page',
'move-featured-posts-to-the-top-of-your-blog',
'how-to-add-an-author-menu-to-your-blog',
'highlight-code-syntax-using-highlight-js',
'add-pagination-when-using-ghosts-public-api',
'how-to-add-a-tag-menu-to-your-blog',
'embed-an-instagram-feed-to-ghost',
'add-search-to-ghost-using-twitter-typeahead-js',
'how-to-add-an-author-menu-to-your-blog']

db = Sequel.connect("sqlite://ghost.db")


theme_slugs.each do |theme_slug|

	# get the post id so it can be assicaed to the tag
	post_id = db[:posts].select(:id).where(:slug=>theme_slug).first

	result = db[:posts_tags].insert(:post_id => post_id[:id], :tag_id => 130)

end

theming_slugs.each do |theming_slug|

	# get the post id so it can be assicaed to the tag
	post_id = db[:posts].select(:id).where(:slug=>theming_slug).first

	result = db[:posts_tags].insert(:post_id => post_id[:id], :tag_id => 131)

end


# Find all post ids that have a specific tag

# db = Sequel.connect("sqlite://ghost.db")

# ghost_tags = [ 'themes', 'theme', 'themes-2', 'theming' ]

# bad_tag_ids = []

# # find tag id of bad tags
# ghost_tags.each do |bad_tag|

# 	tags = db[:tags]
# 	bad_tag_ids << tags.select(:id).where(:slug=>bad_tag).first

# end

# # find all posts that are using these bad tags and list them out
# bad_tag_ids.each do |bad_tag_id|

# 	tags = db[:tags]
# 	slug = tags.select(:slug).where(:id=>bad_tag_id[:id]).first

# 	puts "\n\n\nFinding posts that are using tag: #{slug[:slug]}\n\n"

# 	posts_tags = db[:posts_tags]
# 	post_ids = posts_tags.select(:post_id).where(:tag_id=>bad_tag_id[:id]).all

# 	# print out the post slug from the post id
# 	post_ids.each do |post_id|

# 		posts = db[:posts]
# 		post_slugs = posts.select(:slug).where(:id=>post_id[:post_id]).first

# 		puts post_slugs[:slug]

# 	end

# end




# Add a tag to each site



# ids = {}

# ids['htig'] = 'install'
# ids['agt'] = 'themes'
# ids['gfb'] = 'beginners'
# ids['ht'] = 'blog'
# ids['aa'] = 'developer'

# ids.each do |k,v|

# 	puts "Working on adding tag #{v} to #{k}"

# 	db = Sequel.connect("sqlite://#{k}.db")

# 	# Get id of tag for this site
# 	tags = db[:tags]
# 	tag_id = tags.select(:id).where(:slug=>v).first

# 	puts "The tag id for #{v} is #{tag_id[:id]}"

# 	# Get all post ids from the post table
# 	posts = db[:posts]
# 	post_ids = posts.select(:id).all

# 	puts "Adding tag to #{post_ids.count} posts"

# 	# add entry into posts_tags
# 	post_ids.each do |post_id|

# 		# check and make sure post does not already have tag in posts_tags table
# 		tagged = false
# 		posts_tags = db[:posts_tags]
# 		post_tags = posts_tags.select(:tag_id).where(:post_id=>post_id[:id]).all

# 		post_tags.each do |post_tag|
# 			if post_tag[:tag_id] == tag_id[:id]
# 				tagged = true
# 			end
# 		end

# 		if tagged == true
# 			next
# 		end

# 		result = db[:posts_tags].insert(:post_id => post_id[:id], :tag_id => tag_id[:id])
# 	end

# 	puts "Work on #{v} is complete\n\n"
# end
