module SolitaireCipher
  class Deck
    attr_accessor :deck

    ORDERED_DECK = ((1..52).to_a << :A << :B).freeze

    def initialize
      @deck = ORDERED_DECK.dup
    end

    def key(key)
      key.chars.each do |letter|
        move(:A)
        2.times { move(:B) }
        triple_cut
        count_cut
        count_cut(ALPHABET[letter])
      end
    end

    def move(card)
      index = deck.index(card)
      if index < 53
        @deck[index], @deck[index + 1] = deck[index + 1], deck[index]
      else
        @deck = deck[0,1] + deck[-1,1] + deck[1..-2]
      end
      deck
    end

    def triple_cut
      top, bottom = joker_positions.min, joker_positions.max
      @deck = deck[(bottom+1)..-1] + deck[top..bottom] + deck[0...top]
    end

    def count_cut(number = nil)
      count = number.nil? ? number_value(deck[-1]) : number
      @deck = deck[count..-2] + deck[0,count] + deck[-1,1]
    end

    def output_letter
			card = deck[number_value(deck.first)]
      ALPHABET.invert[alphabet_value(card)] if card && !joker?(card)
    end

    def joker?(card)
      !!([:A,:B].include? card )
    end

    def joker_positions
      [deck.index(:A), deck.index(:B)]
    end

    def number_value(x)
      joker?(x) ? 53 : x
    end

    def alphabet_value(x)
      x > 26 ? x % 26 : x
    end
  end
end