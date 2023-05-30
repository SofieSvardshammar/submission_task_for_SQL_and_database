from db_verkstad import Verkstad
import json

# # Connect the database logic to insert the json file
db_verkstad = Verkstad("verkstad.db")

# Inserts value from the json file with label "manufacturer" into the database with the table of the same name
create_manufacturer = """
INSERT INTO manufacturer (
manufacturer_id,
manufacturer_name,
contact_person,
phone_number,
country
) VALUES (?, ?, ?, ?, ?)
"""

# Inserts value from the json file with label "department" into the database with the table of the same name 
create_department = """
INSERT INTO department (
department_id,
location_area,
number_of_employees,
income_2021,
number_of_served_cars_2021
) VALUES (?, ?, ?, ?, ?)
"""

# Open and read only the json file with this file
with open("verkstad.json", "r") as seeda_verkstad:
    data = json.load(seeda_verkstad)

# Call the database logic and insert the values into the table
    for manufacturer in data["manufacturer"]:
        db_verkstad.call_db_verkstad(create_manufacturer, manufacturer["manufacturer_id"], manufacturer["manufacturer_name"], manufacturer["contact_person"],manufacturer["phone_number"],manufacturer["country"])
    
    for department in data["department"]:
        db_verkstad.call_db_verkstad(create_department, department["department_id"], department["location_area"], department["number_of_employees"],department["income_2021"],department["number_of_served_cars_2021"])