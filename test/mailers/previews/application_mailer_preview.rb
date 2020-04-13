class ApplicationMailerPreview < ActionMailer::Preview
    def test_email
      ApplicationMailer.with(to: "test@example.com").test_email
    end

    def thanks_email
      letter = Letter.new(email: "text@example.com", slug: "12345")
      ApplicationMailer.with(letter: letter).thanks_email
    end

    def review_email
      letter = Letter.new(token: "abcde")
      ApplicationMailer.with(letter: letter).review_email
    end


end