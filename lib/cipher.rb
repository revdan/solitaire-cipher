module SolitaireCipher
  class Cipher
    attr_reader :message, :secret

    def initialize(message, secret = nil)
      @message = message
      @secret = secret.upcase unless secret.nil?
    end

    def encrypt
      letters = sanitize(message)
      keystream = generate_keystream(letters.length)
      combination = add(map_to_numbers(letters), map_to_numbers(keystream))
      map_to_letters(combination)
    end

    def decrypt
      letters = sanitize(message)
      keystream = generate_keystream(letters.length)
      combination = subtract(map_to_numbers(letters), map_to_numbers(keystream))
      map_to_letters(combination)
    end

    def generate_keystream(length)
      deck = SolitaireCipher::Deck.new
      deck.key_with(secret) unless secret.nil?
      keystream = []
      while keystream.length < length
        deck.key
        keystream << deck.output_letter unless deck.output_letter.nil?
      end
      keystream.join
    end

    def sanitize(message)
      message.upcase
      .gsub(/[^A-Z]/, "")
      .scan(/.{1,5}/)
      .collect { |char| char.ljust(5,"X") }
      .join("")
    end

    def add(message, keystream)
      [message, keystream].transpose.map { |x| alphabet_value(x.reduce(:+)) }
    end

    def subtract(message, keystream)
      [message.map.with_index do |x,i|
        x <= keystream[i] ? x + 26 : x
      end, keystream].transpose.map { |x| x.reduce(:-) }
    end

    def map_to_letters(integers)
      integers.map { |x| ALPHABET.invert[x] }.join.scan(/.{5}/).join(" ")
    end

    def map_to_numbers(string)
      string.split(//).map { |char| ALPHABET[char] }
    end

    def alphabet_value(x)
      x > 26 ? x % 26 : x
    end
  end
end
