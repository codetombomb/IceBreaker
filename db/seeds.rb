10.times do 
    User.create(
        username: Faker::Internet.username(specifier: nil, separators: %w[. _]),
        password: Faker::Internet.password(
            min_length: 10, 
            max_length: 20, 
            mix_case: true)
    )

end