class ApplicationMailer < ActionMailer::Base
  default from: 'app@dearswitzerland.org'
  layout 'mailer'

  def self.send_notifications(letter)
    ApplicationMailer.with(letter: letter).thanks_email.deliver_later
    ApplicationMailer.with(letter: letter).review_email.deliver_later
  end

  def test_email
    @to = params[:to]
    mail(to: @to, subject: 'Dearswitzerland Testmail')
  end

  def review_email
    @letter = params[:letter]
    mail(to: 'app@dearswitzerland.org', subject: '[Dearswitzerland] New letter to review')
  end

  def thanks_email
    @letter = params[:letter]
    mail(to: @letter.email, subject: I18n.t("email.thanks.subject"))
  end
end
