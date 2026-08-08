import socket
import time
import json

HOST = "127.0.0.1"
PORT = 9000

temperature = 37.0
co2 = 5.0
humidity = 95.0
oxygen = 20.0

while True:

    telemetry = {
        "device": "incubator01",
        "temperature": temperature,
        "co2": co2,
        "humidity": humidity,
        "oxygen": oxygen
    }

    message = json.dumps(telemetry)

    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

    sock.connect((HOST, PORT))

    sock.send(message.encode())

    sock.close()

    print("Sent:", message)

    time.sleep(5)
