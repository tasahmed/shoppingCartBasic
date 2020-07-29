class SendEmailJob < ApplicationJob
  queue_as :default

  def perform(user, randomCode)
    # Do something later
    #invoke mailer later class
    UserregistrationMailer.userregistration_email(user, randomCode).deliver_later

  end
end
