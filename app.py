from flask import Flask, render_template, send_from_directory

app = Flask(__name__, static_url_path='/static', static_folder='static')

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/models/<path:filename>')
def serve_model(filename):
    return send_from_directory('static/models', filename)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=7860)  # 👈 Important: use port 7860
