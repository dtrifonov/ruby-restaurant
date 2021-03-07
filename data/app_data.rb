require 'fileutils'
require 'yaml'

class AppData

  def initialize(file)
    return unless File.file?(file)
    @data = YAML.load_file(file)
  end

  def waiters
    @data["waiters"]
  end

  def tables
    @data["tables"]
  end
end
