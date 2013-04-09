redis_raw = Redis.new(:host => "localhost", :port => 6379)
$redis = Redis::Namespace.new(:ns, :redis => redis_raw)
