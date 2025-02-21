CREATE DATABASE fintech;
USE fintech;

CREATE TABLE Customer_Classification (
    Customer_Classification_ID INT AUTO_INCREMENT PRIMARY KEY,
    Customer_Classification_Type VARCHAR(100) NOT NULL,
    Customer_Classification_Type_Value VARCHAR(100) NOT NULL,
    Effective_Date DATE,
    UNIQUE(Customer_Classification_Type, Customer_Classification_Type_Value)
);


INSERT INTO Customer_Classification (Customer_Classification_Type, Customer_Classification_Type_Value, Effective_Date)
VALUES ('Id Type', 'Passport', '2025-01-01'),
       ('Name Type', 'Full Name', '2025-01-01'),
       ('Customer Type', 'Premium', '2025-01-01');

CREATE TABLE Customer_Identification (
    Customer_Identification_ID INT AUTO_INCREMENT PRIMARY KEY,
    Customer_Identification_Type INT,
    Customer_Identification_Item VARCHAR(255) NOT NULL,
    Effective_Date DATE,
    FOREIGN KEY (Customer_Identification_Type) REFERENCES Customer_Classification(Customer_Classification_ID) 
);

-- Sample Insert Data
INSERT INTO Customer_Identification (Customer_Identification_Type, Customer_Identification_Item, Effective_Date)
VALUES (1, '1234567890', '2025-01-01'),
       (2, '9876543210', '2025-01-01');

CREATE TABLE Customer_Details (
    Customer_Number INT AUTO_INCREMENT PRIMARY KEY,
    Customer_Type VARCHAR(50) NOT NULL,
    Customer_Full_Name VARCHAR(255) NOT NULL,
    Customer_DOB DATE,
    Customer_DOI DATE,
    Customer_Status VARCHAR(50),
    Customer_Contact_Number VARCHAR(15),
    Customer_Mobile_Number VARCHAR(15),
    Customer_Email_ID VARCHAR(255),
    Customer_Country_of_Origination VARCHAR(50),
    Effective_Date DATE,
    UNIQUE(Customer_Email_ID) -- Assumption: Email is unique for each customer
);


INSERT INTO Customer_Details (Customer_Type, Customer_Full_Name, Customer_DOB, Customer_Status, Customer_Contact_Number, Customer_Mobile_Number, Customer_Email_ID, Customer_Country_of_Origination, Effective_Date)
VALUES ('Individual', 'John Doe', '1985-04-15', 'Active', '1234567890', '9876543210', 'johndoe@example.com', 'USA', '2025-01-01'),
       ('Corporate', 'Acme Corp.', NULL, 'Active', '5555555555', '6666666666', 'contact@acmecorp.com', 'USA', '2025-01-01');

CREATE TABLE Customer_Name_Components (
    Customer_Identifier INT,
    Customer_Name_Component_Type INT,
    Customer_Name_Value VARCHAR(255),
    Effective_Date DATE,
    PRIMARY KEY (Customer_Identifier, Customer_Name_Component_Type),
    FOREIGN KEY (Customer_Identifier) REFERENCES Customer_Details(Customer_Number),
    FOREIGN KEY (Customer_Name_Component_Type) REFERENCES Customer_Classification(Customer_Classification_ID)
);


INSERT INTO Customer_Name_Components (Customer_Identifier, Customer_Name_Component_Type, Customer_Name_Value, Effective_Date)
VALUES (1, 2, 'John Doe', '2025-01-01');  -- Assuming '2' is the classification ID for Full Name

CREATE TABLE Customer_Proof_of_Identity (
    Customer_Identifier INT,
    Customer_Proof_of_ID_Type INT,
    Customer_Classification_Type_Value VARCHAR(255),
    Start_Date DATE,
    End_Date DATE,
    Effective_Date DATE,
    PRIMARY KEY (Customer_Identifier, Customer_Proof_of_ID_Type),
    FOREIGN KEY (Customer_Identifier) REFERENCES Customer_Details(Customer_Number),
    FOREIGN KEY (Customer_Proof_of_ID_Type) REFERENCES Customer_Classification(Customer_Classification_ID)
);


INSERT INTO Customer_Proof_of_Identity (Customer_Identifier, Customer_Proof_of_ID_Type, Customer_Classification_Type_Value, Start_Date, End_Date, Effective_Date)
VALUES (1, 1, 'Passport', '2025-01-01', '2030-01-01', '2025-01-01');  -- Assuming '1' is the classification ID for Passport

CREATE TABLE Customer_Address (
    Customer_Identifier INT,
    Customer_Address_Component_Type INT,
    Customer_Address_Value VARCHAR(255),
    Effective_Date DATE,
    PRIMARY KEY (Customer_Identifier, Customer_Address_Component_Type),
    FOREIGN KEY (Customer_Identifier) REFERENCES Customer_Details(Customer_Number),
    FOREIGN KEY (Customer_Address_Component_Type) REFERENCES Customer_Classification(Customer_Classification_ID)
);


INSERT INTO Customer_Address (Customer_Identifier, Customer_Address_Component_Type, Customer_Address_Value, Effective_Date)
VALUES (1, 3, '123 Main St, Springfield, IL', '2025-01-01');  -- Assuming '3' is the classification ID for Address Type
