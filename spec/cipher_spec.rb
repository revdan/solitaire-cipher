require 'spec_helper'
require_relative '../lib/solitaire_cipher'

describe SolitaireCipher::Cipher do
  let(:message) { "Code in Ruby, live longer!2"  }
  let(:cipher) { SolitaireCipher::Cipher.new(message) }
  let(:secret) { "dan is awesome" }

  it "takes a message as a parameter" do
    expect(cipher.message).to eq message
  end

  describe "#encrypt" do
    context "without a secret key" do
      specify { cipher.encrypt.should == "GLNCQ MJAFF FVOMB JIYCB" }
    end

    context "with a secret key" do
      let(:cipher) { SolitaireCipher::Cipher.new(message, secret) }
      specify { cipher.encrypt.should == "ORSUZ SGKIQ NLRBA TQMVL" }
    end

    context "given Bruce's test vectors" do
      describe "no key" do
        let(:cipher) { SolitaireCipher::Cipher.new("AAAAAAAAAAAAAAA", nil) }
        specify { cipher.encrypt.should == "EXKYI ZSGEH UNTIQ" }
      end

      describe "key of f" do
        let(:cipher) { SolitaireCipher::Cipher.new("AAAAAAAAAAAAAAA", "f") }
        specify { cipher.encrypt.should == "XYIUQ BMHKK JBEGY" }
      end

      describe "key of fo" do
        let(:cipher) { SolitaireCipher::Cipher.new("AAAAAAAAAAAAAAA", "fo") }
        specify { cipher.encrypt.should == "TUJYM BERLG XNDIW" }
      end

      describe "key of foo" do
        let(:cipher) { SolitaireCipher::Cipher.new("AAAAAAAAAAAAAAA", "foo") }
        specify { cipher.encrypt.should == "ITHZU JIWGR FARMW" }
      end

      describe "key of a" do
        let(:cipher) { SolitaireCipher::Cipher.new("AAAAAAAAAAAAAAA", "a") }
        specify { cipher.encrypt.should == "XODAL GSCUL IQNSC" }
      end

      describe "key of aa" do
        let(:cipher) { SolitaireCipher::Cipher.new("AAAAAAAAAAAAAAA", "aa") }
        specify { cipher.encrypt.should == "OHGWM XXCAI MCIQP" }
      end

      describe "key of aaa" do
        let(:cipher) { SolitaireCipher::Cipher.new("AAAAAAAAAAAAAAA", "aaa") }
        specify { cipher.encrypt.should == "DCSQY HBQZN GDRUT" }
      end

      describe "key of b" do
        let(:cipher) { SolitaireCipher::Cipher.new("AAAAAAAAAAAAAAA", "b") }
        specify { cipher.encrypt.should == "XQEEM OITLZ VDSQS" }
      end

      describe "key of bc" do
        let(:cipher) { SolitaireCipher::Cipher.new("AAAAAAAAAAAAAAA", "bc") }
        specify { cipher.encrypt.should == "QNGRK QIHCL GWSCE" }
      end

      describe "key of bcd" do
        let(:cipher) { SolitaireCipher::Cipher.new("AAAAAAAAAAAAAAA", "bcd") }
        specify { cipher.encrypt.should == "FMUBY BMAXH NQXCJ" }
      end

      describe "key of cryptonomicon" do
        let(:cipher) { SolitaireCipher::Cipher.new("SOLITAIRE", "cryptonomicon") }
        specify { cipher.encrypt.should == "KIRAK SFJAN" }
      end
    end
  end

  describe "#decrypt" do
    context "without a key" do
      let(:cipher) { SolitaireCipher::Cipher.new("GLNCQ MJAFF FVOMB JIYCB") }
      specify { cipher.decrypt.should == "CODEI NRUBY LIVEL ONGER" }
    end

    context "with a key" do
      let(:cipher) { SolitaireCipher::Cipher.new("ORSUZ SGKIQ NLRBA TQMVL", secret) }
      specify { cipher.decrypt.should == "CODEI NRUBY LIVEL ONGER" }
    end

    context "with Ed's test vectors" do
      describe "CLEPK HHNIY CFPWH FDFEH" do
        let(:cipher) { SolitaireCipher::Cipher.new("CLEPK HHNIY CFPWH FDFEH", nil) }
        specify { cipher.decrypt.should == "YOURC IPHER ISWOR KINGX" }
      end

      describe "ABVAW LWZSY OORYK DUPVH" do
        let(:cipher) { SolitaireCipher::Cipher.new("ABVAW LWZSY OORYK DUPVH", nil) }
        specify { cipher.decrypt.should == "WELCO METOR UBYQU IZXXX" }
      end
    end

    context "given Bruce's test vectors" do
      describe "no key" do
        let(:cipher) { SolitaireCipher::Cipher.new("EXKYI ZSGEH UNTIQ", nil) }
        specify { cipher.decrypt.should == "AAAAA AAAAA AAAAA" }
      end

      describe "key of f" do
        let(:cipher) { SolitaireCipher::Cipher.new("XYIUQ BMHKK JBEGY", "f") }
        specify { cipher.decrypt.should == "AAAAA AAAAA AAAAA" }
      end

      describe "key of fo" do
        let(:cipher) { SolitaireCipher::Cipher.new("TUJYM BERLG XNDIW", "fo") }
        specify { cipher.decrypt.should == "AAAAA AAAAA AAAAA" }
      end

      describe "key of foo" do
        let(:cipher) { SolitaireCipher::Cipher.new("ITHZU JIWGR FARMW", "foo") }
        specify { cipher.decrypt.should == "AAAAA AAAAA AAAAA" }
      end

      describe "key of a" do
        let(:cipher) { SolitaireCipher::Cipher.new("XODAL GSCUL IQNSC", "a") }
        specify { cipher.decrypt.should == "AAAAA AAAAA AAAAA" }
      end

      describe "key of aa" do
        let(:cipher) { SolitaireCipher::Cipher.new("OHGWM XXCAI MCIQP", "aa") }
        specify { cipher.decrypt.should == "AAAAA AAAAA AAAAA" }
      end

      describe "key of aaa" do
        let(:cipher) { SolitaireCipher::Cipher.new("DCSQY HBQZN GDRUT", "aaa") }
        specify { cipher.decrypt.should == "AAAAA AAAAA AAAAA" }
      end

      describe "key of b" do
        let(:cipher) { SolitaireCipher::Cipher.new("XQEEM OITLZ VDSQS", "b") }
        specify { cipher.decrypt.should == "AAAAA AAAAA AAAAA" }
      end

      describe "key of bc" do
        let(:cipher) { SolitaireCipher::Cipher.new("QNGRK QIHCL GWSCE", "bc") }
        specify { cipher.decrypt.should == "AAAAA AAAAA AAAAA" }
      end

      describe "key of bcd" do
        let(:cipher) { SolitaireCipher::Cipher.new("FMUBY BMAXH NQXCJ", "bcd") }
        specify { cipher.decrypt.should == "AAAAA AAAAA AAAAA" }
      end

      describe "key of cryptonomicon" do
        let(:cipher) { SolitaireCipher::Cipher.new("KIRAK SFJAN", "cryptonomicon") }
        specify { cipher.decrypt.should == "SOLIT AIREX" }
      end
    end
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
      expect(cipher.map_to_letters(combined_message)).to eq "GLNCQ MJAFF FVOMB JIYCB"
    end
  end

  describe "#alphabet_value" do
    it "returns the same number when between 1 and 26" do
      expect(cipher.alphabet_value(12)).to eq 12
    end

    it "returns the number minus 26 when above 26" do
      expect(cipher.alphabet_value(30)).to eq 4
    end
  end
end
