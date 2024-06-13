import sqlite3

database = "../TryVaccinations.db"

def queryDB(query,param=None):
    try:
        with sqlite3.connect(database) as conn:
            cur = conn.cursor()
            if query != None:
                if param == None:
                    cur.execute(query) 
                else:
                    cur.execute(query,param)
                row = cur.fetchall()
                return row
            else:
                return None
    except sqlite3.Error as e:
        print(e)

def queryFile(filePath):
    try:
        conn = sqlite3.connect(database)
        cur = conn.cursor()

        # Read SQL commands from the file
        with open(filePath, 'r') as file:
            sql_commands = file.read()

        # Execute SQL commands
        cur.executescript(sql_commands)

        # Commit changes and close the connection
        conn.commit()
        cur.close()
        print("successfully created teh database")
    except sqlite3.Error as e:
        print(e)