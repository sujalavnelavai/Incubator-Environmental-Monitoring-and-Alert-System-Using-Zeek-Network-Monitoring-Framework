# Incubator Environmental Monitoring and Alert System Using Zeek

## About the Project

This project explores how the **Zeek Network Monitoring Framework** can be used for something beyond traditional network security monitoring.

I built a small incubator environmental monitoring system that uses Zeek scripts to check simulated sensor telemetry. The system monitors temperature, CO₂, humidity, and oxygen levels, compares the values against predefined thresholds, assigns a `NORMAL` or `CRITICAL` status, and records the results in a custom Zeek log.

A small Python-based telemetry simulator and packet captures are included so the monitoring logic can be tested without needing physical incubator sensors.

The project was mainly built as a learning exercise to understand how Zeek's scripting and logging capabilities can be adapted to an IoT-style monitoring scenario.

---

## What the System Monitors

The system monitors four environmental parameters:

| Parameter | Example Normal Value | Unit |
|---|---:|---|
| Temperature | 37.0 | °C |
| CO₂ | 5.0 | % |
| Humidity | 95.0 | % |
| Oxygen | 20.0 | % |

The values are simulated for this project and are not intended to represent a production medical or laboratory monitoring system.

---

## How It Works

The project is divided into several Zeek scripts, with each script handling a specific part of the monitoring process.

### `sensor_input.zeek`

Provides the sensor values used during testing.

For example:

```zeek
temperature_value = 37.0;
co2_value = 5.0;
humidity_value = 95.0;
oxygen_value = 20.0;

thresholds.zeek

Contains the logic used to determine whether each environmental parameter is within its expected range.

The result of each check is represented as a status such as:

NORMAL

or:

CRITICAL
alerts.zeek

Contains the alert decision logic.

It receives the status of the four monitored parameters and counts how many are currently CRITICAL.

The project includes logic for:

No critical parameters
One critical parameter
Multiple critical parameters

When multiple parameters are critical, the script is designed to generate a multiple-parameter failure alert.

logging.zeek

Defines the custom Zeek log used to record the monitoring results.

The generated incubator.log contains fields such as:

ts    sensor    value    units    status

For example:

0.000000    temperature    37.0    C    NORMAL
0.000000    co2            5.0     %    NORMAL

alert_logging.zeek

Provides logging support for alert-related information.

incubator_telemetry.zeek

Handles the telemetry-related part of the Zeek monitoring setup.

main.zeek

Acts as the main monitoring workflow. It obtains the sensor values, checks their status, passes the results to the alert logic, and writes the telemetry records.

__load__.zeek

Loads the individual Zeek scripts together:

@load ./logging
@load ./thresholds
@load ./alert_logging
@load ./alerts
@load ./sensor_input
@load ./incubator_telemetry
@load ./main

This allows the project to be run as a single Zeek script directory.
incubator-monitoring/

├── incubator/
│   ├── __load__.zeek
│   ├── alert_logging.zeek
│   ├── alerts.zeek
│   ├── incubator_telemetry.zeek
│   ├── logging.zeek
│   ├── main.zeek
│   ├── sensor_input.zeek
│   └── thresholds.zeek
│
├── telemetry_simulator/
│   ├── incubator_sender.py
│   └── telemetry_receiver.py
│
├── incubator_payload.pcap
├── incubator_normal.pcap
│
└── phase14_final_evidence/
    ├── normal_after_cleanup.log
    ├── failure_after_cleanup.log
    └── final_recovery_normal.log

Running the Project

After cloning the repository, enter the project directory:
cd incubator-monitoring
You can view the project files with:
ls
To look at the Zeek scripts:
cd incubator
ls
To return to the project root:
cd ..

To view the telemetry simulator files:

ls telemetry_simulator

Running Zeek

The project includes packet captures that can be replayed through Zeek.
From the project root:

zeek -C -r incubator_payload.pcap incubator

The important parts of this command are:

incubator_payload.pcap — the packet capture being analyzed
incubator — the directory containing the Zeek scripts

If Zeek generates log files, they can be viewed from the project directory:

ls -lh *.log

For example:
cat incubator.log

Looking at the Zeek Scripts

To inspect the main monitoring script:

cat incubator/main.zeek

To inspect the threshold logic:

cat incubator/thresholds.zeek

To inspect the alert logic:

cat incubator/alerts.zeek

To inspect the custom logging code:

cat incubator/logging.zeek

To see how all the scripts are loaded:

cat incubator/__load__.zeek

These commands make it possible to examine how the different parts of the monitoring system work together.

Example: Normal Operation

One of the tests used normal incubator values:

Temperature 37.0 C
CO2 5.0 %
Humidity 95.0 %
Oxygen 20.0 %

The resulting monitoring output was:

Incubator environment stable

Temperature 37.0 C Status NORMAL
CO2 5.0 % Status NORMAL
Humidity 95.0 % Status NORMAL
Oxygen 20.0 % Status NORMAL

The corresponding evidence is stored in:

phase14_final_evidence/normal_after_cleanup.log

You can view it with:

cat phase14_final_evidence/normal_after_cleanup.log

Example: Failure Condition

For the failure test, the temperature and CO₂ values were changed:

Temperature 37.8 C
CO2 6.8 %
Humidity 95.0 %
Oxygen 20.0 %

The resulting statuses were:

Temperature 37.8 C Status CRITICAL
CO2 6.8 % Status CRITICAL
Humidity 95.0 % Status NORMAL
Oxygen 20.0 % Status NORMAL

This demonstrates that the threshold checking logic identifies the temperature and CO₂ conditions as critical while humidity and oxygen remain normal.

The evidence is stored in:

phase14_final_evidence/failure_after_cleanup.log

It can be viewed with:

cat phase14_final_evidence/failure_after_cleanup.log

Recovery Test

After the failure test, the sensor values were restored to the normal values.

The system was then tested again and returned to:

Incubator environment stable

Temperature 37.0 C Status NORMAL
CO2 5.0 % Status NORMAL
Humidity 95.0 % Status NORMAL
Oxygen 20.0 % Status NORMAL

The recovery evidence is stored in:

phase14_final_evidence/final_recovery_normal.log
View it with:

cat phase14_final_evidence/final_recovery_normal.log

Testing the Evidence Files

All three final evidence files can be viewed together with:

cd incubator-monitoring
ls -lh phase14_final_evidence

Then:

cat phase14_final_evidence/normal_after_cleanup.log
cat phase14_final_evidence/failure_after_cleanup.log
cat phase14_final_evidence/final_recovery_normal.log
These files provide a simple record of the normal, failure, and recovery tests.

Packet Captures

Two packet captures are included:

incubator_payload.pcap
incubator_normal.pcap

They were used to replay captured telemetry traffic through Zeek during testing.

This makes it possible to test the monitoring scripts without continuously running the telemetry simulator.

Technologies Used
Zeek Network Monitoring Framework
Zeek Scripting Language
Python
JSON telemetry
PCAP packet captures
Ubuntu Linux
What I Learned

This project helped me understand that Zeek can be useful for more than traditional security monitoring.

While building it, I worked with:

Modular Zeek scripts
Zeek script loading
Custom Zeek logging
Threshold-based monitoring
Sensor telemetry simulation
PCAP replay
Normal and abnormal test scenarios
Recovery testing

One of the main things I wanted to understand was how several small Zeek scripts could work together rather than putting the entire monitoring system into one large script.
Limitations

This is a learning and demonstration project rather than a production incubator monitoring system.

The sensor values are simulated, and the project does not currently connect to physical sensors or provide real-time medical or laboratory safety guarantees.

The current implementation is intended to demonstrate the monitoring and logging workflow using Zeek.

Future Improvements

There are several directions I would like to explore in the future:

Connect the system to real environmental sensors
Process live telemetry instead of only replaying PCAP files
Add a web-based monitoring dashboard
Store historical readings in a database
Add email or other notification mechanisms
Expand the alerting logic
Add more environmental parameters
Improve real-time monitoring and visualization
License

This project is licensed under the Apache License 2.0.

