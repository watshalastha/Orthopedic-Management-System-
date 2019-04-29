drop database hms_db;
create database hms_db;
USE hms_db;

DROP TABLE IF EXISTS doctor;
CREATE TABLE doctor (
  DoctorID VARCHAR(50) NOT NULL,
  DoctorName TEXT NOT NULL,
  FatherName TEXT NOT NULL,
  Address TEXT NOT NULL,
  ContactNo TEXT NOT NULL,
  Email TEXT NOT NULL,
  Qualifications TEXT NOT NULL,
  Specialization TEXT NOT NULL,
  Gender TEXT NOT NULL,
  Bloodgroup TEXT NOT NULL,
  DateOfJoining TEXT NOT NULL,
  PRIMARY KEY (DoctorID)
);
DROP TABLE IF EXISTS patientregistration;
CREATE TABLE patientregistration (
  PatientID VARCHAR(50) NOT NULL,
  Patientname TEXT NOT NULL,
  Fathername TEXT NOT NULL,
  Address TEXT NOT NULL,
  ContactNo TEXT NOT NULL,
  Email TEXT NOT NULL,
  Age INT(11) NOT NULL,
  Gen TEXT NOT NULL,
  BG TEXT NOT NULL,
  Remarks TEXT NOT NULL,
  PRIMARY KEY (PatientID)
);

DROP TABLE IF EXISTS registration;
CREATE TABLE registration (
  username VARCHAR(100) NOT NULL,
  password VARCHAR(50) NOT NULL,
  NameOfUser VARCHAR(250) NOT NULL,
  ContactNo VARCHAR(15) NOT NULL,
  Email VARCHAR(250) NOT NULL,
  PRIMARY KEY (username)
);

DROP TABLE IF EXISTS room;
CREATE TABLE room (
  RoomNo VARCHAR(50) NOT NULL,
  RoomType VARCHAR(100) NOT NULL,
  RoomCharges INT(11) NOT NULL,
  RoomStatus VARCHAR(100) NOT NULL,
  PRIMARY KEY (RoomNo)
);

DROP TABLE IF EXISTS services;
CREATE TABLE services (
  ServiceID INT(11) NOT NULL AUTO_INCREMENT,
  ServiceName VARCHAR(250) NOT NULL,
  ServiceDate VARCHAR(50) NOT NULL,
  PatientID VARCHAR(50) NOT NULL,
  ServiceCharges INT(11) NOT NULL,
  PRIMARY KEY (ServiceID)
);

DROP TABLE IF EXISTS wardboy_nurse_tbl;
CREATE TABLE wardboy_nurse_tbl (
  ID VARCHAR(50) NOT NULL,
  W_N_Name VARCHAR(250) NOT NULL,
  Category VARCHAR(250) NOT NULL,
  Address VARCHAR(250) NOT NULL,
  ContactNo VARCHAR(15) NOT NULL,
  Email VARCHAR(250) NOT NULL,
  Qualifications VARCHAR(250) NOT NULL,
  BloodGroup VARCHAR(50) NOT NULL,
  DateOfJoining VARCHAR(50) NOT NULL,
  PRIMARY KEY (ID)
);

DROP TABLE IF EXISTS admitpatient_room;
CREATE TABLE admitpatient_room (
  AdmitID INT(11) NOT NULL AUTO_INCREMENT,
  PatientID VARCHAR(50) NOT NULL,
  Disease TEXT NOT NULL,
  RoomNo VARCHAR(50) NOT NULL,
  AdmitDate TEXT NOT NULL,
  DoctorID VARCHAR(50) NOT NULL,
  AP_Remarks TEXT NOT NULL,
  PRIMARY KEY (AdmitID),
  INDEX DoctorID (DoctorID),
  INDEX DoctorID_2 (DoctorID),
  INDEX PatientID (PatientID),
  INDEX RoomNo (RoomNo),
  CONSTRAINT admitpatient_room_ibfk_1 FOREIGN KEY (PatientID)
    REFERENCES patientregistration(PatientID) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT admitpatient_room_ibfk_2 FOREIGN KEY (RoomNo)
    REFERENCES room(RoomNo) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT admitpatient_room_ibfk_3 FOREIGN KEY (DoctorID)
    REFERENCES doctor(DoctorID) ON DELETE RESTRICT ON UPDATE RESTRICT
);


DROP TABLE IF EXISTS users;
CREATE TABLE users (
  username VARCHAR(100) NOT NULL,
  user_password VARCHAR(50) NOT NULL,
  PRIMARY KEY (username),
  CONSTRAINT users_ibfk_1 FOREIGN KEY (username)
    REFERENCES registration(username) ON DELETE RESTRICT ON UPDATE RESTRICT
);

DROP TABLE IF EXISTS dischargepatient_room;
CREATE TABLE dischargepatient_room (
  ID INT(11) NOT NULL AUTO_INCREMENT,
  AdmitID INT(11) NOT NULL,
  DischargeDate TEXT NOT NULL,
  DP_Remarks TEXT NOT NULL,
  PRIMARY KEY (ID),
  INDEX AdmitID (AdmitID),
  CONSTRAINT dischargepatient_room_ibfk_1 FOREIGN KEY (AdmitID)
    REFERENCES admitpatient_room(AdmitID) ON DELETE RESTRICT ON UPDATE RESTRICT
);



DROP TABLE IF EXISTS bill_room;
CREATE TABLE bill_room (
  BillNo INT(11) NOT NULL AUTO_INCREMENT,
  DischargeID INT(11) NOT NULL,
  BillingDate TEXT NOT NULL,
  NoOfDays INT(11) NOT NULL,
  RoomCharges DOUBLE NOT NULL,
  TotalRoomCharges DOUBLE NOT NULL,
  ServiceCharges DOUBLE NOT NULL,
  TotalCharges DOUBLE NOT NULL,
  PaymentMode TEXT NOT NULL,
  PaymentModeDetails TEXT NOT NULL,
  ChargesPaid DOUBLE NOT NULL,
  DueCharges DOUBLE NOT NULL,
  PRIMARY KEY (BillNo),
  INDEX DischargeID (DischargeID),
  INDEX DischargeID_2 (DischargeID),
  CONSTRAINT bill_room_ibfk_1 FOREIGN KEY (DischargeID)
    REFERENCES dischargepatient_room(ID) ON DELETE RESTRICT ON UPDATE RESTRICT
);
DROP TABLE IF EXISTS ortho_ward;
create table ortho_ward(
Ortho_id VARCHAR(50) NOT NULL,
Patient_id VARCHAR(50) NOT NULL,
Diagnosis  LONGTEXT   NOT NULL,
Investigations LONGTEXT NOT NULL,
Date Date NOT NULL,
Room_No VARCHAR(45) NOT NULL,
Plan  LONGTEXT NOT NULL,
PRIMARY KEY(ortho_id),
FOREIGN KEY(Patient_id) REFERENCES patientregistration(PatientID),
FOREIGN KEY(Room_No) REFERENCES room(RoomNo)
);

INSERT INTO doctor VALUES
('1', 'Aakash', 'Paudyal', 'Kathmandu', '9818660545', 'aakashpaudyal@gmail.com', 'MBBS', 'Heart', 'M', 'O+', '10/10/2014');


INSERT INTO patientregistration VALUES
('P-1', 'Palistha', 'Watshala', 'Kathmandu', '9849300003', 'jivankandel@gmail.com', 23, 'F', 'A+', '');


INSERT INTO registration VALUES
('admin', '12345', 'Jeevan Kandel', '9818660545', 'jivankandel@gmail.com');

INSERT INTO room VALUES
('101', 'General', 1200, 'Vacant'),
('102', 'Deluxe', 2200, 'Vacant');

INSERT INTO services VALUES
(1, 'X-ray Test', '23/10/2015', 'P-1', 2300);





INSERT INTO admitpatient_room VALUES
(1, 'P-1', 'fever', '101', '22/10/2015', '1', '');


INSERT INTO users VALUES
('admin', '12345');


INSERT INTO dischargepatient_room VALUES
(1, 1, '24/10/2015', '');


INSERT INTO bill_room VALUES
(1, 1, '24/10/2015', 2, 1200, 2400, 2300, 4700, 'by Cash', '', 4700, 0);

