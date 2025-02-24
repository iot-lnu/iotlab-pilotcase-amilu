from machine import UART
import time

uart = UART(0, baudrate=115200, tx=0, rx=1)
            
def send_at(cmd):
    message = cmd + "\r\n"
    response = b""
    timeout = 2000
    current_time = time.ticks_ms()
    uart.write(message.encode())
    while(time.ticks_ms() - current_time < timeout):
        if uart.any():
            data = uart.read()
            if data:
                response += data
    print(response.strip())
    return response.strip()

def init_gps():
    send_at("ATE0")
    response = send_at("AT")
    while (response != b'OK'):
        print("Attempting to initiate GPS")
        send_at("ATE0")
        response = send_at("AT")
    print("GPS initialized")
    return True
        
def get_gps():
    send_at("AT+CGNSPWR=1")
    response = send_at("AT+CGNSINF")
    responseToString = response.decode("utf-8")
    responseToList = responseToString.split(",")
    if(len(responseToList) >= 4):
        print(responseToList[3], responseToList[4])
        return (responseToList[3], responseToList[4])
    
def initialize_network():
    print("Network func start")
    send_at("AT+CPIN?")
    send_at('AT+CSQ')
    send_at('AT+CPSI?')
    send_at("AT+COPS?")
    print("network func done")
