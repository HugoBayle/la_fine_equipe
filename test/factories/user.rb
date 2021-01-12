FactoryBot.define do
  factory :user do
    email { "test@test.fr" }
    password { "azerty" }
    password_confirmation { "azerty" }
  end
end
