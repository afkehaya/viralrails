class UserMailer < ActionMailer::Base
    default from: "Alex <alex@kehaya.com>"

    def signup_email(user)
        @user = user
        @twitter_message = "#ViralRails. Learn how to build a viral landing page with Ruby on Rials"

        mail(:to => user.email, :subject => "Thanks for signing up!")
    end
end
