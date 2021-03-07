require './prompts/app_prompt'

class TablePrompt < AppPrompt

  def initialize(tables_list)
    super()
    @options = prompt_list(tables_list)
    @message = "Select table to change status"
    @error_str = ""
  end

  def show
    @prompt.handle(prompt_str, options)
    @prompt.selected_index
  end

  def prompt_list(table_list)
    table_list.map do |key, table_info|
      name = table_info["name"]
      seats = table_info["seats"]
      "id:#{key} name:#{name} seats:#{seats}"
    end
  end

end
