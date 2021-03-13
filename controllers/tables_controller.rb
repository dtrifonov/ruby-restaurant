require_relative '../data/app_data'
require_relative '../prompts/table_prompt'
require_relative '../models/table'
require_relative './app_controller'

class TablesController < AppController

  def handle_prompt(user)
    get_table
  end

  def get_table
    table_index = select_table
    return if table_index.nil?
    table = Table.find_by_index(table_index)
    if(table.nil?)
      @errors = []
      @errors << 'Invalid table'
      get_table
    end
    table
  end

  def select_table
    tables_list = Table.all
    prompt = TablePrompt.new(tables_list)
    prompt.error_str = @errors.join("\n")
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
