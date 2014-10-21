from flask import Flask
import flask.ext.sqlalchemy
import flask.ext.restless

app = Flask(__name__, static_url_path='')
app.config['DEBUG'] = True
# To use a SQLite :memory: database, specify an empty URL:
# app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite://'
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:////tmp/test.db'
db = flask.ext.sqlalchemy.SQLAlchemy(app)

class Person(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.Unicode, unique=True)
    birth_date = db.Column(db.Date)


class Computer(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.Unicode, unique=True)
    vendor = db.Column(db.Unicode)
    purchase_time = db.Column(db.DateTime)
    owner_id = db.Column(db.Integer, db.ForeignKey('person.id'))
    owner = db.relationship('Person', backref=db.backref('computers',
                                                         lazy='dynamic'))
# create the database tables.
db.create_all()

# Create the Flask-Restless API manager.
manager = flask.ext.restless.APIManager(app, flask_sqlalchemy_db=db)

# Create API endpoints, which will be available at /api/<tablename> by
# default. Allowed HTTP methods can be specified as well.
manager.create_api(Person, methods=['GET', 'POST', 'DELETE'])
manager.create_api(Computer, methods=['GET'])

@app.route("/hello")
def hello():
    return "Hello World!"

@app.route('/')
def root():
    return app.send_static_file('index.html')

if __name__ == "__main__":
    app.run(host='0.0.0.0',port=8000)
