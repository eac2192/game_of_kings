class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  $redis_raw = Redis.new(:host => "10.0.1.1", :port => 6379)
  $redis = Redis::Namespace.new(:ns, :redis => $redis_raw)

  def redis
    Redis.new(:host => "10.0.1.1", :port => 6380)
  end
end
