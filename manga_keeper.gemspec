Gem::Specification.new do |s|
    s.name        = 'manga-keeper'
    s.version     = '0.1.0'
    s.licenses    = ['MIT']
    s.summary     = "Manga Keeper!"
    s.description = "Keep track of managa release"
    s.authors     = ["Ryochi Tanaka"]
    s.email       = 'ryo1.t.zubu@gmail.com'
    s.files       = [
      "lib/manga_keeper.rb",
      "lib/manga-keeper/manga.rb",
      "lib/manga-keeper/cli.rb",
      "lib/manga-keeper/scraper.rb"
    ]
    s.homepage    = 'https://rubygems.org/gems/manga-keeper'
    s.metadata    = { "source_code_uri" => "https://github.com/example/manga-keeper" }
  end