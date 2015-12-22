require 'redis'
redis = Redis.new(:path => "test.db")
redis.set("moun","hi da")
puts redis.get("moun")