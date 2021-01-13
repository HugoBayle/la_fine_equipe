ActiveAdmin.register Request do

  index do
    selectable_column
    column :id
    column :position
    column :status
    column :user
    column :last_check
    column :date_mail_sent
    column :created_at
    column :updated_at
  end

end
