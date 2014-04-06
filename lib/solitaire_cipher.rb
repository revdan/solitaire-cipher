module SolitaireCipher
  require_relative 'cipher'
  require_relative 'deck'

  ORDERED_DECK = ((1..52).to_a << :A << :B).freeze
  ALPHABET = Hash[('A'..'Z').to_a.zip (1..26)].freeze

end
