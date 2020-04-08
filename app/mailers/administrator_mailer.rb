class AdministratorMailer < ApplicationMailer
  default to: 'tk0358a@yahoo.co.jp', 
          from: 'Auto message<do-not-reply@example.com>'
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.administrator_mailer.failure_occured.subject
  #
  def failure_occured(params)
    @params = params
    mail(subject: 'Someone has accessed invalid url')
  end
end
