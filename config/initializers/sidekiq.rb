Sidekiq.configure_server do |config|
  config.redis = {
    url: ENV.fetch("REDIS_URL") { "redis://localhost" },
    namespace: "sidekiq_nota_#{Rails.env}",
  }
end

Sidekiq.configure_client do |config|
  config.redis = {
    url: ENV.fetch("REDIS_URL") { "redis://localhost" },
    namespace: "sidekiq_nota_#{Rails.env}",
  }
end
