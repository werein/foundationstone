$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'foundationstone/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'foundationstone'
  s.version     = Foundationstone::VERSION
  s.authors     = ['Jiri Kolarik']
  s.email       = ['jiri.kolarik@imin.cz']
  s.homepage    = 'http://werein.github.io/engines/foundationstone'
  s.summary     = 'Starter Rails application engine.'
  s.description = 'Keep default applications behavior in one place.'

  s.files = Dir['{app,config,db,lib}/**/*', 'LICENSE.txt', 'Rakefile', 'README.md']
  s.test_files = Dir['test/**/*']

  s.add_dependency 'rails', '~> 4.0.0'
  s.add_dependency 'rails-i18n', '~> 4.0'
  s.add_dependency 'meta-tags'
  s.add_dependency 'route_translator', '3.1.0' # 3.2 raise error

  s.add_development_dependency 'tuberack'
  s.add_development_dependency 'rails_admin'
  s.add_development_dependency 'bootstrap-sass'
  s.add_development_dependency 'sass-rails', '~> 4.0.2'
end
