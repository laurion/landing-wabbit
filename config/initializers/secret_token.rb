# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
Prelaunchr::Application.config.secret_token = ENV["RAILS_SECRET"] || '0d2616b7b4451b8dec3066abd0d4aa525e81e6846678da0da44304c78aadb8b41d40ee67887415f195d641fccbec956b4cbc0a4469500aeb80dcef3bc6f8bea2'
