#!/usr/bin/python3
from flask import Blueprint, jsonify, abort, request
from ..models import Companion, db
import hashlib
import secrets
import re

bp = Blueprint('companions', __name__, url_prefix='/companions')


@bp.route('', methods=['GET'])  # decorator takes path and list of HTTP verbs.
def index():
    companions = Companion.query.all()  # ORM performs SELECT query
    result = []
    for companion in companions:
        result.append(companion.serialize())  # Build a list of Tweets as dictionaires
    return jsonify(result)  # Return JSON response


@bp.route('/<int:id>', methods=['GET'])
def show(id: int):
    companion = Companion.query.get_or_404(id)
    return jsonify(companion.serialize())  # Return JSON response


@bp.route('', methods=['POST'])
def create():
    if 'name' not in request.json or 'sex' not in request.json or 'user_id' not in request.json or 'sexual_orientation_id' not in request.json or 'city_id' not in request.json:
        return abort(400, f"400 ERROR: please ensure the name, sex, and sexual orientation attributes are provided within the POST body. A user id and city id are also required attributes.")

    name = request.json['name']
    sex = request.json['sex']
    user_id = request.json['user_id']
    sexual_orientation_id = request.json['sexual_orientation_id']
    city_id = request.json['city_id']

    companion = Companion(
        name=name,
        sex=sex,
        user_id=user_id,
        sexual_orientation_id=sexual_orientation_id,
        city_id=city_id
    )

    try:
        db.session.add(companion)
        db.session.commit()
        return jsonify(companion.serialize())
    except:
        return abort(400, f"400 ERROR: please ensure that the targetted user ID does not already have a companion associated with it.")


@bp.route('/<int:id>', methods=['DELETE'])
def delete(id: int):
    companion = Companion.query.get_or_404(id)
    try:
        db.session.delete(companion)  # prepare DELETE statement
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
