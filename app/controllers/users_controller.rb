class UsersController < ApplicationController
    before_filter :skip_first_page, :only => :new
    before_filter :init

    require 'sendgrid_ruby'
    require 'sendgrid_ruby/version'
    require 'sendgrid_ruby/email'

    def init
        @sendgrid = SendgridRuby::Sendgrid.new('laurion', '92zi6xip')
        @base = 2 * 7 * 2469
    end

    def new
        @bodyId = 'home'
        @is_mobile = mobile_device?

        @user = User.new

        respond_to do |format|
            format.html # new.html.erb
        end
    end

    def create
        # Get user to see if they have already signed up
        @user = User.find_by_email(params[:user][:email]);

        # If user doesnt exist, make them, and attach referrer
        if @user.nil?

            cur_ip = IpAddress.find_by_address(request.env['HTTP_X_FORWARDED_FOR'])

            if !cur_ip
                cur_ip = IpAddress.create(
                    :address => request.env['HTTP_X_FORWARDED_FOR'],
                    :count => 0
                )
            end

            if cur_ip.count > 2
                return redirect_to root_path
            else
                cur_ip.count = cur_ip.count + 1
                cur_ip.save
            end

            @user = User.new(:email => params[:user][:email])

            @referred_by = User.find_by_referral_code(cookies[:h_ref])

            puts '------------'
            puts @referred_by.email if @referred_by
            puts params[:user][:email].inspect
            puts request.env['HTTP_X_FORWARDED_FOR'].inspect
            puts '------------'

            if !@referred_by.nil?
                @user.referrer = @referred_by
            end

            @user.save
            # Send them over refer action
            respond_to do |format|
                if !@user.nil?
                    @count = User.count(:all) + @base
                    cookies[:h_email] = { :value => @user.email }
                    format.html { redirect_to '/refer-a-friend' }

                    mail = SendgridRuby::Email.new
                    mail.add_to(@user.email)
                    mail.set_from('laur@getwabbit.com')
                    mail.set_subject('Welcome to Wabbit!')

                    ref_code = @user.referral_code
                    if !ref_code
                      ref_code = ""
                    end
                    mail.set_text("Welcome, Wabbit-er!

Thank you for signing up. We're working hard to release Wabbit on iOS!

You are #" + @count.to_s + " on our waiting list.

If you want to cut in line and get priority access to our iOS version, get your friends to sign up with this unique URL:


" + root_url + "?ref=" + ref_code + "


The more friends that join, the sooner you'll get access.

Kindly,
Laur and the Wabbit team")
                    mail.set_html("<style>

                        #main {
                          text-align: center;
                        }
                        header {
                          padding: 1rem 6rem;
                          border-bottom: 3px solid #f0f0f0;
                        }

                        body {
                          font-family: 'Oxygen', 'helvetica-neue', 'helvetica', 'arial', sans-serif;
                          font-weight: 300;
                          color: #535353;
                          -webkit-font-smoothing: antialiased;
                        }

                        #header-logo{
                          width: 250px;
                        }

                        .container {
                          margin: 0 auto;
                          max-width: 960px;
                          padding-top: 107px;
                        }

                        .screenshot {
                          display: block;
                          margin: 0 auto;
                          width: 100%;
                          max-width: 458px;
                        }

                        .column-adjust-top-margin {
                          margin-top: -8rem;
                        }

                        .container input {
                          margin-bottom: 3rem;
                        }

                        .container textarea {
                          margin-bottom: 3rem;
                          height: 200px;
                        }

                        .social-media {
                          margin-top: 4rem;
                          padding: 4rem 0;
                          border-top: 1px solid #cccccc;
                          border-bottom: 1px solid #cccccc;
                        }

                        .share-btns img{
                          /*margin: 0 1rem;*/
                        }

                        .share-btns a {
                          text-decoration: none;
                        }

                        #footer {
                          margin: 0 auto;
                          padding: 0 21px;
                          max-width: 960px;
                          font-size: 21px;
                          line-height: 21px;
                          height: 21px;
                        }

                        #footer a {
                          color: #2ecc71;
                          text-decoration: none;
                        }

                        #footer .lhs {
                          float: left;
                        }

                        #footer .rhs {
                          float: right;
                        }

                        #footer-wrapper {
                          background: #f3f3f4;
                          margin-top: 60px;
                          padding: 44px 0;
                          color: #6d6d6d;
                        }

                        .btn {
                          padding: 0;
                          font-weight: 300;
                        }

                        .btn-success {
                          background: #2ecc71;
                        }
                        .btn-success:hover {
                          background: #26b864;
                        }

                        .button-inner {
                          height: 46px;
                          line-height: 46px;
                          display: block;
                          font-size: 18px;
                          text-decoration: none;
                          padding: 0px 80px 0px 79px;
                        }

                        .inbetween {
                          height: 162px;
                        }

                        .inbetween-sm {
                          height: 81px;
                        }

                        h1, h2, h3, h4, h5, h6 {
                          font-family: 'Oxygen', 'helvetica-neue', 'helvetica', 'arial', sans-serif;
                        }

                        h1 {
                          font-weight: 300;
                          font-size: 46px;
                          padding: .5rem 0;
                        }

                        p {
                          font-weight: 300;
                          font-size: 30px;
                          line-height: 1.5;
                          padding: .5rem 0;
                        }

                        .referral {
                          font-size: 27px;
                        }

                        .user-table {
                          width: 100%;
                        }
                        .user-table thead tr {
                          background-color: #dddddd;
                        }
                        .user-table tbody tr:nth-child(even) {
                          background-color: #eeeeee;
                        }

                        /* MOBILE STYLES */
                        @media screen and (max-width: 767px)
                        {
                          .home h1 {
                            text-align: center;
                          }

                          .column-adjust-top-margin {
                            margin-top: 0;
                          }

                          .inbetween {
                            height: 80px;
                          }

                          .inbetween-sm {
                            height: 40px;
                          }
                        }



                        </style>
                        <div id=\"main\">
                            <div class=\"container text-center\">

                                  <p class=\"referral\"><strong>Welcome, Wabbit-er!</strong></p>
                                  <p class=\"referral\">Thank you for signing up. We're working hard to release Wabbit on iOS!</p>
                                  <p class=\"referral\">You are #" + @count.to_s + " on our waiting list.</p>

                                  <p class=\"referral\">If you want to cut in line and get priority access to our iOS version, get your friends to sign up with this unique URL:</p>
                                  <br>
                                  <p><b>http://getwabbit.com/?ref=" + ref_code + "</b></p>
                                  <br>
                                  <p class=\"referral\"\">The more friends that join, the sooner you'll get access.</p>
                                  <div class=\"row\">
                                      <div class=\"col-md-6 col-md-offset-3 text-center share-btns\">
                                          <a href=\"https://www.facebook.com/dialog/share?app_id=280621415419777&display=popup&href=" + root_url + "?ref=" + ref_code + "&redirect_uri=http://getwabbit.com\">
                                            <img src=\"http://getwabbit/assets/shareon.png\">
                                          </a>
                                          <a href=\"http://twitter.com/home?status=Can't wait for @wabbitapp, which connects you with people you've crossed paths with! Sign up for the iOS beta now: " + root_url + "?ref=" + ref_code + " target=\"_blank\">
                                            <img src=\"http://getwabbit/assets/tweeton.png\">
                                          </a>
                                      </div>
                                  </div>
                                  <p>
                                  Kindly,<br>
                                  Laur and the Wabbit team
                                  </p>

                            </div>
                        </div>
                    ")

                    response = @sendgrid.send(mail)
                else
                    format.html { redirect_to root_path, :alert => "Something went wrong!" }
                end
            end
        else
            respond_to do |format|
                format.html { redirect_to root_path, :alert => "Already signed up!" }
            end
        end

        # # Send them over refer action
        # respond_to do |format|
        #     if !@user.nil?
        #         cookies[:h_email] = { :value => @user.email }
        #         format.html { redirect_to '/refer-a-friend' }
        #
        #         mail = SendgridRuby::Email.new
        #         mail.add_to(@user.email)
        #         mail.set_from('contact@getwabbit.com')
        #         mail.set_subject('Welcome to Wabbit!')
        #         mail.set_text('Welcome!')
        #         mail.set_html('<strong>Welcome!</strong>')
        #
        #         response = @sendgrid.send(mail)
        #     else
        #         format.html { redirect_to root_path, :alert => "Something went wrong!" }
        #     end
        # end
    end

    def refer
        email = cookies[:h_email]

        @bodyId = 'refer'
        @is_mobile = mobile_device?

        @user = User.find_by_email(email)

        respond_to do |format|
            @count = User.count(:all) + @base
            if !@user.nil?
                format.html #refer.html.erb
            else
                format.html { redirect_to root_path, :alert => "Something went wrong!" }
            end
        end
    end

    def policy

    end

    def redirect
        redirect_to root_path, :status => 404
    end

    private

    def skip_first_page
        if !Rails.application.config.ended
            email = cookies[:h_email]
            if email and !User.find_by_email(email).nil?
            #     redirect_to '/refer-a-friend'
            # else
                cookies.delete :h_email
            end
        end
    end

end
