source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.6.5"

gem "bcrypt", "~> 3.1.7"
gem "bootsnap", ">= 1.4.2", require: false
gem "dotenv-rails"
gem "graphql-batch"
gem "jwt"
gem "pg", ">= 0.18", "< 2.0"
gem "puma", "~> 3.12"
gem "rails", "~> 6.0.0"
gem "rack-cors"
gem "redis-namespace"
gem "rubocop"
gem "searchkick"
gem "sentry-raven"
gem "sidekiq"

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "factory_bot_rails"
  gem "faker"
  gem "rspec-rails", "~> 3.8"
  gem "standard"
  gem "spring-commands-rspec"
end

group :development do
  gem "graphiql-rails"
  gem "graphql", "~> 1.9", ">= 1.9.3"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

group :test do
  gem "shoulda-matchers"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
