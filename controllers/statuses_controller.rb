require './data/app_data'
require './prompts/status_prompt'
require './controllers/app_controller'
require './services/table_status'

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
