AVAILABLE_JOBS = %w[RoR Node Frontend Devops].freeze

User.delete_all

User.create(first_name: 'Janek', last_name: 'K', job: 'RoR')

19.times do
  User.create(
    first_name: SecureRandom.hex(5),
    last_name: SecureRandom.hex(8),
    job: AVAILABLE_JOBS.sample,
    description: SecureRandom.hex(20)
  )
end
