from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, declarative_base

# Replace with your MySQL credentials
DATABASE_URL = "mysql+pymysql://root:2934Sophia.@localhost/clinic_booking_db"

engine = create_engine(DATABASE_URL)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

Base = declarative_base()
