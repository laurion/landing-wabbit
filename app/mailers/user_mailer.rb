class UserMailer < ActionMailer::Base
    default from: "Laur <laur@getwabbit.com>"

    def signup_email(user)
        @user = user
        @twitter_message = "#Shaving is evolving. Excited for @harrys to launch."

        mail(:to => user.email, :subject => "Welcome to Wabbit!")
    end
end
