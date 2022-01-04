from flask import Flask, render_template, request, redirect
from flask_cors import CORS
from flask_mysqldb import MySQL

app = Flask(__name__)
CORS(app)

# Db Config
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'idealcrop_developer'
app.config['MYSQL_PASSWORD'] = 'l_Lux0ejI3om!Q6e'
app.config['MYSQL_DB'] = 'idealcrop'
app.config['MYSQL_CURSORCLASS'] = 'DictCursor'

mysql = MySQL(app)

# Function to fetch data from the db
def db_query(query):
    try:
    cursor = mysql.connection.cursor()
        cursor.execute(query)
        result = cursor.fetchall()
        cursor.close()
        return result
    except Exception as e:
        print("An error occured:")
        print(e)
        return {'db_error': True}

# Normal Routes
@app.route('/')
def index():
    title = "IdealCrop"
    return render_template('index.html',title=title)

@app.route('/crop-recommend')
def crop_recommend():
    title = "Recommend Crop"
    activeTab = "crop_recommend"
    return render_template('crop-recommend.html',title=title, activeTab=activeTab)

@app.route('/npk-recommend')
def npk_recommend():
    title = "Recommend NPK"
    activeTab = "npk_recommend"
    return render_template('npk-recommend.html',title=title, activeTab=activeTab)

@app.route('/crop-varieties')
def crop_varieties():
    # Getting crops from db
    crops = db_query("SELECT * FROM crop")
    
    # Other route info
    title = "Crop Varieties"
    activeTab = "varieties"
    return render_template('crop-varieties.html',title=title, activeTab=activeTab, crops=crops)

@app.route('/practices')
def ideal_practices():
    title = "Recommend Crop"
    activeTab = "practices"
    return render_template('practices.html',title=title, activeTab=activeTab)

@app.route('/zoning')
def crop_zoning():
    title = "Recommend Crop"
    activeTab = "zoning"
    return render_template('zoning.html',title=title, activeTab=activeTab)

# Error Routes

@app.errorhandler(404)
def not_found(e):
  return render_template("404.html")

if __name__ == "__main__":
    app.run(debug=True)