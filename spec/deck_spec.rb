require 'spec_helper'
require_relative '../lib/solitaire_cipher'

describe SolitaireCipher::Deck do
  let(:deck) { SolitaireCipher::Deck.new }
  let(:cards) { SolitaireCipher::ORDERED_DECK }

  it "initializes a deck" do
    expect(deck.deck).to eq cards
  end

  describe "#key" do
    it "keys the deck once" do
      deck.deck = cards.dup

      expect(deck.key).to eq [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, :A, :B, 1]
      expect(deck.key).to eq [51, :A, 1, :B, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 52]
    end
  end

  describe "#key_with" do
    it "keys the deck using the secret" do
      deck.deck = cards.dup

      deck.key_with('a')
      expect(deck.deck).to eq [3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, :A, :B, 2, 1]
    end
  end

  describe "#move" do
    it "cycles the card at the index one position to the right" do
      expect(deck.move(:A)).to eq [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, :B, :A]
    end

    it "cycles the last card back to first position" do
      expect(deck.move(:B)).to eq [1, :B, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, :A]
    end
  end

  describe "#triple_cut" do
    it "cuts the deck on the position of the two jokers" do
      deck.deck = [1,:B, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, :A, 52]

    expect(deck.triple_cut).to eq [52, :B, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, :A, 1]
    end
  end

  describe "#count_cut" do
    it "takes the value of the bottom card and cuts that number of cards off the top of the deck inserting them above the bottom card" do
      deck.deck = [:B, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, :A, 1]

      expect(deck.count_cut).to eq [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, :A, :B, 1]
    end

    it "can take an argument about where to cut" do
      deck.deck = [:B, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, :A, 1]

      expect(deck.count_cut(3)).to eq [4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, :A, :B, 2, 3, 1]
    end
  end

  describe "#output_letter" do
    it "uses the value of the first card on top of the deck and then counts down that many cards and converts the card to a letter" do
     deck.deck = [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, :A, :B, 1]
      expect(deck.output_letter).to eq 'D'
      deck.key
      expect(deck.output_letter).to eq 'W'
    end

    it "handles cards bigger than 26" do
      deck.deck = [31, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, :A, :B, 1]
      expect(deck.output_letter).to eq 'G'
    end

    it "skips Jokers" do
       deck.deck = [52, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, :A, :B, 1]
      expect(deck.output_letter).to eq nil
    end
  end

  describe "#joker?" do
    it "returns true for a joker card" do
      deck.deck = cards.dup
      expect(deck.joker?(deck.deck.last)).to eq true
    end

    it "returns false for a regular card" do
      deck.deck = cards.dup
      expect(deck.joker?(deck.deck.first)).to eq false
    end
  end

  describe "#joker_positions" do
    it "returns an array with the current positions of the jokers" do
      deck.deck = cards.dup
      expect(deck.joker_positions).to eq [52,53]

      deck.key
      expect(deck.joker_positions).to eq [51,52]
    end
  end

  describe "#number_value" do
    it "returns the numeric value of the card" do
      deck.deck = cards.dup
      expect(deck.number_value(1)).to eq 1
    end

    it "returns 53 for either joker" do
      deck.deck = cards.dup
      expect(deck.number_value(:A)).to eq 53
      expect(deck.number_value(:B)).to eq 53
    end
  end

  describe "#alphabet_value" do
    it "returns the same number when between 1 and 26" do
      expect(deck.alphabet_value(12)).to eq 12
    end

    it "returns the number minus 26 when above 26" do
      expect(deck.alphabet_value(30)).to eq 4
    end
  end
end
