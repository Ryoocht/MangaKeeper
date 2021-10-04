require 'open-uri'
require 'nokogiri'
require 'date'
require 'tty-prompt'
# require 'bundler/setup'
# require 'rake'
# require 'active_record'

# Bundler.require

# ActiveRecord::Base.establish_connection(
#     :adapter => "sqlite3",
#     :database => "db/favourite.sqlite"
# )

# DB = ActiveRecord::Base.connection

# require_relative '../models/favourite.rb'
require_relative '../lib/manga_keeper.rb'
require_relative '../lib/manga/genre_manga.rb'
require_relative '../lib/manga/genre.rb'
require_relative '../lib/manga/list.rb'
require_relative '../lib/manga/manga.rb'
require_relative '../lib/manga/series.rb'
require_relative '../lib/scraping/book_scraper.rb'
require_relative '../lib/search/search_manga.rb'
require_relative '../lib/cli.rb'