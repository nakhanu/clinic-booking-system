-- Create the database
CREATE DATABASE clinic_booking_db;

USE clinic_booking_db;

-- Create Patients table
CREATE TABLE Patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    gender ENUM('Male', 'Female', 'Other') NOT NULL DEFAULT 'Other',
    date_of_birth DATE NOT NULL,
    phone VARCHAR(15) UNIQUE NOT NULL,
    email VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Doctors table
CREATE TABLE Doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    specialization VARCHAR(100) NOT NULL,
    phone VARCHAR(15) UNIQUE,
    email VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Services table
CREATE TABLE Services (
    service_id INT AUTO_INCREMENT PRIMARY KEY,
    service_name VARCHAR(100) NOT NULL,
    description TEXT,
    fee DECIMAL(10, 2) NOT NULL
);

-- Create Appointments table
CREATE TABLE Appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    service_id INT,
    appointment_date DATE NOT NULL,
    appointment_time TIME NOT NULL,
    status ENUM('Scheduled', 'Completed', 'Cancelled') DEFAULT 'Scheduled',
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id),
    FOREIGN KEY (service_id) REFERENCES Services(service_id)
);

-- Create Payments table
CREATE TABLE Payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_method VARCHAR(50) NOT NULL,
    payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(50) DEFAULT 'Completed',
    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id)
        ON DELETE CASCADE
);

-- Insert into Patients
INSERT INTO Patients (full_name, gender, email, phone, date_of_birth) VALUES
('John Doe', 'Male', 'john@example.com', '0700123456', '1990-05-14'),
('Jane Smith', 'Female', 'jane@example.com', '0701122334', '1985-08-21'),
('Peter Mwangi', 'Male', 'peter.m@example.com', '0711223344', '1993-03-19'),
('Lucy Wanjiku', 'Female', 'lucy.w@example.com', '0722123456', '1988-10-07'),
('Michael Otieno', 'Male', 'michael.o@example.com', '0733112233', '1975-12-25'),
('Grace Njeri', 'Female', 'grace.n@example.com', '0744556677', '1996-07-30'),
('Kevin Ouma', 'Male', 'kevin.o@example.com', '0755667788', '1992-11-11'),
('Mercy Atieno', 'Female', 'mercy.a@example.com', '0766778899', '1994-09-05'),
('Brian Kiprono', 'Male', 'brian.k@example.com', '0777888999', '1989-01-15'),
('Catherine Nyambura', 'Female', 'catherine.n@example.com', '0788990001', '1991-04-28');

-- Insert into Doctors
INSERT INTO Doctors (full_name, specialization, email, phone) VALUES
('Dr. Alice Kendi', 'Pediatrics', 'alice.k@example.com', '0700001111'),
('Dr. Mark Kimani', 'Dermatology', 'mark.k@example.com', '0711112222'),
('Dr. David Mutua', 'Cardiology', 'david.m@example.com', '0722223333'),
('Dr. Sarah Wambui', 'Gynecology', 'sarah.w@example.com', '0733334444'),
('Dr. James Omondi', 'ENT', 'james.o@example.com', '0744445555'),
('Dr. Esther Achieng', 'General Practice', 'esther.a@example.com', '0755556666'),
('Dr. Paul Kipchumba', 'Orthopedics', 'paul.k@example.com', '0766667777'),
('Dr. Ann Naliaka', 'Neurology', 'ann.n@example.com', '0777778888'),
('Dr. Henry Mugo', 'Physiotherapy', 'henry.m@example.com', '0788889999'),
('Dr. Susan Mutheu', 'Dentistry', 'susan.m@example.com', '0799990000');

-- Insert into Services
INSERT INTO Services (service_name, description, fee) VALUES
('General Consultation', 'Basic health consultation', 250.00),
('Dental Checkup', 'Routine dental check', 1000.00),
('Physiotherapy', 'Therapy for physical recovery', 300.00),
('Eye Examination', 'Vision and eye health check', 830.00),
('Pediatric Care', 'Healthcare for children', 350.00),
('Vaccination', 'Routine vaccinations', 200.00),
('Dermatology', 'Skin health consultation', 1050.00),
('ENT Services', 'Ear, nose, and throat checkup', 380.00),
('Mental Health Counseling', 'Psychological and emotional support', 600.00),
('Chronic Disease Management', 'Follow-up for chronic conditions', 1550.00);

-- Insert into Appointments
INSERT INTO Appointments (patient_id, doctor_id, service_id, appointment_date, appointment_time, status) VALUES
(1, 3, 1, '2025-05-01', '10:00:00', 'Scheduled'),
(2, 1, 5, '2025-05-01', '11:00:00', 'Completed'),
(3, 5, 8, '2025-05-02', '09:30:00', 'Scheduled'),
(4, 4, 4, '2025-05-02', '10:30:00', 'Cancelled'),
(5, 2, 7, '2025-05-03', '08:00:00', 'Scheduled'),
(6, 6, 1, '2025-05-03', '14:00:00', 'Completed'),
(7, 9, 3, '2025-05-04', '13:00:00', 'Scheduled'),
(8, 8, 9, '2025-05-04', '15:00:00', 'Scheduled'),
(9, 10, 2, '2025-05-05', '10:15:00', 'Completed'),
(10, 7, 10, '2025-05-05', '12:00:00', 'Scheduled');

-- Insert into Payments
INSERT INTO Payments (appointment_id, amount, payment_method, status) VALUES
(1, 1500.00, 'Cash', 'Completed'),
(2, 2500.00, 'M-Pesa', 'Completed'),
(3, 1800.00, 'Card', 'Pending'),
(4, 2000.00, 'Cash', 'Cancelled'),
(5, 3000.00, 'M-Pesa', 'Completed'),
(6, 1600.00, 'Card', 'Completed'),
(7, 2200.00, 'M-Pesa', 'Pending'),
(8, 1900.00, 'Cash', 'Completed'),
(9, 2800.00, 'Card', 'Completed'),
(10, 2100.00, 'M-Pesa', 'Completed');
