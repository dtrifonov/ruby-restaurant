require_relative './controllers/users_controller'
require_relative './controllers/tables_controller'
require_relative './controllers/statuses_controller'

class App
  attr_accessor :prompt_label
  attr_reader :user, :table

  def self.root_dir
    File.dirname(__FILE__)
  end

  def initialize
    config_file = File.join(App.root_dir, './config/app_config.yml')
    @config = AppConfig.load_config(config_file)
    init_prompts
  end

  def handle
    return unless valid_config?
    while true
      case prompt_label
      when 'tables'
        handle_tables_prompt
      when 'statuses'
        handle_statuses_prompt
      else
        handle_login_prompt
      end
    end
  end

  def init_prompts
    @user = nil
    @table = nil
    @prompt_label = ''
  end

  def handle_login_prompt
    controller = UsersController.new
    @user = controller.handle_prompt
    exit_app("The application has been terminated", 0) if @user.nil?
    @prompt_label = 'tables'
  end

  def handle_statuses_prompt
    unless @user.nil? || @table.nil?
      controller = StatusesController.new
      controller.handle_prompt(@user, @table)
      @prompt_label = 'tables'
    end
  end

  def handle_tables_prompt
    unless @user.nil?
      controller = TablesController.new
      @table = controller.handle_prompt(@user)
      @prompt_label = @table.nil? ? 'login' : 'statuses'
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
