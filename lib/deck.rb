module SolitaireCipher
  class Deck
    attr_accessor :deck

    ORDERED_DECK = ((1..52).to_a << :A << :B).freeze

    def initialize
      @deck = ORDERED_DECK.dup
    end

    def move(card)
      index = @deck.index(card)
      if index < 53
        @deck[index], @deck[index + 1] = @deck[index + 1], @deck[index]
      else
        @deck = @deck[0,1] + @deck[-1,1] + @deck[1..-2]
      end
      @deck
    end

    def triple_cut
      top, bottom = joker_positions.min, joker_positions.max
      @deck = @deck[(bottom+1)..-1] + @deck[top..bottom] + @deck[0...top]
    end

    def count_cut
      count = number_value(@deck[-1])
      @deck = @deck[count..-2] + @deck[0,count] + @deck[-1,1]
    end

    def output_letter
      value = number_value(@deck.first)
      card = @deck[value]
      if card && !joker?(card)
        return ALPHABET.invert[alphabet_value(card)]
      end
    end

    def joker?(card)
      !!([:A,:B].include? card )
    end

    def joker_positions
      [@deck.index(:A), @deck.index(:B)]
    end

    def number_value(x)
      return 53 if joker?(x)
      return x
    end

    def alphabet_value(x)
      x > 26 ? x % 26 : x
    end
  end
end