module Lovers
  class Request
    SET_KEY = name.split('::').last.uncapitalize.pluralize
    # attr_accessor :rid, :uid, :tid # relationship_id, user_id, target_id

    def initialize(rid, uid, tid)
      @rid, @uid, @tid = rid, uid, tid
    end

    def self.create(rid, uid, tid)
      self.new(rid, uid, tid).tap { |r| r.save }
    end

    # Save the request to Redis.
    # requestsSent are never shown, but we may show them in the future.
    def save
      now = Time.now.to_i
      Lovers.redis.zadd("#{@uid}:#{SET_KEY}Sent", now, @rid+'|'+@tid)
      Lovers.redis.zadd("#{@tid}:#{SET_KEY}Received", now, @rid+'|'+@uid)
    end
  end
end
