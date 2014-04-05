module SolitaireCipher
  ALPHABET = Hash[('A'..'Z').to_a.zip (1..26)].freeze

  class Cipher
    attr_reader :message

    def initialize(message)
      @message = message
    end

    def encrypt
      letters = sanitize
      message = map_to_numbers(letters)
      keystream = map_to_numbers(generate_keystream(letters.length))
      combination = combine_message(message, keystream)
      hash = map_to_letters(combination)
      output(hash)
    end

    def decrypt
      letters = sanitize
      message = map_to_numbers(letters)
      keystream = map_to_numbers(generate_keystream(letters.length))
      combination = uncombine_message(message, keystream)
      hash = map_to_letters(combination)
      output(hash)
    end

    def sanitize
      message.upcase
      .gsub(/[^A-Z]/, "")
      .scan(/.{1,5}/)
      .collect { |char| char.ljust(5,"X") }
      .join("")
    end

    def output(text)
      text.scan(/.{5}/).join(" ")
    end

    def map_to_numbers(string)
      string.split(//).map { |char| ALPHABET[char] }
    end

    def combine_message(message, keystream)
      combined = [message, keystream]
      combined = combined.transpose.map { |x| x.reduce(:+) }
      combined.map { |x| alphabet_value(x) }
    end

    def uncombine_message message, keystream
      prep = []
      message.each_with_index do |x,i|
        if x<=keystream[i]
          prep<<x+26
        else
          prep<<x
        end
      end
      combined = [prep, keystream]
      combined = combined.transpose.map {|x| x.reduce(:-)}
    end

    def map_to_letters(integers)
      numbers = ALPHABET.invert
      integers = integers.map { |integer| numbers[integer] }
      integers.join
    end

    def generate_keystream(length)
      deck = SolitaireCipher::Deck.new
      result = []
      while result.length < length
        deck.move(:A)
        2.times { deck.move(:B) }
        deck.triple_cut
        deck.count_cut
        letter = deck.output_letter
        result << letter unless letter.nil?
      end
      result.join
    end

    def alphabet_value(x)
      x > 26 ? x % 26 : x
    end

  end
end
