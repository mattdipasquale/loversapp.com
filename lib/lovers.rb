require 'redis'    # store users, requests, relationships, etc.
require 'json'     # JSON decode/encode request params & responses
require 'logger'   # log errors
require 'facebook' # add a Facebook app

module Lovers
  class << self
    def redis
      @@redis ||= if env == "production" || env == "staging"
        uri = URI.parse(ENV["REDISTOGO_URL"])
        Redis.new({
          host: uri.host,
          port: uri.port,
          password: uri.password
        })
      elsif env == "cucumber"
        Redis.new(port: 6398)
      elsif env == "test"
        Redis.new(port: 6397)
      else
        Redis.new(port: ENV["REDIS_PORT"])
      end
    end

    def facebook
      @@facebook ||= Facebook.new({
        id: Lovers::Conf.fb_app_id,
        secret: Lovers::Conf.fb_app_secret,
        canvas_name: Lovers::Conf.fb_canvas_name,
        canvas_url: Lovers::Conf.host + Lovers::Conf.fb_canvas_path
      })
    end

    def host
      @@host ||= Lovers::Conf.host
    end

    def root
      @@root ||= File.expand_path(File.join("..", ".."), __FILE__)
    end

    def env
      @@env = ENV["RACK_ENV"] || "development"
    end

    def logger
      @@logger ||= nil
    end

    def logger=(logger)
      @@logger = logger
    end
  end
end

require 'lovers/conf'
require 'lovers/errors'
require 'lovers/user'
require 'lovers/relationship'
require 'lovers/gift'
require 'lovers/application'
