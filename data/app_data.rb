require 'yaml'

class AppData

  def initialize(file)
    @file = file
    @data = YAML.load_file(@file)
  end

  def waiters
    @data["waiters"]
  end

  def tables
    @data["tables"]
  end
end
