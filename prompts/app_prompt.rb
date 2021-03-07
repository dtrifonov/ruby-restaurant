require './lib/app_dialog'

class AppPrompt
  attr_accessor :message, :options, :error_str

  def initialize
    @prompt = AppDialog.instance
  end

  def show
    @prompt.handle(message, options)
    @prompt.selected_index
  end

  def prompt_str
    if error_str.to_s.size > 0
      "#Error: #{error_str}\n#{message_str}"
    else
      message_str
    end
  end

  def message_str
    "#{message}:\n"
  end
end
