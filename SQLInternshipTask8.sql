USE EyeHospitalDB;

--Stored Procedures:
--A stored procedure is a set of SQL statements that can be executed repeatedly with a single command. They can take parameters, perform complex logic, and return results.

--Get Patient Details: A procedure that retrieves patient information based on patient ID.
CREATE PROCEDURE GetPatientDetails(
  @PatientID INT
)
AS
BEGIN
  SELECT * FROM Patients
  WHERE PatientID = @PatientID;
END;

-- Call the stored procedure
EXEC GetPatientDetails @PatientID = 1;

--Update Patient Information: A procedure that updates patient information.
CREATE PROCEDURE UpdatePatientInfo(
  @PatientID INT,
  @Name VARCHAR(50),
  @Email VARCHAR(100)
)
AS
BEGIN
  UPDATE Patients
  SET Name = @Name, Email = @Email
  WHERE PatientID = @PatientID;
END;

-- Call the stored procedure
EXEC UpdatePatientInfo @PatientID = 1, @Name = 'Jane Doe', @Email = 'janedoe@example.com';

-- call the patient information from patient table
SELECT * FROM Patients WHERE PatientID = 1;

-- Get the Doctors appointment : A procedure that retrieves doctor appointments based on doctor ID.
CREATE PROCEDURE GetDoctorAppointments(
  @DoctorID INT
)
AS
BEGIN
  SELECT A.AppointmentDate, P.Name AS PatientName
  FROM Appointments A
  JOIN Patients P ON A.PatientID = P.PatientID
  WHERE A.DoctorID = @DoctorID;
END;

-- Call the stored procedure
EXEC GetDoctorAppointments @DoctorID = 1;


--Functions:
--A function is a reusable block of SQL code that returns a value. They can be used in SELECT statements and can take parameters.

--Get Doctor's Name: A function that returns a doctor's name based on doctor ID.
CREATE FUNCTION GetDoctorName(
  @DoctorID INT
)
RETURNS VARCHAR(50)
AS
BEGIN
  DECLARE @Name VARCHAR(50);
  SELECT @Name = Name
  FROM Doctors
  WHERE DoctorID = @DoctorID;
  RETURN @Name;
END;

-- Use the function in a SELECT statement
SELECT dbo.GetDoctorName(1) AS DoctorName;

--Calculate Total Appointments: A function that calculates the total number of appointments for a doctor.
CREATE FUNCTION GetTotalAppointments(
  @DoctorID INT
)
RETURNS INT
AS
BEGIN
  DECLARE @Total INT;
  SELECT @Total = COUNT(*)
  FROM Appointments
  WHERE DoctorID = @DoctorID;
  RETURN @Total;
END;

-- Use the function in a SELECT statement
SELECT  dbo.GetTotalAppointments(1);

--Table-Valued Functions:
--Get Patient Appointments: A function that returns a table of patient appointments.
CREATE FUNCTION Get_Patient_Appointments(
  @PatientID INT
)
RETURNS TABLE
AS
RETURN (
  SELECT A.AppointmentDate, D.Name AS DoctorName
  FROM Appointments A
  JOIN Doctors D ON A.DoctorID = D.DoctorID
  WHERE A.PatientID = @PatientID
);

-- Use the function in a SELECT statement
SELECT * FROM dbo.Get_Patient_Appointments(1);
