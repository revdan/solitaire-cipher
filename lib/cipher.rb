module SolitaireCipher
  class Cipher
    attr_reader :message, :secret

    def initialize(message, secret = nil)
      @message = message
      @secret = secret.upcase unless secret.nil?
    end

    def encrypt
      perform(:add)
    end

    def decrypt
      perform(:subtract)
    end

    def perform(method)
      msg = sanitize(message)
      ks = SolitaireCipher::Deck.new.generate_keystream(msg.length, secret)
      map_to_letters(send(method, map_to_numbers(msg), map_to_numbers(ks)))
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
      [number_value(message, keystream), keystream].transpose.map { |x| x.reduce(:-) }
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

    def number_value(message, keystream)
      message.map.with_index { |x,i| x <= keystream[i] ? x + 26 : x }
    end
  end
end
