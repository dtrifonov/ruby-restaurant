require './prompts/app_prompt'

class StatusPrompt < AppPrompt

  def initialize(table)
    super()
    table_name = table.to_a[1]["name"]
    @message = "Select table #{table_name} status"
    @options = statuses
    @error_str = ""
  end

  def show
    @prompt.handle(prompt_str, options)
    @prompt.selected
  end

  def statuses
    ['free', 'reserved', 'occupied']
  end
end
