require './data/app_data'
require './prompts/table_prompt'
require './prompts/status_prompt'
require './controllers/app_controller'
require './models/table'
require './services/table_status'

class TablesController < AppController

  def handle_prompt(user)
    table = get_table
    status = get_status(table)
    service = TableStatus.new
    service.handle(table, status, user)
  end

  def get_table
    table_index = select_table
    table = Table.find_by_index(table_index)
    if(table.nil?)
      @errors = []
      @errors << 'Invalid table'
      get_table
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
    prompt.error_str = @errors.join("\n")
    prompt.show
  end

  def select_status_input(table)
    prompt = StatusPrompt.new(table)
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
