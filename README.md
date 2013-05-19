Instruction and Usage
---------------------

1. Clone the git repo
2. Run the bundle command inside the directory
3. Run the following command
    rake db:create
    rake db:migrate
    rake db:seed
4. Fire up the web server thin start
   thin start or rails s
5. Browse to http://localhost:3000 or whatever port you started thin on.


Firefox can't establish a connection to the server at ws://192.168.1.106:3000/websocket.

The first time when I started application I was getting above error. But then I started with thin start command it worked fine

SQLite3::BusyException: database is locked: commit transaction

ActiveRecord::Base.connection.execute("BEGIN TRANSACTION; END;")
