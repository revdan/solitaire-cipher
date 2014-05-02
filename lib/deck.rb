module SolitaireCipher
  class Deck
    attr_accessor :deck

    def initialize
      @deck = ORDERED_DECK.dup
    end

    def key_deck_with(secret)
      secret.chars.each do |letter|
        move(:A)
        2.times { move(:B) }
        triple_cut
        count_cut
        count_cut(ALPHABET[letter])
      end
      deck
    end

    def key_deck
      move(:A)
      2.times { move(:B) }
      triple_cut
      count_cut
      deck
    end

    def generate_keystream(length, secret = nil)
      key_deck_with(secret) unless secret.nil?
      keystream = []
      while keystream.length < length
        key_deck
        keystream << output_letter unless output_letter.nil?
      end
      keystream.join
    end

    def move(card)
      index = deck.index(card)
      index < 53 ? move_down(index) : move_to_top
      deck
    end

    def move_down(index)
      @deck[index], @deck[index + 1] = deck[index + 1], deck[index]
    end

    def move_to_top
      @deck = deck[0,1] + deck[-1,1] + deck[1..-2]
    end

    def triple_cut
      top, bottom = joker_positions.min, joker_positions.max
      @deck = deck[(bottom+1)..-1] + deck[top..bottom] + deck[0...top]
    end

    def count_cut(position = nil)
      count = position.nil? ? number_value(deck[-1]) : position
      @deck = deck[count..-2] + deck[0,count] + deck[-1,1]
    end

    def output_letter
      card = deck[number_value(deck.first)]
      ALPHABET.invert[alphabet_value(card)] unless joker?(card)
    end

    def joker?(card)
      [:A,:B].include?(card)
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
