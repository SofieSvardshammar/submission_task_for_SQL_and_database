import sqlite3
import os

#create class
class Verkstad:

# init function, call the url
    def __init__(self, db_verkstad_url: str):
        self.db_verkstad_url = db_verkstad_url

        if not os.path.exists(self.db_verkstad_url):
            self.init_db_verkstad()

# call database 
    def call_db_verkstad(self, query, *args):
        conn = sqlite3.connect(self.db_verkstad_url)
        cur = conn.cursor()
        res = cur.execute(query, args)
        data = res.fetchall()
        cur.close()
        conn.commit()
        conn.close()
        return data

# recurrent funtion of table "manufacturer"
    def init_db_verkstad(self):
        init_db_verkstad_query = """
        CREATE TABLE IF NOT EXISTS manufacturer(
            manufacturer_id INTEGER NOT NULL,
            manufacturer_name TEXT NOT NULL,
            contact_person TEXT NOT NULL,
            phone_number TEXT NOT NULL,
            country TEXT NOT NULL
        );
        """ 
# recurrent funtion of table "department"        
        init_db_verkstad_query2 = """
        CREATE TABLE IF NOT EXISTS department(
            department_id INTEGER NOT NULL,
            location_area TEXT NOT NULL,
            number_of_employees INTEGER NOT NULL,
            income_2021 INTEGER NOT NULL,
            number_of_served_cars_2021 INTERGER NOT NULL
        );
        """
# run function
        self.call_db_verkstad(init_db_verkstad_query)
        self.call_db_verkstad(init_db_verkstad_query2)       

