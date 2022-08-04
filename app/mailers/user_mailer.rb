class UserMailer < ApplicationMailer
    def user_message_approval(email)
        @email = email
        mail(to: email, subject: 'Waiting for admin approval')
    end
end
