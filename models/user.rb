require_relative './model'

class User < Model

  def self.all
    self.app_data.waiters
  end

  def self.find_by_pin(pin)
    all.detect{|w| w.to_a[1]["pin"] == pin}
  end
end
