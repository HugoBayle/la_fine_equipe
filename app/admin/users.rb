ActiveAdmin.register User do

index do
    selectable_column
    column :id
    column :email
    column :confirmed_at
    column :created_at
    column :admin
    actions only: :delete
  end

  filter :email
  filter :confirmed_at
  filter :admin
  filter :created_at

end
