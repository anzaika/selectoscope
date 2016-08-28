# Detects the current version of Rails that is being used
#
#
RAILS_VERSION_FILE ||= File.expand_path("../../../.rails-version", __FILE__)

unless defined? TRAVIS_CONFIG
  require 'yaml'
  filename = File.expand_path("../../../.travis.yml", __FILE__)
  TRAVIS_CONFIG = YAML.load_file filename
  TRAVIS_RAILS_VERSIONS = TRAVIS_CONFIG['env']['matrix'].grep(/RAILS=(.*)/){ $1 }.map{ |v| v.delete('"') }
end

DEFAULT_RAILS_VERSION ||= TRAVIS_RAILS_VERSIONS.last

def detect_rails_version
  version = version_from_file || ENV['RAILS'] || DEFAULT_RAILS_VERSION
ensure
  puts "Detected Rails: #{version}" if ENV['DEBUG']
end

def detect_rails_version!
  detect_rails_version or raise "can't find a version of Rails to use!"
end

def version_from_file
  if File.exists?(RAILS_VERSION_FILE)
    version = File.read(RAILS_VERSION_FILE).chomp.strip
    version unless version == ''
  end
end

def write_rails_version(version)
  File.open(RAILS_VERSION_FILE, "w+"){|f| f << version }
end
