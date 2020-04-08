# Preview all emails at http://localhost:3000/rails/mailers/administrator_mailer
class AdministratorMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/administrator_mailer/failure_occured
  def failure_occured
    AdministratorMailer.failure_occured
  end

end
