from flask import Flask, render_template, request, flash, redirect, url_for
from flask_sqlalchemy import SQLAlchemy
import requests
from datetime import date
from sqlalchemy.exc import SQLAlchemyError
import os

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///weather_app.db'
app.config['SECRET_KEY'] = os.urandom(24)
db = SQLAlchemy(app)

class WeatherModel(db.Model):
    entry_id = db.Column(db.Integer, primary_key=True)
    date = db.Column(db.String(100), nullable=False)
    city = db.Column(db.String(100), nullable=False)
    max_temp = db.Column(db.Float, nullable=False)
    min_temp = db.Column(db.Float, nullable=False)
    total_precip = db.Column(db.String(100), nullable=False)
    sunrise_hour = db.Column(db.String(100), nullable=False)
    sunset_hour = db.Column(db.String(100), nullable=False)
    wind_speed = db.Column(db.Float, nullable=False)

    def __repr__(self):
        return  f'<{self.entry_id} {self.date} {self.city}>'
    
@app.route('/')
def index():
    return render_template('index.html')

@app.route('/request', methods = ['GET'])
def request_weather():
    delete_entries_past()

    weather_api_key = '1ec4afd12b004c9cab1184145242302'
    city = request.args.get('city')  
    url = f"http://api.weatherapi.com/v1/forecast.json?key={weather_api_key}&q={city}&days=3"

    try:
        response = requests.get(url)
        response.raise_for_status()
        weather_data = response.json()
        weather_data_days = weather_data['forecast']['forecastday']

        for weather_day in weather_data_days:
            add_or_retrieve(weather_day, city)
        
        weather_3days = WeatherModel.query.filter_by(city=city).order_by(WeatherModel.date).all()
        return render_template('weather_page.html', weather_3days=weather_3days, city=city)

    except requests.HTTPError as http_error:
        flash(str(http_error))
        return redirect(url_for('index'))
    except Exception as error:
        flash(str(error))
        return redirect(url_for('index'))

def add_or_retrieve(weather_day, city):
    try:
        date = weather_day['date']

        forecast_day = weather_day['day']
        max_temp = forecast_day['maxtemp_c']
        min_temp = forecast_day['mintemp_c']
        total_precip = forecast_day['totalprecip_mm']
        wind_speed = forecast_day['maxwind_kph']

        forecast_astro = weather_day['astro']
        sunrise_hour = forecast_astro['sunrise']
        sunset_hour = forecast_astro['sunset']

        exists_entry = check_if_combination_exists(date, city)

        if exists_entry:
            exists_entry.max_temp = max_temp
            exists_entry.min_temp = min_temp
            exists_entry.total_precip = total_precip
            exists_entry.sunrise_hour = sunrise_hour
            exists_entry.sunset_hour = sunset_hour
            exists_entry.wind_speed = wind_speed
        else:
            new_entry = WeatherModel(date=date, city=city, max_temp=max_temp, min_temp=min_temp,
                                    total_precip=total_precip, sunrise_hour=sunrise_hour, 
                                    sunset_hour=sunset_hour, wind_speed=wind_speed)
            db.session.add(new_entry)
                
        db.session.commit()
    except SQLAlchemyError as error:
        db.session.rollback()
        flash(f'A database error occurred: {str(error)}')
        return redirect(url_for('index'))

def check_if_combination_exists(date, city):
    try:
        query_result = WeatherModel.query.filter_by(date=date, city=city).first()
        return query_result
    except SQLAlchemyError as error:
        flash(f'A database error occurred: {str(error)}')
        return redirect(url_for('index'))

def delete_entries_past():
    try:
        today_date = date.today().strftime('%Y-%m-%d')
        WeatherModel.query.filter(WeatherModel.date < today_date).delete()
        db.session.commit()
    except SQLAlchemyError as error:
        db.session.rollback()
        flash(f'A database error occurred: {str(error)}')
        return redirect(url_for('index'))
    
if __name__ == '__main__':
    with app.app_context():
        db.create_all()
    app.run(debug=True)

