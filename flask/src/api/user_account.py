#!/usr/bin/python3
from flask import Blueprint, jsonify, abort, request
from ..models import User_Account, db
import hashlib
import secrets


def scramble(password: str):
    """Hash and salt the given password"""
    salt = secrets.token_hex(16)
    return hashlib.sha512((password + salt).encode('utf-8')).hexdigest()


bp = Blueprint('users', __name__, url_prefix='/users')


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
    if 'username' not in request.json or 'password' not in request.json:
        return abort(400)

    username = request.json['username']
    password = request.json['password']

    if len(username) < 3 or len(password) < 8:
        return abort(400)

    user = User_Account(
        username=username,
        password=scramble(password)
    )

    db.session.add(user)
    db.session.commit()
    return jsonify(user.serialize())


@bp.route('/<int:id>', methods=['DELETE'])
def delete(id: int):
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
