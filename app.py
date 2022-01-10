from flask import Flask, render_template, request, redirect
from flask_cors import CORS
from flask_mysqldb import MySQL
import numpy as np
import requests
import config
import pickle
import io

crop_recommendation_model_path = 'model/RandomForest.pkl'
crop_recommendation_model = pickle.load(
    open(crop_recommendation_model_path, 'rb'))


def weather_fetch(city_name):
    """
    Fetch and returns the temperature and humidity of a city
    :params: city_name
    :return: temperature, humidity
    """
    api_key = "abfb8146fd98ef50e173ea3093df08d5"
    total_temperature = 0
    total_humidity = 0
    average_temperature = 0
    average_humidity = 0
    base_url = "https://pro.openweathermap.org/data/2.5/forecast/climate?"

    complete_url = base_url + "q=" + city_name + "&appid=" + api_key
    response = requests.get(complete_url)
    x = response.json()

    if x["code"] != "404":
        for i in x['list']:
            total_temperature += (i['temp']['max'])

        for h in x['list']:
            total_humidity += h['humidity']

        average_temperature = total_temperature / 30
        average_humidity = total_humidity / 30

        temperature = round((average_temperature - 273.15), 2)
        humidity = average_humidity
        return temperature, humidity
    else:
        return None


app = Flask(__name__)
CORS(app)
app.jinja_env.add_extension('jinja2.ext.loopcontrols')
app.config.from_object(__name__)

# Db Config
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'idealcrop_developer'
app.config['MYSQL_PASSWORD'] = 'l_Lux0ejI3om!Q6e'
app.config['MYSQL_DB'] = 'idealcrop'
app.config['MYSQL_CURSORCLASS'] = 'DictCursor'

mysql = MySQL(app)

# Utilities

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

# Function to check if db result set is empty or has errors
def check_result(result_set, subject):
    if len(result_set) == 0:
        return "No " + subject + " found"
    elif len(result_set) == 1 and result_set['db_error']:
        return "Error"
    else:
        return "True"

# Recommendation Routes

# Normal Routes
@app.route('/crop-predict', methods=['POST'])
def crop_prediction():
    title = 'Crop prediction'

    if request.method == 'POST':
        N = int(request.form['nitrogen'])
        P = int(request.form['phosphorus'])
        K = int(request.form['potassium'])
        ph = float(request.form['ph'])
        rainfall = 100
        city = request.form.get('district')

        if weather_fetch(city) != None:
            temperature, humidity = weather_fetch(city)
            data = np.array([[N, P, K, temperature, humidity, ph, rainfall]])
            my_prediction = crop_recommendation_model.predict(data)
            final_prediction = my_prediction[0]

            return render_template('crop-result.html', prediction=final_prediction, title=title)

        else:
            return render_template('404.html', title=title)


@app.route('/')
def index():
    title = "IdealCrop"
    return render_template('index.html', title=title)


@app.route('/crop-recommend')
def crop_recommend():
    # Route info
    title = "Recommend Crop"
    activeTab = "crop_recommend"
    return render_template('crop-recommend.html', title=title, activeTab=activeTab)


@app.route('/npk-recommend')
def npk_recommend():
    # Route info
    title = "Recommend NPK"
    activeTab = "npk_recommend"
    return render_template('npk-recommend.html', title=title, activeTab=activeTab)


@app.route('/crop-varieties')
def crop_varieties():
    # Getting crops from db
    crops = db_query("SELECT * FROM crop")
    
    # Route info
    title = "Crop Varieties"
    activeTab = "varieties"
    return render_template('crop-varieties.html', title=title, activeTab=activeTab, crops=crops)


@app.route('/crop-varieties/<int:id>')
def show_varieties(id):
    # Getting varities for selected crop
    query = "SELECT variety.variety_name, variety.maturity_duration, variety.yield, variety.special_attributes, crop.crop_name FROM variety "
    query += "LEFT JOIN species ON variety.species = species.id "
    query += "LEFT JOIN crop ON species.crop = crop.id WHERE species.crop = '" + str(id) + "'"

    varieties = db_query(query)

    # Determine crop name with error handling
    if check_result(varieties, 'varieties') == "True":
        cropName = varieties[0]['crop_name'].capitalize()
    else:
        cropName = check_result(varieties, 'varieties')

    # Route info
    title="Crop Varieties"
    activeTab = "varieties"

    return render_template('crop-varieties-list.html', title=title, activeTab=activeTab, varieties=varieties,
                           cropName=cropName)


@app.route('/practices')
def ideal_practices():
    # Get crops from db
    crops = db_query("SELECT * FROM crop")

    # Route info
    title = "Cultivation Practices"
    activeTab = "practices"
    return render_template('practices.html',title=title, activeTab=activeTab, crops=crops)

@app.route('/practices/<int:id>')
def show_practices(id):
    # Getting varities for selected crop
    query = "SELECT crop_practice.id, stage.stage_name, practice.practice_name, crop_practice.practice_description, crop.crop_name "
    query += "FROM crop_practice LEFT JOIN practice ON crop_practice.practice = practice.id "
    query += "LEFT JOIN stage ON crop_practice.stage = stage.id LEFT JOIN crop ON crop_practice.crop = crop.id "
    query += "WHERE crop_practice.crop = '"+ str(id) +"'"

    practices = db_query(query)

    # Determine crop name with error handling
    if check_result(practices, 'practices') == "True":
        cropName = practices[0]['crop_name'].capitalize()
    else:
        cropName = check_result(practices, 'practices')

    # Route info
    title = "Cultivation Practices"
    activeTab = "practices"
    return render_template('practices-list.html',title=title, activeTab=activeTab, practices=practices, cropName=cropName)

@app.route('/zoning')
def crop_zoning():
    # Route info
    title = "Crop Zoning"
    activeTab = "zoning"
    return render_template('zoning.html', title=title, activeTab=activeTab)


# Error Routes

@app.errorhandler(404)
def not_found(e):
    return render_template("404.html")

@app.errorhandler(405)
def method_not_allowed(e):
    return render_template("405.html")

if __name__ == "__main__":
    app.run(debug=True)
