require_relative '../data/app_data'
require_relative '../prompts/login_prompt'
require_relative '../models/user'
require_relative '../lib/string'
require_relative './app_controller'

class UsersController < AppController

  def handle_prompt
    pin = get_login_pin
    return if pin.nil?
    user = get_login_user(encrypt_pin(pin))
    if user.nil?
      @errors = []
      @errors << "Invalid pin"
      handle_prompt
    end
    user
  end

  def get_login_pin
    prompt = LoginPrompt.new()
    prompt.error_str = @errors.join("\n")
    prompt.show
  end

  def encrypt_pin(pin)
    config = AppConfig.get_config
    key = config["secret"]["key"]
    pin.encrypt(key)
  end

  def get_login_user(pin)
    User.find_by_pin(pin)
  end
end
