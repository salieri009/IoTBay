-- IoTBay Test User Accounts
-- Generated with real PBKDF2 password hashes

-- 1. Customer Account
-- Email: customer@iotbay.com
-- Password: Customer123!
-- Role: customer
INSERT INTO User (
    email, password, firstName, lastName, phoneNumber, postalCode,
    addressLine1, city, state, country, dateOfBirth, paymentMethod,
    role, isActive
) VALUES (
    'customer@iotbay.com',
    '6ZvrBCHRNlbPXhAo7mfiVA==$6oMRVQgjsIOfKTAdViTk9P8LvovzqWgcJcDvtsSRdAc=',
    'John',
    'Doe',
    '+1-555-0101',
    '10001',
    '123 Main Street',
    'New York',
    'NY',
    'US',
    '1990-01-15',
    'Credit Card',
    'customer',
    1
);

-- 2. Staff Account
-- Email: staff@iotbay.com
-- Password: Staff123!
-- Role: staff
INSERT INTO User (
    email, password, firstName, lastName, phoneNumber, postalCode,
    addressLine1, city, state, country, dateOfBirth, paymentMethod,
    role, isActive
) VALUES (
    'staff@iotbay.com',
    'JNFcWlULWtVEp8W1CQAj/Q==$cNFmDPjy/aoVxG7iKSUnyatXdCVUNumJE52UktDfiFU=',
    'Jane',
    'Smith',
    '+1-555-0102',
    '10002',
    '456 Oak Avenue',
    'Brooklyn',
    'NY',
    'US',
    '1985-05-20',
    'Debit Card',
    'staff',
    1
);

-- 3. Admin Account
-- Email: admin@iotbay.com
-- Password: Admin123!
-- Role: admin
INSERT INTO User (
    email, password, firstName, lastName, phoneNumber, postalCode,
    addressLine1, city, state, country, dateOfBirth, paymentMethod,
    role, isActive
) VALUES (
    'admin@iotbay.com',
    'AHumHVDk29IxboBBSXbjJQ==$YmURXvUmOkWR5mF5Vb2RZvws9q36RMFbr8UuwUxVGUY=',
    'Alice',
    'Johnson',
    '+1-555-0103',
    '10003',
    '789 Pine Road',
    'Manhattan',
    'NY',
    'US',
    '1980-12-10',
    'PayPal',
    'admin',
    1
);

-- Verify the insertions
SELECT id, email, firstName, lastName, role, isActive, createdAt 
FROM User 
WHERE email IN ('customer@iotbay.com', 'staff@iotbay.com', 'admin@iotbay.com');
