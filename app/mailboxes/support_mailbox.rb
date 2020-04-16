class SupportMailbox < ApplicationMailbox
  def process
    SupportRequest.create!(
      email: mail.from_address.to_s,
      subject: mail.subject,
      body: mail.body.to_s
    )

    puts "START SupportMailbox#process:"
    puts "From: #{mail.from_address}"
    puts "Subject: #{mail.subject}"
    puts "Body: #{mail.body}"
    puts "END SupportMailbox#process:"
  end
end
