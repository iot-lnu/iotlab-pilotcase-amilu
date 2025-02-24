import utime
import time
from machine import I2C, Pin
from mpu6886 import MPU6886
import gps
import network
import urequests

post_url = "https://postgpsdata-6hc3arpala-uc.a.run.app"

ssid = "iotlab"
password = "modermodemet"

wlan = network.WLAN(network.STA_IF)
wlan.active(True)
wlan.connect(ssid, password)

while not wlan.isconnected():
    print("Connecting to WiFi...")
    time.sleep(1)

print("Connected to WiFi")
print("IP Address:", wlan.ifconfig()[0])


led = Pin("LED", Pin.OUT)

i2c = I2C(1, scl= Pin(19), sda=Pin(18), freq=400000)
sensor = MPU6886(i2c)

print("MPU6886 id: " + hex(sensor.whoami))

prevVal = sensor.acceleration

gps.init_gps()
gps.initialize_network()

def checkForAcceleration(acceleration):
    global prevVal
    
    for idx,acc in enumerate(prevVal):
        if(abs(acceleration[idx] - acc) > 3):
            print("Accelerated")
            gpsData = gps.get_gps()
            led.value(1)
            time.sleep(2)
            led.value(0)
            if(gpsData is not None and len(gpsData) == 2):
                postNewGpsData(gpsData)
            else:
                print("no GPS data retrieved")
            utime.sleep_ms(1000)
            break
            
    prevVal = acceleration
    
def postNewGpsData(data):
    try:
        doSend = True
        for value in data:
            num = float(value)
            if num <= 0:
                doSend = False
        if(doSend):
            print("Sending Data")
            data = {
                "gpsUnitId": "0",
                "latitude": data[0],
                "longitude": data[1]
                }
            headers = {
                "Content-Type": "application/json"
                }
            response = urequests.post(post_url, json=data, headers=headers)
            print(response.status_code)
    except:
        print("invalid gps data")



while True:
    checkForAcceleration(sensor.acceleration)
    utime.sleep_ms(1000)