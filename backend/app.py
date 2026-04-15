from flask import Flask, jsonify
import requests
import sqlite3
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

@app.route('/')
def home():
    return jsonify({'status': 'Backend is running'})

@app.route('/api/hello')
def hello():
    # Fetch from third-party API
    response = requests.get('https://jsonplaceholder.typicode.com/posts/1')
    data = response.json()
    message = f"Hello World: {data['title']}"
    
    # Store in DB
    conn = sqlite3.connect('messages.db')
    c = conn.cursor()
    c.execute('CREATE TABLE IF NOT EXISTS messages (id INTEGER PRIMARY KEY, content TEXT)')
    c.execute('INSERT INTO messages (content) VALUES (?)', (message,))
    conn.commit()
    conn.close()
    
    return jsonify({'message': message})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
# branch fix/Validation_on_JWT: validation placeholder comment
