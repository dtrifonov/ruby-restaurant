require './controllers/users_controller'
require './controllers/tables_controller'

class App

  def initialize
    @user = nil
  end

  def handle
    prompt_label = 'login'
    while true do
      case prompt_label
      when 'tables'
        if @user.nil?
          prompt_label = 'login'
        else
          controller = TablesController.new
          controller.show
          @user = nil
        end
      else 'login'
        controller = UsersController.new
        @user = controller.show
        prompt_label = 'tables'
      end
    end
  end
end
