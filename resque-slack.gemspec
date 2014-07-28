# -*- encoding: utf-8 -*-
$LOAD_PATH.push File.expand_path('../lib/resque/failure', __FILE__)
require 'slack'

Gem::Specification.new do |s|
  s.name        = 'resque-slack'
  s.version     = '0.1.0'
  s.authors     = ['Julien Blanchard']
  s.email       = ['julien@sideburns.eu']
  s.homepage    = 'https://www.github.com/julienXX/resque-slack'
  s.summary     = %q{Post Slack notifications whenever one of your Resque jobs fails}
  s.description = %q{Slack notifications for your failed jobs}

  s.rubyforge_project = 'resque-slack'
  s.has_rdoc          = false

  s.files             = %w(LICENSE Rakefile README.markdown)
  s.files            += Dir.glob('{spec/*,lib/**/*}')
  s.require_paths     = ['lib']

  s.add_runtime_dependency('resque', '>= 1.8')
  s.add_development_dependency('rake')
end
