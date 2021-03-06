require 'openssl'

class String
  def encrypt(key)
    cipher = OpenSSL::Cipher.new('DES-EDE3-CBC').encrypt
    cipher.key = (Digest::SHA1.hexdigest key)[0..23]
    s = cipher.update(self) + cipher.final

    s.unpack('H*')[0].upcase
  end

  def decrypt(key)
    cipher = OpenSSL::Cipher.new('DES-EDE3-CBC').decrypt
    cipher.key = (Digest::SHA1.hexdigest key)[0..23]
    s = [self].pack("H*").unpack("C*").pack("c*")

    cipher.update(s) + cipher.final
  end
end
