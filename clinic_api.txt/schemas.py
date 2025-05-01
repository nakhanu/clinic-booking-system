from pydantic import BaseModel
from typing import Optional
from datetime import date, time

class PatientCreate(BaseModel):
    full_name: str
    gender: str
    date_of_birth: date
    phone: str
    email: Optional[str]

class PatientOut(PatientCreate):
    patient_id: int

    class Config:
        orm_mode = True

class AppointmentCreate(BaseModel):
    patient_id: int
    appointment_date: date
    appointment_time: time
    status: Optional[str] = "Scheduled"

class AppointmentOut(AppointmentCreate):
    appointment_id: int

    class Config:
        orm_mode = True
