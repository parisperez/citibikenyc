Rails.application.config.middleware.use OmniAuth::Builder do
  provider :stripe_connect, ENV['STRIPE_CONNECT_CLIENT_ID'], ENV['STRIPE_SECRET_KEY']
  # provider :stripe_connect, ENV['ca_3RZ0OElaKpf5Q7kO3mLZTtiT1hHyBWPg'], ENV['sk_test_tpq7oUZzfNAPjyzD5E8Nln0I']
end