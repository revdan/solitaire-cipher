module SolitaireCipher
  ALPHABET = Hash[('A'..'Z').to_a.zip (1..26)].freeze

  class Cipher
    attr_reader :message

    def initialize(message, key = nil)
      @message = message
    end

    def encrypt
      letters = sanitize(message)
      mapped_message = map_to_numbers(letters)
      keystream = map_to_numbers(generate_keystream(letters.length))
      combination = add(mapped_message, keystream)
      hash = map_to_letters(combination)
      output(hash)
    end

    def decrypt
      letters = sanitize(message)
      mapped_message = map_to_numbers(letters)
      keystream = map_to_numbers(generate_keystream(letters.length))
      combination = subtract(mapped_message, keystream)
      hash = map_to_letters(combination)
      output(hash)
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

    def sanitize(message)
      message.upcase
      .gsub(/[^A-Z]/, "")
      .scan(/.{1,5}/)
      .collect { |char| char.ljust(5,"X") }
      .join("")
    end

    def output(text)
      text.scan(/.{5}/).join(" ")
    end

    def add(message, keystream)
      [message, keystream].transpose.map { |x| alphabet_value(x.reduce(:+)) }
    end

    def subtract(message, keystream)
      [message.map.with_index do |x,i|
        x <= keystream[i] ? x + 26 : x
      end, keystream].transpose.map {|x| x.reduce(:-)}
    end

    def map_to_letters(integers)
      integers.map { |x| ALPHABET.invert[x] }.join
    end

    def map_to_numbers(string)
      string.split(//).map { |char| ALPHABET[char] }
    end

    def alphabet_value(x)
      x > 26 ? x % 26 : x
    end
  end
end
