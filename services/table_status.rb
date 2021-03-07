require 'fileutils'
require 'date'

class TableStatus
  def initialize
    config = AppConfig.get_config
    @file = config["status_csv"]["file"]
    unless File.file?(@file)
      store_line(headers)
    end
  end

  def handle(table, status, user)
    store_line(status_str(table, status, user))
  end

  def store_line(line)
    handler = File.open(@file, 'a')
    handler << line
    handler.close 
  end

  def headers
    "datetime,index,name,seats,status,user\n"
  end

  def status_str(table, status, user)
    datetime = DateTime.now.strftime('%Y-%m-%d %H:%M:%S')
    table_arr = table.to_a
    index = table_arr[0].to_i
    name = table_arr[1]["name"]
    seats = table_arr[1]["seats"]
    user_name = user.to_a[1]["name"]
    "#{datetime},#{index},#{name},#{seats},#{status},#{user_name}\n"
  end
end
