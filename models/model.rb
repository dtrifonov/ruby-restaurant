require './data/app_data'
require './config/app_config'

class Model

  def self.app_data
    config = AppConfig.get_config
    AppData.new(config["data"]["file"])
  end
end
