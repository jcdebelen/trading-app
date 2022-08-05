class UserMailer < ApplicationMailer
    def user_message_approval(email)
        @email = email
        mail(to: email, subject: 'Waiting for admin approval')
    end

    def user_message_approved(email)
        @email = email
        mail(to: email, subject: "You've been approved!")
    end
end
