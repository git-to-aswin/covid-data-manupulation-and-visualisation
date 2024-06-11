import sqlite3

def queryDB(query):
    try:
        with sqlite3.connect("../Vaccinations.db") as conn:
            cur = conn.cursor()
            if query != None:
                cur.execute(query) 
                row = cur.fetchall()
                return row
            else:
                return None
    except sqlite3.Error as e:
        print(e)