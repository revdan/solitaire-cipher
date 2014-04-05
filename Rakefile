require 'rspec/core/rake_task'
require './lib/solitaire_cipher'
RSpec::Core::RakeTask.new('spec')

#TODO Clean up specs
desc "Run tests"
task :default => :spec

desc "Encrypts a message to secret code"
task :encrypt do
  message = ARGV.last
  puts SolitaireCipher::Cipher.new(message).encrypt
	task message.to_sym do ; end
end

desc "Decrypts a secret message"
task :decrypt do
  message = ARGV.last
  puts SolitaireCipher::Cipher.new(message).decrypt
	task message.to_sym do ; end
end