#!/usr/bin/python3
from flask import Blueprint, jsonify, abort, request
from ..models import Patron, db
import hashlib
import secrets
import re

bp = Blueprint('patrons', __name__, url_prefix='/patrons')


@bp.route('', methods=['GET'])  # decorator takes path and list of HTTP verbs.
def index():
    patrons = Patron.query.all()  # ORM performs SELECT query
    result = []
    for patron in patrons:
        result.append(patron.serialize())  # Build a list of Tweets as dictionaires
    return jsonify(result)  # Return JSON response


@bp.route('/<int:id>', methods=['GET'])
def show(id: int):
    patron = Patron.query.get_or_404(id)
    return jsonify(patron.serialize())  # Return JSON response


@bp.route('', methods=['POST'])
def create():
    if 'name' not in request.json or 'sex' not in request.json or 'user_id' not in request.json or 'city_id' not in request.json:
        return abort(400, f"400 ERROR: please ensure the name and sex attributes are provided within the POST body. A user id and city id are also required attributes.")

    name = request.json['name']
    sex = request.json['sex']
    user_id = request.json['user_id']
    city_id = request.json['city_id']

    patron = Patron(
        name=name,
        sex=sex,
        user_id=user_id,
        city_id=city_id
    )

    try:
        db.session.add(patron)
        db.session.commit()
        return jsonify(patron.serialize())
    except:
        return abort(400, f"400 ERROR: please ensure that the targetted user ID does not already have a patron associated with it.")


@bp.route('/<int:id>', methods=['DELETE'])
def delete(id: int):
    patron = Patron.query.get_or_404(id)
    try:
        db.session.delete(patron)  # prepare DELETE statement
        db.session.commit()  # execute DELETE statement
        return jsonify(True)
    except:
        # something went wrong
        return jsonify(False)


# @bp.route('/<int:id>', methods=['PATCH', 'PUT'])
# def update(id: int):
#     user = User_Account.query.get_or_404(id)
#     if 'username' not in request.json and 'password' not in request.json:
#         return jsonify(False)

#     if 'username' in request.json:
#         username = request.json['username']
#     if 'password' in request.json:
#         password = request.json['password']

#     for key in request.json.keys():
#         if key == 'username':
#             if len(username) < 3:
#                 return jsonify(False)
#             user.username = username
#         if key == 'password':
#             if len(password) < 8:
#                 return jsonify(False)
#             user.password = scramble(password)

#     db.session.commit()
#     return jsonify(True)
