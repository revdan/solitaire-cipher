require 'spec_helper'
require_relative '../lib/solitaire_cipher'

describe SolitaireCipher::Cipher do
  let(:message) { "Code in Ruby, live longer!2"  }
  let(:cipher) { SolitaireCipher::Cipher.new(message) }

  it "takes a message as a parameter" do
    expect(cipher.message).to eq message
  end

  describe "#encrypt" do

  end

  describe "#sanitize" do
    context "when the number of letters is divisible by 5" do
      it "strips non-letter characters and upcases them" do
        expect(cipher.sanitize(message)).to eq "CODEINRUBYLIVELONGER"
      end
    end

    context "when the letters are not neatly divisible by 5" do
      it "pads the remainder with X's" do
        message =  "Code in Ruby, live long"
        cipher = SolitaireCipher::Cipher.new(message)
        expect(cipher.sanitize(message)).to eq "CODEINRUBYLIVELONGXX"
      end
    end
  end

  describe '#map_to_numbers' do
    it "splits a string into an array of its letters and maps it to its position in the alphabet" do
      letters = cipher.sanitize(message)
      expect(cipher.map_to_numbers(letters)).to eq [3, 15, 4, 5, 9, 14, 18, 21, 2, 25, 12, 9, 22, 5, 12, 15, 14, 7, 5, 18]
    end
  end

  describe '#add' do
    it 'takes two arrays of integers and then adds each  member corresponding by index' do
      message = [3, 15, 4, 5, 9, 14, 18, 21, 2, 25, 12, 9, 22, 5, 12, 15, 14, 7, 5, 18]
      keystream = [4, 23, 10, 24, 8, 25, 18, 6, 4, 7, 20, 13, 19, 8, 16, 21, 21, 18, 24, 10]
      expect(cipher.add(message, keystream)).to eq [7, 12, 14, 3, 17, 13, 10, 1, 6, 6, 6, 22, 15, 13, 2, 10, 9, 25, 3, 2]
    end
  end

  describe '#subtract' do
    it 'takes two arrays of integers and then subtracts each  member corresponding by index' do
      message = [7, 12, 14, 3, 17, 13, 10, 1, 6, 6, 6, 22, 15, 13, 2, 10, 9, 25, 3, 2 ]
      keystream = [4, 23, 10, 24, 8, 25, 18, 6, 4, 7, 20, 13, 19, 8, 16, 21, 21, 18, 24, 10]
      expect(cipher.subtract(message, keystream)).to eq [3, 15, 4, 5, 9, 14, 18, 21, 2, 25, 12, 9, 22, 5, 12, 15, 14, 7, 5, 18]
    end
  end


  describe '#map_to_letters' do
    it "takes an array of integers and turns to letters based on corresponding position in alphabet" do
      combined_message = [7, 12, 14, 3, 17, 13, 10, 1, 6, 6, 6, 22, 15, 13, 2, 10, 9, 25, 3, 2]
      expect(cipher.map_to_letters(combined_message)).to eq "GLNCQMJAFFFVOMBJIYCB"
    end
  end

  describe '#generate_keystream' do
    it "uses Deck to make an encryption key" do
      expect(cipher.generate_keystream(10)).to eq "DWJXHYRFDG"
    end

    it "doesn't fuck up with a large message for some unknown fucking reason" do
      expect(cipher.generate_keystream(25)).to eq "DWJXHYRFDGTMSHPUURXJYWYHC"
      expect(cipher.generate_keystream(25).length).to eq  25
    end

  end
end
