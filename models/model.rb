require './data/app_data'

class Model

  def self.app_data
    file = './data/data.yml'
    AppData.new(file)
  end
end
