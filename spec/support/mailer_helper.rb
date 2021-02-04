module MailerHelpers
  def extract_confirmation_url(mail)
    body = mail.body.encoded
    body[/http[^"]+/]
  end
end