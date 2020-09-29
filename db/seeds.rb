10.times do |n|
  User.create!(name: "Mr.tuner#{n}",
              email: "number#{n}@tuner.com",
              icon: 'app/assets/images/fallback/show_icon_default.png',
              profile: 'test',
              artist_type: 'Tuner',
              password: 'password',
              password_confirmation: 'password'
              )
end
10.times do |n|
  User.create!(name: "Mr.voicer#{n}",
              email: "number#{n}@voicer.com",
              icon: 'app/assets/images/fallback/show_icon_default.png',
              profile: 'test',
              artist_type: 'Voicer',
              password: 'password',
              password_confirmation: 'password'
              )
end
10.times do |n|
  Post.create!(title: "Tune#{n}",
              music:File.open('app/assets/audios/velvet_extended.wav'),
              picture:File.open('app/assets/images/fallback/thumb_default.png'),
              music_type: 'Tune',
              user_id: User.find_by(name: "Mr.tuner#{n}").id,
              genre: 0
              )
end
10.times do |n|
  Post.create!(title: "Voice#{n}",
              music:File.open('app/assets/audios/velvet_extended.wav'),
              picture:File.open('app/assets/images/fallback/thumb_default.png'),
              music_type: 'Voice',
              user_id: User.find_by(name: "Mr.voicer#{n}").id,
              genre: 0
              )
end
10.times do |n|
  Post.create!(title: "Collabolated#{n}",
              music:File.open('app/assets/audios/velvet_extended.wav'),
              picture:File.open('app/assets/images/fallback/thumb_default.png'),
              music_type: 'Collabolated',
              user_id: User.find_by(name: "Mr.tuner#{n}").id,
              genre: 0
              )
end
