from flask import Flask, render_template, request

app = Flask(__name__, template_folder='templates')


@app.route('/lab01/', methods=['GET', 'POST'])
def hello():
    if request.method == 'GET':
        return render_template('form.html', errors=[], result='')

if __name__ == "__main__":
    app.run(debug=True)