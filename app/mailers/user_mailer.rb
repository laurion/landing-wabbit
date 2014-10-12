class UserMailer < ActionMailer::Base
    default from: "laur@getwabbit.com"

    def signup_email(user)
        @user = user
        @twitter_message = "No more #missed #connections. Excited for @wabbitapp to launch."

        mail(:to => user.email, :subject => "Welcome to Wabbit!")
    end
end
