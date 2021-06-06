class ApplicationController < ActionController::Base

  private

  def error_message(errors)
    errors.full_messages.join(', ')
  end
<<<<<<< HEAD
=======

>>>>>>> 9ceae1d7579b3694520cfadbdd86bcd5d45f75a5
end
