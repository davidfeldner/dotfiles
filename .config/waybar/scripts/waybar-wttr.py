#!/usr/bin/env python

import json
import requests
import time
from datetime import datetime

WEATHER_CODES = {
    '113': '󰖨 ',
    '116': ' ',
    '119': ' ',
    '122': ' ',
    '143': ' ',
    '176': ' ',
    '179': '󰖗 ',
    '182': '󰖗 ',
    '185': '󰖗 ',
    '200': '󰙾 ',
    '227': '󰖗 ',
    '230': '',
    '248': ' ',
    '260': ' ',
    '263': '󰖗 ',
    '266': '󰖗 ',
    '281': '󰖗 ',
    '284': '󰖗 ',
    '293': '󰖗 ',
    '296': '󰖗 ',
    '299': '󰖗 ',
    '302': '󰖗 ',
    '305': '󰖗 ',
    '308': '󰖗 ',
    '311': '󰖗 ',
    '314': '󰖗 ',
    '317': '󰖗 ',
    '320': '󰖗 ',
    '323': '󰖗 ',
    '326': '󰖗 ',
    '329': ' ',
    '332': ' ',
    '335': ' ',
    '338': ' ',
    '350': '󰖗 ',
    '353': '󰖗 ',
    '356': '󰖗 ',
    '359': '󰖗 ',
    '362': '󰖗 ',
    '365': '󰖗 ',
    '368': '󰖗 ',
    '371': ' ',
    '374': '󰖗 ',
    '377': '󰖗 ',
    '386': '󰙾 ',
    '389': '󰙾 ',
    '392': '󰙾 ',
    '395': ' '
}



def format_time(time):
    return time.replace("00", "").zfill(2)




def format_chances(hour):
    chances = {
        "chanceoffog": "Fog",
        "chanceoffrost": "Frost",
        "chanceofovercast": "Overcast",
        "chanceofrain": "Rain",
        "chanceofsnow": "Snow",
        "chanceofsunshine": "Sunshine",
        "chanceofthunder": "Thunder",
        "chanceofwindy": "Wind"
    }

    conditions = []
    for event in chances.keys():
        if int(hour[event]) > 0:
            conditions.append(chances[event]+" "+hour[event]+"%")
    return ", ".join(conditions)



def formatData(weather):
    data = {}

    data['text'] = WEATHER_CODES[weather['current_condition'][0]['weatherCode']] + \
        " "+weather['current_condition'][0]['FeelsLikeC']+"°C"

    data['tooltip'] = f"<b>{weather['current_condition'][0]['weatherDesc'][0]['value']} {weather['current_condition'][0]['temp_C']}°C</b>\n"
    data['tooltip'] += f"Feels like: {weather['current_condition'][0]['FeelsLikeC']}°C\n"
    data['tooltip'] += f"Wind: {weather['current_condition'][0]['windspeedKmph']}Km/h\n"
    data['tooltip'] += f"Humidity: {weather['current_condition'][0]['humidity']}%\n"
    for i, day in enumerate(weather['weather']):
        data['tooltip'] += f"\n<b>"
        if i == 0:
            data['tooltip'] += "Today, "
        if i == 1:
            data['tooltip'] += "Tomorrow, "
        data['tooltip'] += f"{day['date']}</b>\n"
        data['tooltip'] += f"⬆️ {day['maxtempC']}° ⬇️ {day['mintempC']}° "
        data['tooltip'] += f"🌅 {day['astronomy'][0]['sunrise']} 🌇 {day['astronomy'][0]['sunset']}\n"
        for hour in day['hourly']:
            if i == 0:
                if int(format_time(hour['time'])) < datetime.now().hour-2:
                    continue
            data['tooltip'] += f"{format_time(hour['time'])} {WEATHER_CODES[hour['weatherCode']]} {hour['FeelsLikeC']} {hour['weatherDesc'][0]['value']}, {format_chances(hour)}\n"
    return data

def getWeather():
    return requests.get("https://wttr.in/?format=j1").json()


for i in range(10):
    try:
        weather = getWeather()
        break
    except:
        time.sleep(4)
        pass
if weather:
    data = formatData(weather)
    file = open("/tmp/weather.json", "w")
    file.write(json.dumps(data))
    file.close()

file = open("/tmp/weather.json", "r")
print(file.read())
