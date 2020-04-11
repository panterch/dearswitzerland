class ApplicationMailer < ActionMailer::Base
  default from: 'app@dearswitzerland.org'
  layout 'mailer'

  def test_email
    @to = params[:to]
    mail(to: @to, subject: 'Dearswitzerland Testmail')
  end
end
