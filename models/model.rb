require './data/app_data'
require './config/app_config'

class Model

  class << self
    def app_data
      config = AppConfig.get_config
      AppData.new(config["data"]["file"])
    end
  end

end