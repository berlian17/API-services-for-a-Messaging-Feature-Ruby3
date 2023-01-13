Here I create User send new message using Ruby on Rails with sqlite. And I tested it with postman
Ruby v3
Rails v7
sqlite3

this is the endpoint used:
1. http://127.0.0.1:3000/user This endpoint is used for create user.
Input example
name: Berlian, email: admin@gmail.com, password: 12345678

2. http://127.0.0.1:3000/auth/login This endpoint is used for login authentication. 
Input example
email: admin@gmail.com, password: 12345678

3. http://127.0.0.1:3000/message This endpoint is used for user send new message.
Input example
to_user_id: 2, message: hallo

4. http://127.0.0.1:3000/room/message This endpoint is used for user user reply to existing conversation using the parameter id that was created before.
Input example
id: 1, to_user_id: 2, message: hai

#Using a different user. email: admin2@gmail.com, password : 12345678

5. http://127.0.0.1:3000/room This endpoint is used for user listing all messages in specific conversation using the parameter id that was created before.
#The id parameter is created after running the previous endpoint and is created randomly.
Input example
id: 1

6. http://127.0.0.1:3000/room-chat-list This endpoint is used for user listing all conversation they involved.

Thank You.
