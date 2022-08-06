IEX::Api.configure do |config|
    config.publishable_token = 'pk_06247b956fca45988fd032214a8af0ac' # defaults to ENV['IEX_API_PUBLISHABLE_TOKEN']
    config.secret_token = 'sk_43eb42d21f6b40558a2c08de4619c5de' # defaults to ENV['IEX_API_SECRET_TOKEN']
    config.endpoint = 'https://cloud.iexapis.com/v1' # use 'https://sandbox.iexapis.com/v1' for Sandbox
end