require 'fileutils'
require 'yaml'
require 'singleton'

class AppConfig
  include Singleton

  attr_reader :config

  class << self
    def load_config(file)
      config = AppConfig.instance
      config.init_config(file)
    end

    def get_config
      AppConfig.instance.config
    end
  end

  def init_config(file)
    return unless File.file?(file)
    @config = YAML.load_file(file)
  end

end
