# Backend App Development with Flask

# Reference:
# https://flask-sqlalchemy.palletsprojects.com/en/2.x/models/
# https://docs.sqlalchemy.org/en/14/core/metadata.html#sqlalchemy.schema.Column
# https://flask-sqlalchemy.palletsprojects.com/en/2.x/models/#many-to-many-relationships

# from sqlalchemy import create_engine, Column, Integer, String, DateTime
# from sqlalchemy.orm import sessionmaker, declarative_base
from flask_sqlalchemy import SQLAlchemy
from datetime import datetime

db = SQLAlchemy()


# Create the User_Account model


class User_Account(db.Model):
    def __init__(self, email: str, password: str, phone_number: str, birthday: datetime):
        self.email = email
        self.password = password
        self.phone_number = phone_number
        self.birthday = birthday

    __tablename__ = "user_account"

    # set autoincrement to use the SERIAL data type
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    email = db.Column(db.String, unique=True, nullable=False)
    password = db.Column(db.String, nullable=False)
    phone_number = db.Column(db.String, unique=True, nullable=False, )
    birthday = db.Column(db.String, nullable=False)
    created_at = db.Column(
        db.DateTime,
        default=datetime.utcnow,
        nullable=False
    )

    companion = db.relationship('Companion', backref='user_account', cascade="all,delete")
    patron = db.relationship('Patron', backref='user_account', cascade="all,delete")

    def serialize(self):
        return {
            'id': self.id,
            'email': self.email,
            'password': self.password,
            'phone_number': self.phone_number,
            'birthday': self.birthday,
            'created_at': self.created_at
        }


# Create the Companion model


class Companion(db.Model):
    def __init__(self, name: str, sex: str, user_id: int, city_id: int, hourly_rate=30, is_active=False):
        self.name = name
        self.sex = sex,
        self.fk_user_account_id = user_id,
        self.fk_city_id = city_id,
        self.hourly_rate = hourly_rate,
        self.is_active = is_active

    __tablename__ = 'companion'
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    name = db.Column(db.String(100), nullable=False)
    sex = db.Column(db.String(50), nullable=False)
    fk_user_account_id = db.Column(db.SmallInteger(), nullable=False, unique=True)
    fk_city_id = db.Column(db.SmallInteger(), nullable=False)
    hourly_rate = db.Column(db.SmallInteger(), nullable=False)
    is_active = db.Column(db.Boolean(), nullable=False)
    created_at = db.Column(
        db.DateTime,
        default=datetime.utcnow,
        nullable=False
    )
    # Use the db.ForeignKey method provided by Flask to ensure that every companion has one user_account
    fk_user_account_id = db.Column(db.Integer, db.ForeignKey('user_account.id'), nullable=False)

    def serialize(self):
        return {
            'id': self.id,
            'name': self.name,
            'sex': self.sex,
            "hourly_rate": self.hourly_rate,
            'is_active': self.is_active,
            'created_at': self.created_at.isoformat(),
        }


class Patron(db.Model):
    def __init__(self, name: str, sex: str, user_id: int, city_id: int):
        self.name = name
        self.sex = sex
        self.fk_user_account_id = user_id,
        self.fk_city_id = city_id,

    __tablename__ = 'patron'
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    name = db.Column(db.String(100), nullable=False)
    sex = db.Column(db.String(50), nullable=False)
    fk_user_account_id = db.Column(db.SmallInteger(), nullable=False, unique=True)
    fk_city_id = db.Column(db.SmallInteger(), nullable=False)
    created_at = db.Column(
        db.DateTime,
        default=datetime.utcnow,
        nullable=False
    )
    # Use the db.ForeignKey method provided by Flask to ensure that every companion has one user_account
    fk_user_account_id = db.Column(db.Integer, db.ForeignKey('user_account.id'), nullable=False)

    def serialize(self):
        return {
            'id': self.id,
            'name': self.name,
            'sex': self.sex,
            'created_at': self.created_at.isoformat(),
        }

# # Recreate all tables each time script is run
# Base.metadata.drop_all(engine)
# Base.metadata.create_all(engine)


# user_account_seed = [
#     {'password': 'abcdefg', 'phone_number': '1231231234', 'email': 'abc@g.com', 'birthday': '1990-01-01'},
#     {'password': 'abcdefg', 'phone_number': '4445556666', 'email': 'efg@g.com', 'birthday': '1980-01-01'},
#     {'password': 'abcdefg', 'phone_number': '2223334455', 'email': 'hij@g.com', 'birthday': '1977-01-01'},
#     {'password': 'abcdefg', 'phone_number': '9998887766', 'email': 'lmn@g.com', 'birthday': '1998-01-01'},
#     {'password': 'abcdefg', 'phone_number': '5556667788', 'email': 'opq@g.com', 'birthday': '1988-01-01'},
# ]

# # Turn the seed data into a list of User objects
# user_objs = []
# for user in user_account_seed:
#     u = User_Account(
#         password=user['password'],
#         phone_number=user["phone_number"],
#         email=user["email"],
#         birthday=user["email"],
#     )
#     user_objs.append(u)

# # Create a session, insert new records, and commit the session
# session = Session()
# session.bulk_save_objects(user_objs)
# session.commit()

# # Create a new session for performing queries
# session = Session()

# # SELECT * FROM veggies
# users = session.query(User_Account).all()

# print('INSERTED USERS:', users)
# print('')  # separator
