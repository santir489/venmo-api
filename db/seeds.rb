# Users
user1 = User.create!(username: 'Cavani', email: 'cavani@example.com')
user2 = User.create!(username: 'Rashford', email: 'rashford@example.com')
user3 = User.create!(username: 'Fred', email: 'fred@example.com')
user4 = User.create!(username: 'Shaw', email: 'shaw@example.com')
user5 = User.create!(username: 'Martial', email: 'martial@example.com')
user6 = User.create!(username: 'Henderson', email: 'henderson@example.com')
user7 = User.create!(username: 'Xisco', email: 'xisco@example.com')
user8 = User.create!(username: 'Damiani', email: 'damiani@example.com')
user9 = User.create!(username: 'Ruglio', email: 'ruglio@example.com')

# Friendships
Friendship.create!(user_a: user1, user_b: user2)
Friendship.create!(user_a: user1, user_b: user3)
Friendship.create!(user_a: user2, user_b: user4)
Friendship.create!(user_a: user4, user_b: user3)
Friendship.create!(user_a: user3, user_b: user5)
Friendship.create!(user_a: user5, user_b: user6)
Friendship.create!(user_a: user6, user_b: user7)
Friendship.create!(user_a: user8, user_b: user9)

# Balances
user1.payment_account.update!(balance: 7000)
user3.payment_account.update!(balance: 20)
user5.payment_account.update!(balance: 500)
user8.payment_account.update!(balance: 10)
user9.payment_account.update!(balance: 120)

# Payments
Payment.create!(sender: user1, receiver: user2, amount: 100, description: 'Car',
                created_at: 5.days.ago)
Payment.create!(sender: user1, receiver: user3, amount: 5, description: 'Dinner',
                created_at: 4.days.ago)
Payment.create!(sender: user3, receiver: user5, amount: 10, description: 'Vacations',
                created_at: 3.days.ago)
Payment.create!(sender: user5, receiver: user6, amount: 150, description: 'Supermarket',
                created_at: 2.days.ago)
Payment.create!(sender: user6, receiver: user7, amount: 40, description: 'Day out',
                created_at: 2.days.ago)
Payment.create!(sender: user8, receiver: user9, amount: 5, description: 'Dinner',
                created_at: 1.day.ago)
