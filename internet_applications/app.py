from numbers import Number

from flask import Flask, render_template, request, abort

app = Flask(__name__, template_folder='templates')


def evaluate(form):
    a = float(form.get('a'))
    b = float(form.get('b'))
    op = form.get('op')
    if op == '+':
        return a + b
    elif op == '-':
        return a - b
    elif op == '*':
        return a * b
    elif op == '/':
        return a / b
    else:
        return None


@app.route('/lab01/', methods=['GET', 'POST'])
def hello():
    if request.method == 'GET':
        return render_template('form.html', errors=[], result='')
    elif request.method == 'POST':
        result = evaluate(request.form)
        if result is None:
            return render_template('form.html', **{**request.form, 'errors': ['Incorrect data passed'], 'result': ''})
        return render_template('form.html', **{**request.form, 'result': result})


if __name__ == "__main__":
    app.run(debug=True)
