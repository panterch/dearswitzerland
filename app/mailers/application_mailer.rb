class ApplicationMailer < ActionMailer::Base
  default from: 'app@dearswitzerland.org'
  layout 'mailer'

  def test_email
    @to = params[:to]
    mail(to: @to, subject: 'Dearswitzerland Testmail')
  end

  def thanks_email
    @letter = params[:letter]
    mail(to: @letter.email, subject: I18n.t("email.thanks.subject"))
  end
end
