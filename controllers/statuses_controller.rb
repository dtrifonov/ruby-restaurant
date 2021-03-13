require_relative '../data/app_data'
require_relative '../prompts/status_prompt'
require_relative '../services/table_status'
require_relative './app_controller'

class StatusesController < AppController
  
  def handle_prompt(user, table)
    status = get_status(table)
    service = TableStatus.new
    service.handle(table, status, user)
  end
  
  def get_status(table)
    @errors = []
    select_status_input(table)
  end
  
  def select_status_input(table)
    prompt = StatusPrompt.new(table)
    prompt.error_str = @errors.join("\n")
    prompt.show
  end

end
