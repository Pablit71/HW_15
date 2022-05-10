from flask import Flask, jsonify
import sqlite3
import json

app = Flask(__name__)
app.config['JSON_AS_ASCII'] = False


def connect(query):
    connection = sqlite3.connect('animal.db')
    cursor = connection.cursor()
    cursor.execute(query)
    result = cursor.fetchall()
    connection.close()
    return result


@app.route('/<int:itemid>')
def main(itemid):
    query = f"""
                SELECT "name", breed, animal_id, date_of_birth
                FROM animals_end
                WHERE "id" = '{itemid}'
                """
    response = connect(query)
    response_json = []
    for data in response:
        response_json.append({
            'name': data[0],
            'breed': data[1],
            'animals_id': data[2],
            'date_of_birth': data[3],
        })
    return jsonify(response_json)

app.run(debug=True)
