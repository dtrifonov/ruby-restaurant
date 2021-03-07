require './data/app_data'
require './prompts/login_prompt'
require './models/user'

class UsersController
  attr_accessor :errors

  def handle_prompt
    @errors = []
    pin = get_login_pin
    return if pin.nil?
    user = get_login_user(pin.to_i)
    if user.nil?
      errors << "Invalid pin"
      handle_prompt
    end
    user
  end

  def get_login_pin
    prompt = LoginPrompt.new()
    prompt.error_str = errors.join("\n")
    prompt.show
  end

  def get_login_user(pin)
    User.find_by_pin(pin)
  end
end
