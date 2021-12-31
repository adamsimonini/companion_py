# from sqlalchemy import create_engine, Column, Integer, String, DateTime
# from sqlalchemy.orm import sessionmaker, declarative_base
from datetime import datetime

from flask_sqlalchemy import SQLAlchemy

# Connect to Postgres database
# engine = create_engine('postgresql://postgres@localhost:5432/companion')
# Session = sessionmaker(bind=engine)
# Base = declarative_base()

db = SQLAlchemy()


class User_Account(db.Model):
    def __init__(self, email: str, password: str, phone_number: str, birthday: datetime):
        self.password = password
        self.phone_number = phone_number
        self.email = email
        self.birthday = birthday

    __tablename__ = "user_account"

    # set autoincrement to use the SERIAL data type
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    password = db.Column(db.String, nullable=False)
    phone_number = db.Column(db.String, unique=True, nullable=False, )
    email = db.Column(db.String, unique=True, nullable=False)
    birthday = db.Column(db.String, nullable=False)
    created_at = db.Column(db.DateTime(timezone=True), default=datetime.now())

    def serialize(self):
        return {
            'id': self.id,
            'email': self.email,
            'password': self.password,
            'phone_number': self.phone_number,
            'birthday': self.birthday,
            'created_at': self.created_at
        }


# Recreate all tables each time script is run
# Base.metadata.drop_all(engine)
# Base.metadata.create_all(engine)

user_account_seed = [
    {'password': 'abcdefg', 'phone_number': '1231231234', 'email': 'abc@g.com', 'birthday': '1990-01-01'},
    {'password': 'abcdefg', 'phone_number': '4445556666', 'email': 'efg@g.com', 'birthday': '1980-01-01'},
    {'password': 'abcdefg', 'phone_number': '2223334455', 'email': 'hij@g.com', 'birthday': '1977-01-01'},
    {'password': 'abcdefg', 'phone_number': '9998887766', 'email': 'lmn@g.com', 'birthday': '1998-01-01'},
    {'password': 'abcdefg', 'phone_number': '5556667788', 'email': 'opq@g.com', 'birthday': '1988-01-01'},
]

# Turn the seed data into a list of Veggie objects
user_objs = []
for user in user_account_seed:
    u = User_Account(
        password=user['password'],
        phone_number=user["phone_number"],
        email=user["email"],
        birthday=user["email"],
    )
    user_objs.append(u)

# Create a session, insert new records, and commit the session
# session = db.Session()
# session.bulk_save_objects(user_objs)
# session.commit()
