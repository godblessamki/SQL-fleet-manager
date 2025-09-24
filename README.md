# 🚗 ProjektAutobazar – SQL Fleet Manager

**ProjektAutobazar** is a comprehensive SQL database project designed to manage all key aspects of a car rental or dealership business. It provides a robust structure for handling cars, customers, reservations, employees, insurance, and more. The included `databazeee.sql` file sets up the complete database schema with sample data, making it ideal for learning, demos, or as a starting point for a real-world fleet management solution.

## 🗄️ Database Structure

The database contains the following main tables:

- **Auta**: Vehicles offered (brand, model, year)
- **Zakaznici**: Customers (name, surname, phone)
- **Rezervace**: Reservations (customer, car, dates, status)
- **Servisy**: Service records (car, date, description, cost)
- **Kategorie**: Car categories (e.g., SUV, luxury, electric)
- **Pojisteni**: Insurance (type, validity, price)
- **Zamestnanci**: Employees (contact, role)
- **Jizdy**: Rental rides (linking cars, customers, employees)
- **Ceniky**: Pricing per category or car
- **Pokuty**: Fines (for rides, reason, amount)

## 🌟 Key Features

- **Relational Integrity**: Extensive use of foreign keys and `ON DELETE` actions ensures data consistency.
- **Sample Data**: Pre-filled dataset for immediate experimentation.
- **Realistic Scenarios**: Overlapping reservations, multiple insurance types, and detailed fines and service records.
- **Comprehensive Coverage**: Handles all major processes of a car fleet or rental company.

## 🚀 How to Use

1. **Import the SQL file**  
   Run the `databazeee.sql` script in your MySQL or MariaDB environment:
   ```sh
   mysql -u username -p < databazeee.sql
   ```
2. **Explore the Schema**  
   Query the tables, make joins, and experiment with realistic data.

3. **Extend or Integrate**  
   Use this as a foundation for applications, reporting, or further database development.

## 📂 Example Tables Overview

| Table         | Description                     |
|---------------|---------------------------------|
| `Auta`        | List of all cars                |
| `Zakaznici`   | Customer details                |
| `Rezervace`   | Car reservation records         |
| `Servisy`     | Service and maintenance history |
| `Kategorie`   | Vehicle categories              |
| `Pojisteni`   | Insurance policies per car      |
| `Zamestnanci` | Employees                       |
| `Jizdy`       | Specific rental rides           |
| `Ceniky`      | Pricing by car/category         |
| `Pokuty`      | Fines for rides                 |

## 📜 Sample Data Included

- 8 vehicles from different brands and years
- 8 customers with Czech names and phone numbers
- Realistic reservations, service, insurance, and fine records

---

> **Tip:** Use this database for practicing SQL joins, constraints, and data analysis in a real-world context!

---

**Author:** [godblessamki](https://github.com/godblessamki)  
**Repository:** [SQL-fleet-manager](https://github.com/godblessamki/SQL-fleet-manager)
