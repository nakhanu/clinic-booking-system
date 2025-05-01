from fastapi import FastAPI, Depends
from sqlalchemy.orm import Session
import models, schemas, crud
from database import SessionLocal, engine
from fastapi import HTTPException


models.Base.metadata.create_all(bind=engine)

app = FastAPI()

# Dependency to get DB session
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@app.post("/patients/", response_model=schemas.PatientOut)
def create_patient(patient: schemas.PatientCreate, db: Session = Depends(get_db)):
    return crud.create_patient(db, patient)

@app.get("/patients/", response_model=list[schemas.PatientOut])
def read_patients(db: Session = Depends(get_db)):
    return crud.get_patients(db)

@app.put("/patients/{patient_id}", response_model=schemas.PatientOut)
def update_patient(patient_id: int, patient: schemas.PatientCreate, db: Session = Depends(get_db)):
    updated = crud.update_patient(db, patient_id, patient)
    if not updated:
        raise HTTPException(status_code=404, detail="Patient not found")
    return updated

@app.delete("/patients/{patient_id}")
def delete_patient(patient_id: int, db: Session = Depends(get_db)):
    deleted = crud.delete_patient(db, patient_id)
    if not deleted:
        raise HTTPException(status_code=404, detail="Patient not found")
    return {"message": "Patient deleted successfully"}