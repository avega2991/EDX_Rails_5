class MyMailer < ActionMailer::Base
  default from: "avenger2991@gmail.com"

  def welcome_email(email, filename)

    attachments["#{filename}"] = File.read("#{filename}")

    mail(to: email, subject: 'Resque test application mail')

  end
end
