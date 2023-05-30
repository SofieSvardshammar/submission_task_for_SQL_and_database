import requests
from typing import List
from api_verkstad import Manufacturer, Department


# Function that returns route with the url
def url(route: str):     
    return f"http://127.0.0.1:8000{route}"

# Print menu 
def print_menu():
    print(
        """
    1: Add manufacturer
    2: Add department
    3: Get manufacturer
    4: Get department
    5: Delete manufacturer
    6: Update manufacturer
    7: Exit program
    """
    )



#________________________________ ADD MANUFACTURER _______________________________________________
def add_manufacturer():
    print("Add manufactuerer")
    manufacturer_id = input("manufacturer_id: ")
    manufacturer_name = input("manufacturer name: ")
    contact_person = input("contact person: ")
    phone_number = input("phone number: ")
    country = input("country: ")
    New_manufacturer = Manufacturer(manufacturer_id=manufacturer_id, manufacturer_name=manufacturer_name, contact_person=contact_person, phone_number=phone_number, country=country)
    res = requests.post(url("/add_manufacturer"), json=New_manufacturer.dict())
    print(res)

#________________________________ ADD DEPARTMENT _______________________________________________
def add_department():
    print("Add department")
    department_id = input("department id: ")
    location_area = input("location area: ")
    number_of_employees = input("number of employees: ")
    income_2021 = input("income 2021: ")
    number_of_served_cars_2021 = input("number of served cars 2021: ")
    New_department = Department(department_id=department_id, location_area=location_area, number_of_employees=number_of_employees, income_2021=income_2021, number_of_served_cars_2021=number_of_served_cars_2021)
    res = requests.post(url("/add_department"), json=New_department.dict())
    print(res)



#________________________________ GET  MANUFACTURER_______________________________________________
def get_manufacturer():
    manufacturers = []
    print("Get manufacturer")
    res = requests.get(url("/get_manufacturer"))
    data = res.json()
    for manufacturer in data:
        manufacturer = Manufacturer(**manufacturer)
        print("_______________")
        print(f"manufacturer id: {manufacturer.manufacturer_id}")
        print(f"manufacturer name: {manufacturer.manufacturer_name}")
        print(f"contact person: {manufacturer.contact_person}")
        print(f"phone number: {manufacturer.phone_number}")
        print(f"country: {manufacturer.country}")
        manufacturers.append(manufacturer)
    return manufacturers

#________________________________ GET  DEPARTMENT_______________________________________________
def get_department():
    departments = []
    print("Get department")
    res = requests.get(url("/get_department"))
    data = res.json()
    for department in data:
        department = Department(**department)  
        print("_______________")
        print(f"department id: {department.department_id}")
        print(f"location area: {department.location_area}")
        print(f"number of employees: {department.number_of_employees}")
        print(f"income 2021: {department.income_2021}")
        print(f"number of serve cars 2021: {department.number_of_served_cars_2021}")
        departments.append(department)
    return departments


#________________________________ DELETE MANUFACTURER __________________________________________________
def delete_manufacturer():
    print("Delete manufacturer")
    manufacturer_to_delete = input("Id of manufacturer you wish to delete: ")
    if not str.isdigit(manufacturer_to_delete):
        print("Ids are integers")
        return
    res = requests.delete(url(f"/delete_manufacturer/{manufacturer_to_delete}"))
    print(res.json())


#________________________________ UPDATE MANUFACTURER __________________________________________________
def update_manufacturer(manufacturers: List[Manufacturer]):
    manufacturer_to_update = input("Id of manufactorer you wish to update: ")
# Warn the user if the selected value is not a number
    if not str.isdigit(manufacturer_to_update):
        print("Ids are integers")
        return


# Loop for finding the ID
    index = None
    for i, manufacturer in enumerate(manufacturers):
        if manufacturer.manufacturer_id == int(manufacturer_to_update):
            index = i
            break

# Warns the user if the selected value does not exist
    if index == None:
        print("No such manufacturer")
        return
    manufacturer = manufacturers[index]

# 
    manufacturer_name = input("manufacturer name (leave blank if same): ")
    contact_person = input("contact person (Leave blank if same): ")
    phone_number = input("phone_number (leave blank if same): ")
    country = input("country (Leave blank if same): ")

    if not manufacturer_name:
        manufacturer_name = manufacturer.manufacturer_name
    if not contact_person:
        contact_person = manufacturer.contact_person
    if not phone_number:
        phone_number = manufacturer.phone_number
    if not country:
        country = manufacturer.country

    new_manufacturer = Manufacturer(manufacturer_name=manufacturer_name, contact_person=contact_person, phone_number=phone_number, country=country)
    res = requests.put(url(f"/update_manufacturer/{manufacturer_to_update}"), json=new_manufacturer.dict())




#______________________________ Menu loop _____________________________________________________
def main():
    print_menu()
    choice = input("Please choose your action: ")
    choice = choice.strip()
    if not str.isdigit(choice):
        print("Please enter a valid option")        
        return                                     

    match int(choice):
        case 1:
            add_manufacturer()
        case 2:
            add_department()
        case 3:
            manufacturers = get_manufacturer()
        case 4:
            departments = get_department()
        case 5:
            delete_manufacturer()
        case 6:
            manufacturers = get_manufacturer()
            update_manufacturer(manufacturers)
        case 7:
            exit()
        case _:
            print("Please enter a valid choice")

# ______________________________ Infinit-loop ______________________________
while __name__ == "__main__":
    main()