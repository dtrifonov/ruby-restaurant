require_relative '../data/app_data'
require_relative '../config/app_config'

class Model

  def self.app_data
    config = AppConfig.get_config
    data_file = File.join(App.root_dir, config["data"]["file"])
    AppData.new(data_file)
  end
end
