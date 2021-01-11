class AddDateMailSentToRequests < ActiveRecord::Migration[6.0]
  def change
    add_column :requests, :date_mail_sent, :date
  end
end
