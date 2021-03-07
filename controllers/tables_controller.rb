require './data/app_data'
require './prompts/table_prompt'
require './prompts/status_prompt'
require './controllers/app_controller'
require './models/table'

class TablesController < AppController

  def show
    table = get_table
    status = get_status(table)
    require 'pry';binding.pry;
  end

  def get_table
    @errors = []
    table_index = select_table
    table = Table.find_by_index(table_index)
    if(table.nil?)
      errors << 'Invalid table'
      get_table_index
    end
    table
  end

  def get_status(table)
    @errors = []
    select_status_input(table)
  end

  def select_table
    tables_list = Table.all
    prompt = TablePrompt.new(tables_list)
    prompt.error_str = errors.join("\n")
    prompt.show
  end

  def select_status_input(table)
    prompt = StatusPrompt.new(table)
    prompt.show
  end

  def prompt_list(table_list)
    table_list.map do |key, table_info|
      name = table_info["name"]
      seats = table_info["seats"]
      "id:#{key} name:#{name} seats:#{seats}"
    end
  end
end
