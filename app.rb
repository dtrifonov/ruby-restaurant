require './controllers/users_controller'
require './controllers/tables_controller'
require './controllers/statuses_controller'

class App

  def initialize
    @user = nil
    @table = nil
    @config = AppConfig.load_config('./config/app_config.yml')
  end

  def handle
    return unless valid_config?
    prompt_label = 'login'
    while true do
      case prompt_label
      when 'tables'
        unless @user.nil?
          controller = TablesController.new
          @table = controller.handle_prompt(@user)
          if @table.nil?
            prompt_label = 'login'
          else
            prompt_label = 'statuses'
          end
        end
      when 'statuses'
        unless @user.nil? || @table.nil?
          controller = StatusesController.new
          controller.handle_prompt(@user, @table)
          prompt_label = 'tables'
        end
      else #'login'
        controller = UsersController.new
        @user = controller.handle_prompt
        exit_app("The application has been terminated", 0) if @user.nil?
        prompt_label = 'tables'
      end
    end
  end

  def valid_config?
    if @config.nil?
      exit_app("Invalid config file\n", 1)
    end
    true
  end

  def exit_app(message, status)
    puts "#{message}\n"
    exit(status)
  end
end
