FactoryBot.define do
  factory :user do
    name { 'test_name' }
    email { 'test@email.com' }
    password { 'password' }
    password_confirmation { 'password' }
    icon { 'app/assets/images/fallback/show_icon_default.png' }
    profile { 'test' }
    artist_type { 'Tuner' }
  end
  factory :other_user, class: User do
    name { 'other_name' }
    email { 'other@email.com' }
    password { 'password' }
    password_confirmation { 'password' }
    profile { 'other' }
    artist_type { 'Voicer' }
  end
  factory :stranger, class: User do
    name { 'stranger' }
    email { 'stranger@email.com' }
    password { 'password' }
    password_confirmation { 'password' }
    profile { 'stranger' }
    artist_type { 'Voicer' }
  end
end
