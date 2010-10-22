class Notifier < ActionMailer::Base

  default_url_options[:host] = "127.0.0.1:3000"

  def password_reset_instructions(person)
    subject    '密码重置说明'
    #recipients  "#{person.email}"
    recipients   person.email
    from       'att21@163.com'
    sent_on     Time.now
    body       :edit_password_reset_url => edit_password_reset_url(person.perishable_token)
  end

end

