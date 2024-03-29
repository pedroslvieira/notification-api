<h2 align="left">Notification Center API</h2>

<h3 align="left">Overview</h3>
The Notification Center API allows Admins to set up notifications and clients to get the latest notifications relevant for them. The features covered by the API:

<br/>As an Admin, I can:
<br/> :: [See all notifications](#1)
<br/> :: [See the details of a specific notification](#2)
<br/> :: [Create a notification](#3)
<br/> :: [Update a notification](#4)
<br/> :: [Assign a notification to one or multiple clients](#5)
<br/> :: [Delete a notification](#6)
<br/> :: [Delete a user_notification](#7)

As a Client, I can:
<br/> :: [View all my notifications](#8)
<br/> :: [View one notification](#9)

<h3 align="left">Testing</h3>
Running db:seeds will create admin-users for each developer with the corresponding authentication token. It will also generate Clients, Notifications and associations between them so that the developers can run tests.

<h3 align="left">Structure</h3>
The API is structured with three models: User, Notification and UserNotification. Users can have many notifications and notifications can have many users. UserNotification creates the association between a user and a notification, it also contains the field “seen” that indicates if the user has seen the notification.

<h3 align="left">Authentication</h3>
The Notification Center API uses token authentication to manage requests permissions. All requests require user authentication. The User Token will be automatically generated when a new user is created. The user credentials should be passed in the HTTP headers as the example:

<br/>Request Headers
<br/>Content-Type: application/json
<br/>X-User-Email: john.doe@gmail.com
<br/>X-User-Token: 1HJ**************BZos

<h3 align="left">Features</h3>


<h4 id=1 align="left">:: As Admin, I can see all notifications</h4>
Admins have access to a list of all notifications. The response returns an array of notifications.

<br/>[GET] 
<br/>Endpoint: /v1/notifications
<br/>Host: http://localhost:3000/api

Response Body Example
```json
[
    {
        "id": 1,
        "date": "Sat, 21 May 2022 11:23:03 +0200",
        "title": "Notification 01",
        "description": "Notification 01 description"
    },
    {
        "id": 2,
        "date": "Sat, 21 May 2022 11:23:03 +0200",
        "title": "Notification 02",
        "description": "Notification 02 description"
    }
]
```

<br/><h4 id=2 align="left">:: As Admin, I can see the details of a notification </h4>
Admins can see in detail a notification. It presents a list of all user_notifications associated to it and details about the users notified (user id and email).

<br/>[GET] 
<br/>Endpoint: /v1/notifications/:id
<br/>Host: http://localhost:3000/api

Response Body Example
```json
{
  "id": 1,
  "date": "Sat, 21 May 2022 11:23:03 +0200",
  "title": "Notification 01",
  "description": "Notification 01 description",
  "user_notifications": [
    {
      "id": 1,
      "seen": false,
      "user_id": 1,
      "email": "john.doe@gmail.com"
    },
    {
      "id": 2,
      "seen": true,
      "user_id": 2,
      "email": "pedro@gmail.com"
    }
  ]
}
```

<br/><h4 id=3 align="left">:: As Admin, I can create a notification</h4>
Admins are able to create new notifications with date, title and description. The attributes should be passed in the request body.

<br/>[POST] 
<br/>Endpoint: /v1/notifications
<br/>Host: http://localhost:3000/api

Request Body Example
```json
{
    "notification": {
        "date": "Sat, 21 May 2022 11:23:03 +0200",
        "title": "Creating New Notification",
        "description": "Using the API to create a new notification"
    }
}
```
Response Body Example
```json
{
    "id": 2,
    "date": "2022-05-21T09:23:03.000Z",
    "title": "Creating New Notification",
    "description": "Using the API to create a new notification",
    "users_notified": []
}
```

<br/><h4 id=4 align="left">:: As Admin, I can update a notification</h4>
Admins can update one or more fields of existing notifications. The attributes should be passed in the request body.

<br/>[PATCH] 
<br/>Endpoint: /v1/notifications/:id
<br/>Host: http://localhost:3000/api

Request Body Example
```json
{
    "notification": {
         "title": "New Title"
     }
}
```
Response Body Example
```json
{
    "id": 2,
    "date": "2022-05-21T09:23:03.000Z",
    "title": "New Title",
    "description": "Using the API to create a new notification",
    "users_notified": []
}
```

<br/><h4 id=5 align="left">:: As Admin, I can assign a notification to one or multiple clients</h4>
After a notification is created, Admins can assign them to one multiple Clients passing an array of users ids to the request body. The request creates instance(s) of UserNotification.

<br/>[POST] 
<br/>Endpoint: /v1/notifications/:notification_id/user_notifications
<br/>Host: http://localhost:3000/api

Request Body Example
```json
{
    "user_notification": {
        "user_ids": [
            2
        ]
    }
}
```
Response Body Example
```json
{
    "id": 1,
    "date": "2022-05-21T00:00:00.000Z",
    "title": "New Title",
    "description": "Notification 01 description",
    "user_notifications": [
        {
            "id": 2,
            "seen": false,
            "user_id": 2,
            "email": "pedro@gmail.com"
        }
    ]
}
```

<br/><h4 id=6 align="left">:: As Admin, I can delete a notification</h4>
Admins are able to delete notifications. Deleting a notification will automatically delete all the user_notifications associated to it. The request will return 204 No Content status if it’s successful.

<br/>[DELETE] 
<br/>Endpoint: /v1/notifications/:id
<br/>Host: http://localhost:3000/api

<br/><h4 id=7 align="left">:: As Admin, I can delete a user_notification</h4>
Admins can also delete user_notifications. The request will return 204 No Content status if it’s successful.

<br/>[DELETE] 
<br/>Endpoint: /v1/notifications/:notification_id/user_notifications/:id
<br/>Host: http://localhost:3000/api

<br/><h4 id=8 align="left">:: As a Client, I can view all my notifications</h4>
A Client can see a list of all the notifications assigned to him (user_notifications). Opening this list will not change the fild "seen" status, which will only change if the Client makes a request for one specific user_notification (#show). Admins can also see the entire list of the user_notifications.

<br/>[GET] 
<br/>Endpoint: /v1/user_notifications
<br/>Host: http://localhost:3000/api

```json
[
    {
        "id": 4,
        "seen": false,
        "user_id": 2,
        "notification_id": 1
    },
     {
        "id": 5,
        "seen": false,
        "user_id": 2,
        "notification_id": 2
    }
]
```

<br/><h4 id=9 align="left">:: As a Client, I can view one notification</h4>
A Client is able to see a notification assigned to him using his token to authenticate himself. Admins also have permission to see a notification assigned to a user to know if it has been seen or not.

The first time a Client views a notification, the seen field will be automatically updated to “true”. This does not happen if the admin views this notification.

Users who have not been assigned this notification do not have permission to visualize it.

<br/>[GET] 
<br/>Endpoint: /v1/notifications/:notification_id/user_notifications/:id
<br/>Host: http://localhost:3000/api

Response Body Example
```json
{
    "id": 4,
    "seen": true,
    "user_id": 2,
    "notification": {
        "id": 1,
        "title": "Testing Update",
        "description": "Notification 01 description"
    }
}
```
