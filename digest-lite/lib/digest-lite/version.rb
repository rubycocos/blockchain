

module Digestlite
  MAJOR = 0
  MINOR = 0
  PATCH = 1
  VERSION = [MAJOR,MINOR,PATCH].join('.')

  def self.version
    VERSION
  end

  def self.banner
    "digest-lite/#{VERSION} on Ruby #{RUBY_VERSION} (#{RUBY_RELEASE_DATE}) [#{RUBY_PLATFORM}] in (#{root})"
  end

  def self.root
    File.expand_path( File.dirname(File.dirname(File.dirname(__FILE__))) )
  end

end # module Digestlite

