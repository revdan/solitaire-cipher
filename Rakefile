require 'rspec/core/rake_task'
require './lib/solitaire_cipher'
RSpec::Core::RakeTask.new('spec')

desc "Run tests"
task :default => :spec

desc "Encrypts a message to secret code"
task :encrypt do
  message = ARGV[1]
	key = ARGV[2]
  puts SolitaireCipher::Cipher.new(message, key).encrypt
	task message.to_sym do ; end
	task key.to_sym {} unless key.nil?
end

desc "Decrypts a secret message"
task :decrypt do
  message = ARGV[1]
	key = ARGV[2]
  puts SolitaireCipher::Cipher.new(message, key).decrypt
	task message.to_sym do ; end
	task key.to_sym {} unless key.nil?
end