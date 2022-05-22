Notification.destroy_all
User.destroy_all

# Creating Admins
inyova_emails = ["sergi@inyova.com", "lollija@inyova.com", "rafael@inyova.com", "simon@inyova.com"]
inyova_emails.each { |email| User.create!(email: email, password: "password", admin: true) }

# Creating Clients
john = User.create!(email: "john@gmail.com", password: "password")
maria = User.create!(email: "maria@gmail.com", password: "password")
marcelo = User.create!(email: "marcelo@gmail.com", password: "password")
luiza = User.create!(email: "luiza@gmail.com", password: "password")

# Creating Notifications
Notification.create!(
  date: DateTime.now,
  title: "Welcome",
  description: "You just became a user in Notification Center API"
)
Notification.last.users = [john, maria, marcelo, luiza]

Notification.create!(
  date: DateTime.now,
  title: "New message",
  description: "You just received a new message from Maria"
)
Notification.last.users = [john]

Notification.create!(
  date: DateTime.now,
  title: "New post from Nasa",
  description: "Nasa has a new post that is trending"
)
Notification.last.users = [john, maria, luiza]

Notification.create!(
  date: DateTime.now,
  title: "New connection",
  description: "You just receiveid a new connection request"
)
Notification.last.users = [maria, marcelo]
