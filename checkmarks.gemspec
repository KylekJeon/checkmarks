Gem::Specification.new do |s|
  s.name            = 'checkmarks'
  s.version         = '0.1.1'
  s.summary         = %q{Allows control of seen/unseen states of ActiveRecord objects}
  s.description     = %q{This gem allows you to track the seen/unseen status between ActiveRecord objects and user objects}
  s.authors         = ["Kyle Jeon"]
  s.email           = 'kylekjeon@gmail.com'
  s.files           = ["lib/checkmarks.rb"]
  s.homepage        = 'https://github.com/KylekJeon/checkmarks'
  s.licenses        = ['MIT'] 

  s.add_dependency 'activerecord', '>= 3'

  s.add_development_dependency 'bundler'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'mysql2'
  s.add_development_dependency 'pg'
  s.add_development_dependency 'rspec'
end