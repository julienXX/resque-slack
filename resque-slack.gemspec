# -*- encoding: utf-8 -*-
$LOAD_PATH.push File.expand_path('../lib/resque/failure', __FILE__)
require 'slack'

Gem::Specification.new do |s|
  s.name        = 'resque-slack'
  s.version     = Resque::Failure::Slack::Version
  s.authors     = ['Julien Blanchard']
  s.email       = ['julien@sideburns.eu']
  s.homepage    = 'https://www.github.com/julienXX/resque-slack'
  s.summary     = %q{Post Slack notifications whenever one of your Resque jobs fails}
  s.description = %q{Slack notifications for your failed jobs}

  s.rubyforge_project = 'resque-slack'

  s.files         = `git ls-files`.split('\n')
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split('\n')
  s.executables   = `git ls-files -- bin/*`.split('\n').map { |f| File.basename(f) }
  s.files         += Dir.glob('lib/**/*')
  s.files         += Dir.glob('spec/**/*')

  s.add_development_dependency 'rake'
end
