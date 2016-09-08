require 'open-uri'
require 'json'
require 'csv'
require 'active_support/all'
require 'zip'

module GeoNamesAPI

  mattr_accessor :url
  self.url = 'http://api.geonames.org/'

  mattr_accessor :lang
  self.lang = :en
  
  mattr_accessor :username
  self.username = 'demo'

  mattr_accessor :token
  self.token = nil

  mattr_accessor :style
  self.style = :full

  mattr_accessor :logger
  self.logger = nil

  mattr_accessor :retries
  self.retries = 5

  mattr_accessor :max_sleep_time_between_retries
  self.max_sleep_time_between_retries = 10

  def self.params
    {
      lang: lang,
      username: username,
      token: token,
      style: style
    }.delete_if{ |k, v| v.blank? }
  end
    
end

require 'geonames_api/version' # explicit require version file because it doesn't contain any class which can be autoload
require 'geonames_api/error' # explicit require error file because it defines several other classes that won't be autoloaded
Dir[File.dirname(__FILE__) + '/geonames_api/*.rb'].each do |file|
  tgt = File.basename(file, File.extname(file))
  GeoNamesAPI.autoload tgt.camelize, "geonames_api/#{tgt}"
end
