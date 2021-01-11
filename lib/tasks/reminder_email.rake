namespace :reminder_email do
  desc "Send email to everyone after 3 months of waiting"
  task :send_reminder do
    requests_confirmed = Request.where(status: "confirmed")
    requests_confirmed.each do |request|
      deadline = request.last_check + 3.months
      if (Date.today > deadline)
        UserMailer.reminder(request.user).deliver_now
        request.last_check = Date.today
        request.date_mail_sent = Date.today
        request.save
        puts "email has been sent to #{request.user.email}"
      end
    end
  end

  desc "If the user hasn't follow the link of the reminder email, his request goes to expired"
  task :check_if_email_read do
    requests_mail_sent = Request.where(status: "confirmed").where.not(date_mail_sent: nil)
    requests_mail_sent.each do |request|
      deadline_email = request.date_mail_sent + 1.day
      if request.date_mail_sent != nil && Date.today > deadline_email
        if request.position == 1
          Request.where(status: "confirmed").update_all("position = position - 1")
        else
          Request.where("#{request.position} < position").update_all("position = position - 1")
        end
        request.status = "expired"
        request.position = nil
        request.save
        puts "The request of #{request.user.profile.name} has expired"
      end
    end
  end
end
