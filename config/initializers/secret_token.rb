# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
Prelaunchr::Application.config.secret_token = ENV["RAILS_SECRET"] || '440f7636ae425bea2ee75ea7ba7ca0b304cfb7c7df9a809dc1d9d319927a86845dfac11ee6bea2b83597e40e435713b09c33654a3957188e34075a44dfb55ec8'
