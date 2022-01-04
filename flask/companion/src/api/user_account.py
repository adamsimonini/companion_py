#!/usr/bin/python3
from flask import Blueprint, jsonify, abort, request
from ..models import User_Account, db
import hashlib
import secrets
import re

bp = Blueprint('users', __name__, url_prefix='/users')


def scramble(password: str):
    """Hash and salt the given password"""
    salt = secrets.token_hex(16)
    return hashlib.sha512((password + salt).encode('utf-8')).hexdigest()


def validateEmail(email):
    regex = r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b'
    if(re.fullmatch(regex, email)):
        return True
    return False


@bp.route('', methods=['GET'])  # decorator takes path and list of HTTP verbs.
def index():
    users = User_Account.query.all()  # ORM performs SELECT query
    result = []
    for user in users:
        result.append(user.serialize())  # Build a list of Tweets as dictionaires
    return jsonify(result)  # Return JSON response


@bp.route('/<int:id>', methods=['GET'])
def show(id: int):
    user = User_Account.query.get_or_404(id)
    return jsonify(user.serialize())  # Return JSON response


@bp.route('', methods=['POST'])
def create():
    if 'email' not in request.json or 'password' not in request.json or 'phone_number' not in request.json or 'birthday' not in request.json:
        return abort(400, f"400 ERROR: please ensure an email, password, phone number, and birthday are provided within the POST body.")

    email = request.json['email']
    password = request.json['password']
    phone_number = request.json['phone_number']
    birthday = request.json['birthday']

    # if len(password) < 8:
    if not validateEmail(email) or len(password) < 8:
        # print(validateEmail(email))
        return abort(400, f"400 ERROR: failed at email/password validation. Email provided: {email}")

    user = User_Account(
        email=email,
        password=scramble(password),
        phone_number=phone_number,
        birthday=birthday
    )

    db.session.add(user)
    db.session.commit()
    return jsonify(user.serialize())


@bp.route('/<int:id>', methods=['DELETE'])
def delete(id: int):
    print(id)
    user = User_Account.query.get_or_404(id)
    try:
        db.session.delete(user)  # prepare DELETE statement
        db.session.commit()  # execute DELETE statement
        return jsonify(True)
    except:
        # something went wrong
        return jsonify(False)


@bp.route('/<int:id>', methods=['PATCH', 'PUT'])
def update(id: int):
    user = User_Account.query.get_or_404(id)
    if 'username' not in request.json and 'password' not in request.json:
        return jsonify(False)

    if 'username' in request.json:
        username = request.json['username']
    if 'password' in request.json:
        password = request.json['password']

    for key in request.json.keys():
        if key == 'username':
            if len(username) < 3:
                return jsonify(False)
            user.username = username
        if key == 'password':
            if len(password) < 8:
                return jsonify(False)
            user.password = scramble(password)

    db.session.commit()
    return jsonify(True)
