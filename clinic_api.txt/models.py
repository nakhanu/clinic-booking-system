from sqlalchemy import Column, Integer, String, Date, Enum, ForeignKey, Text, DECIMAL, Time, DateTime
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func
from database import Base

class Patient(Base):
    __tablename__ = "patients"

    patient_id = Column(Integer, primary_key=True, index=True)
    full_name = Column(String(100), nullable=False)
    gender = Column(Enum("Male", "Female", "Other"), nullable=False)
    date_of_birth = Column(Date, nullable=False)
    phone = Column(String(15), unique=True, nullable=False)
    email = Column(String(100))
    created_at = Column(DateTime(timezone=True), server_default=func.now())

    appointments = relationship("Appointment", back_populates="patient")

class Doctor(Base):
    __tablename__ = "doctors"

    doctor_id = Column(Integer, primary_key=True, index=True)
    full_name = Column(String(100), nullable=False)
    specialization = Column(String(100), nullable=False)
    phone = Column(String(15), unique=True)
    email = Column(String(100))
    created_at = Column(DateTime(timezone=True), server_default=func.now())

    appointments = relationship("Appointment", back_populates="doctor")

class Service(Base):
    __tablename__ = "services"

    service_id = Column(Integer, primary_key=True, index=True)
    service_name = Column(String(100), nullable=False)
    description = Column(Text)
    fee = Column(DECIMAL(10, 2), nullable=False)

    appointments = relationship("Appointment", back_populates="service")

class Appointment(Base):
    __tablename__ = "appointments"

    appointment_id = Column(Integer, primary_key=True, index=True)
    patient_id = Column(Integer, ForeignKey("patients.patient_id"))
    doctor_id = Column(Integer, ForeignKey("doctors.doctor_id"))
    service_id = Column(Integer, ForeignKey("services.service_id"))
    appointment_date = Column(Date, nullable=False)
    appointment_time = Column(Time, nullable=False)
    status = Column(Enum("Scheduled", "Completed", "Cancelled"), default="Scheduled")

    patient = relationship("Patient", back_populates="appointments")
    doctor = relationship("Doctor", back_populates="appointments")
    service = relationship("Service", back_populates="appointments")
    payment = relationship("Payment", back_populates="appointment", uselist=False)

class Payment(Base):
    __tablename__ = "payments"

    payment_id = Column(Integer, primary_key=True, index=True)
    appointment_id = Column(Integer, ForeignKey("appointments.appointment_id", ondelete="CASCADE"), nullable=False)
    amount = Column(DECIMAL(10, 2), nullable=False)
    payment_method = Column(String(50), nullable=False)
    payment_date = Column(DateTime, server_default=func.now())
    status = Column(String(50), default="Completed")

    appointment = relationship("Appointment", back_populates="payment")
