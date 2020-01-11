import json
import uuid
from numbers import Number

from flask import Flask, render_template, request, abort, make_response, session

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
def lab01():
    if request.method == 'GET':
        return render_template('form.html', errors=[], result='')
    elif request.method == 'POST':
        result = evaluate(request.form)
        if result is None:
            return render_template('form.html', **{**request.form, 'errors': ['Incorrect data passed'], 'result': ''})
        return render_template('form.html', **{**request.form, 'result': result})


@app.route('/lab02/', methods=['GET', 'POST'])
def lab02():
    default_form = json.loads(request.cookies.get('form', '{}'))
    past_results = json.loads(session.get('results', '[]'))
    if request.method == 'GET':
        return render_template('form2.html', **{'errors': [], 'result': '', **default_form}, past_results=past_results)
    elif request.method == 'POST':
        result = evaluate(request.form)
        if result is None:
            form = {**default_form, **request.form, 'errors': ['Incorrect data passed'], 'result': ''}
        else:
            form = {**default_form, **request.form, 'result': result}
            past_results.append(form)
            session['results'] = json.dumps(past_results)

        response = make_response(render_template('form2.html', **form, past_results=past_results))
        response.set_cookie('form', json.dumps(form))

        return response


if __name__ == "__main__":
    app.secret_key = uuid.uuid4().hex
    app.run(debug=True)
