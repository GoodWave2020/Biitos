FactoryBot.define do
  factory :user do
    name { 'test_name' }
    email { 'test@email.com' }
    password { 'password' }
    password_confirmation { 'password' }
    icon { 'show_icon_default.png' }
    profile { 'test' }
    artist_type { 'Tuner' }
  end
end
