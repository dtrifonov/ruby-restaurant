require_relative './model'

class Table < Model

  def self.all
    self.app_data.tables
  end

  def self.find_by_index(index)
    tables = all
    keys = tables.keys
    tables.detect{|k, t| k == keys[index]}
  end
end
