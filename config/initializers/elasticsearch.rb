Searchkick.aws_credentials = {
  url: ENV['ELASTICSEARCH_URL'],
  access_key_id: ENV['AWS_ACCESS_KEY'],
  secret_access_key: ENV['AWS_SECRET_KEY'],
  region: 'us-east-1'
} if Rails.env == "production"
