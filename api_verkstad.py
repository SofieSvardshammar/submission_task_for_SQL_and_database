# start uvicorn: python -m uvicorn api_verkstad:app --reload
from pydantic import BaseModel
from fastapi import FastAPI

# Import of the database logic
from db_verkstad import Verkstad

app = FastAPI()

# cerate database
db_verkstad = Verkstad("verkstad.db")


# _DATA CLASSES__________________________________________________
class Manufacturer(BaseModel):
    manufacturer_id: int = None
    manufacturer_name: str
    contact_person: str
    phone_number: str
    country: str


class Department(BaseModel):
    department_id: int = None 
    location_area: str
    number_of_employees: int
    income_2021: int
    number_of_served_cars_2021: int



#_______ GET MANUFACTURER ______________________________
@app.get("/get_manufacturer")
def get_manufacturers():
    get_manufacturer_query = """
    SELECT * FROM manufacturer
    """
    data = db_verkstad.call_db_verkstad(get_manufacturer_query)
    manufacturers = []
    for element in data:
        manufacturer_id, manufacturer_name, contact_person, phone_number, country = element
        manufacturers.append(Manufacturer(manufacturer_id=manufacturer_id, manufacturer_name=manufacturer_name, contact_person=contact_person, phone_number=phone_number, country=country))
    return manufacturers

#_______ GET DEPARTMENT ______________________________
@app.get("/get_department")
def get_departments():
    get_department_query = """
    SELECT * FROM department
    """
    data = db_verkstad.call_db_verkstad(get_department_query)
    departments = []
    for element in data:
        department_id, location_area, number_of_employees, income_2021, number_of_served_cars_2021 = element
        departments.append(Department(department_id=department_id, location_area=location_area, number_of_employees=number_of_employees, income_2021=income_2021, number_of_served_cars_2021=number_of_served_cars_2021))
    return departments




#_______ POST MANUFACTURER ______________________________
@app.post("/add_manufacturer")
def add_manufactorer(manufacturer: Manufacturer):
    insert_query = """
    INSERT INTO manufacturer (manufacturer_id, manufacturer_name, contact_person, phone_number, country)
    VALUES ( ?, ?, ?, ?, ?)
    """
    db_verkstad.call_db_verkstad(insert_query, manufacturer.manufacturer_id, manufacturer.manufacturer_name, manufacturer.contact_person, manufacturer.phone_number, manufacturer.country)
    return "Add manufacturer"

#_______ POST DEPARTMENT ______________________________
@app.post("/add_department")
def add_menu(department: Department):
    insert_query = """
    INSERT INTO department (department_id, location_area, number_of_employees, income_2021, number_of_served_cars_2021)
    VALUES ( ?, ?, ?, ?, ?)
    """
    db_verkstad.call_db_verkstad(insert_query, department.department_id, department.location_area, department.number_of_employees, department.income_2021, department.number_of_served_cars_2021)
    return "Add department"




#_______ DELETE MANUFACTURER ______________________________
@app.delete("/delete_manufacturer/{manufacturer_id}")
def delete_manufacturer(manufacturer_id: int):
    delete_query = """
    DELETE FROM manufacturer WHERE manufacturer_id = ?
    """
    db_verkstad.call_db_verkstad(delete_query, manufacturer_id)
    return True


#_______ PUT MANUFACTURER __________________________________
@app.put("/update_manufacturer/{manufacturer_id}")
def update_manufacturer(manufacturer_id: int, new_manufacturer: Manufacturer):
    update_manufacturer_query = """
    UPDATE manufacturer
    SET manufacturer_name = ?, contact_person = ?, phone_number = ?, country = ?
    WHERE manufacturer_id = ?
    """
    db_verkstad.call_db_verkstad(update_manufacturer_query, new_manufacturer.manufacturer_name, new_manufacturer.contact_person, new_manufacturer.phone_number, new_manufacturer.country, manufacturer_id)

    return True

