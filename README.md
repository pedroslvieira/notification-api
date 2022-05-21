<h2 align="left">Notification Center API</h2>

<h3 align="left">Overview</h3>
The notification center allows Admins to set up notifications and clients to get the latest notifications relevant for them. The features covered by the API:

<br/>As an Admin, I can:
- See all notifications
- See the details of a specific notification 
- Create a notification 
- Assign a notification to one or multiple clients
- Delete a notification
- Delete a user_notification

As a Client, I can:
- View my notifications

<h3 align="left">Structure</h3>
The API structured with three models: User, Notification and UserNotification. Users can have many notifications and notifications can have many users. UserNotification creates the association between one user and one notification, it also contains the field “seen” that indicates if the user has seen the notification.

<h3 align="left">Authentication</h3>
The Notification Center API uses token authentication to manage requests permissions. All requests require user authentication. The User Token will be automatically generated when a new user is created. The user credentials should be passed in the HTTP headers as the example:

<br/>Request Header
<br/>Content-Type: application/json
<br/>X-User-Email: john.doe@gmail.com
<br/>X-User-Token: 1HJ**************BZos

<h3 align="left">Features</h3>
