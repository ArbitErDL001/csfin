from flask import Flask, request, jsonify, make_response
from flask_mysqldb import MySQL
from flask_jwt_extended import JWTManager, create_access_token, jwt_required
from dicttoxml import dicttoxml
import config

app = Flask(__name__)
app.config.from_object(config)
app.config['JWT_SECRET_KEY'] = 'secret123'

mysql = MySQL(app)
jwt = JWTManager(app)

#Create(POST)
@app.route('/songs', methods=['POST'])
@jwt_required()
def create_song():
    data = request.json
    if not data.get('title') or not data.get('artist'):
        return jsonify({'error': 'Missing fields'}), 400

    cur = mysql.connection.cursor()
    cur.execute(
        "INSERT INTO songs (title, artist, genre, year) VALUES (%s,%s,%s,%s)",
        (data['title'], data['artist'], data.get('genre'), data.get('year'))
    )
    mysql.connection.commit()
    return jsonify({'message': 'Song added'}), 201

#Read(GET)
@app.route('/songs', methods=['GET'])
def get_songs():
    format = request.args.get('format', 'json')
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM songs")
    rows = cur.fetchall()

    result = [{'id': r[0], 'title': r[1], 'artist': r[2], 'genre': r[3], 'year': r[4]} for r in rows]

    if format == 'xml':
        return make_response(dicttoxml(result), 200, {'Content-Type': 'application/xml'})
    return jsonify(result)

#Update(PUT)
@app.route('/songs/<int:id>', methods=['PUT'])
@jwt_required()
def update_song(id):
    data = request.json
    cur = mysql.connection.cursor()
    cur.execute("UPDATE songs SET title=%s WHERE id=%s", (data['title'], id))
    mysql.connection.commit()
    return jsonify({'message': 'Updated'})

#Delete(DELETE)
@app.route('/songs/<int:id>', methods=['DELETE'])
@jwt_required()
def delete_song(id):
    cur = mysql.connection.cursor()
    cur.execute("DELETE FROM songs WHERE id=%s", (id,))
    mysql.connection.commit()
    return jsonify({'message': 'Deleted'})

#User login to get JWT token
@app.route('/login', methods=['POST'])
def login():
    token = create_access_token(identity='admin')
    return jsonify(access_token=token)
