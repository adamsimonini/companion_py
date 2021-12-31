from sqlalchemy import create_engine, Column, Integer, String, DateTime
from sqlalchemy.orm import sessionmaker, declarative_base
from datetime import datetime

# Connect to Postgres database
engine = create_engine('postgresql://postgres@localhost:5432/companion')
Session = sessionmaker(bind=engine)
Base = declarative_base()


class User_Account(Base):
    def __init__(self, password: str, phone_number: str, email: str, birthday: datetime):
        self.password = password
        self.phone_number = phone_number
        self.email = email
        self.birthday = birthday

    __tablename__ = "user_account"

    # set autoincrement to use the SERIAL data type
    id = Column(Integer, primary_key=True, autoincrement=True)
    password = Column(String, nullable=False)
    phone_number = Column(String, unique=True, nullable=False, )
    email = Column(String, unique=True, nullable=False)
    birthday = Column(String, nullable=False)
    created_at = Column(DateTime(timezone=True), default=datetime.now())

    def serialize(self):
        return {
            'id': self.id,
            'email': self.email,
            'phone_number': self.phone_number,
            'birthday': self.birthday,
            'created_at': self.created_at
        }


# Recreate all tables each time script is run
Base.metadata.drop_all(engine)
Base.metadata.create_all(engine)

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
session = Session()
session.bulk_save_objects(user_objs)
session.commit()
