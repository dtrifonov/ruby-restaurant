require_relative './app_prompt'

class LoginPrompt < AppPrompt

  def initialize()
    super()
    @options = []
    @message = "Enter your pin"
    @error_str = ""
  end

  def show
    @prompt.handle(prompt_str, options, true)
    return if @prompt.aborted?
    @prompt.raw_answer
  end
end
