# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pg_foreign_keys/version'

Gem::Specification.new do |gem|
  gem.name          = 'pg_foreign_keys'
  gem.version       = PgForeignKeys::VERSION
  gem.authors       = ['chamnap']
  gem.email         = ['chamnapchhorn@gmail.com']
  gem.description   = %q{Provides supports on using postgres array as foreign keys}
  gem.summary       = %q{Uses postgres array element as foreign keys}
  gem.homepage      = 'https://github.com/chamnap/pg_foreign_keys'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_development_dependency 'bundler'
  gem.add_development_dependency 'rspec', '~> 2.12.0'
  gem.add_development_dependency 'factory_girl', '~> 4.1.0'
  gem.add_development_dependency 'pg'
  gem.add_development_dependency 'postgres_ext'
  gem.add_development_dependency 'pry'
  gem.add_dependency 'activerecord', '~> 3.2'
  gem.add_dependency 'pg'
end
