# Incubator Environmental Monitoring and Alert System Using Zeek

## About the Project

This project was built to explore how the **Zeek Network Monitoring Framework** can be used beyond traditional network security.

Instead of analyzing network attacks, I used Zeek to monitor environmental telemetry from an incubator. The system checks important parameters such as temperature, CO₂, humidity, and oxygen levels, determines whether they are within safe operating ranges, generates alerts when abnormal conditions are detected, and records the results using custom Zeek logs.

The project also includes a small Python telemetry simulator to generate sample sensor data for testing.

---

## Why I Built This

While learning Zeek, I wanted to see how flexible it is beyond packet analysis and intrusion detection.

This project gave me an opportunity to understand how Zeek scripts work together while building something practical. It helped me learn about custom logging, threshold checking, modular scripting, and working with telemetry data instead of traditional network events.

---

## Features

- Monitor incubator environmental parameters
- Check sensor values against predefined safety thresholds
- Identify normal and critical operating conditions
- Generate alerts when multiple parameters exceed safe limits
- Store monitoring results in a custom Zeek log
- Test normal, failure, and recovery scenarios

---

## Project Structure

```
incubator-monitoring/

├── incubator/
│   ├── main.zeek
│   ├── sensor_input.zeek
│   ├── thresholds.zeek
│   ├── alerts.zeek
│   ├── alert_logging.zeek
│   ├── logging.zeek
│   ├── incubator_telemetry.zeek
│   └── __load__.zeek

├── telemetry_simulator/
│   ├── incubator_sender.py
│   └── telemetry_receiver.py

├── incubator_payload.pcap
├── incubator_normal.pcap

└── phase14_final_evidence/
```

---

## Running the Project

Navigate to the project directory first:

```bash
cd ~/incubator-monitoring
```

Remove any previous logs:

```bash
rm -f *.log
```

Run Zeek using the provided packet capture:

```bash
zeek -C -r incubator_payload.pcap incubator
```

---

## Example Output

Normal incubator conditions:

```
Incubator environment stable

Temperature 37.0 C Status NORMAL
CO2 5.0 % Status NORMAL
Humidity 95.0 % Status NORMAL
Oxygen 20.0 % Status NORMAL
```

Failure scenario:

```
Temperature 37.8 C Status CRITICAL
CO2 6.8 % Status CRITICAL
Humidity 95.0 % Status NORMAL
Oxygen 20.0 % Status NORMAL
```

---

## Testing

To verify the monitoring logic, I tested three different scenarios:

- Normal incubator operation
- Failure detection by changing sensor values
- Recovery after restoring normal sensor values

The generated evidence logs are available in:

```
phase14_final_evidence/
```

---

## Technologies Used

- Zeek Network Monitoring Framework
- Zeek Scripting Language
- Python
- JSON
- PCAP Analysis
- Ubuntu Linux

---

## What I Learned

Working on this project helped me better understand how Zeek scripts interact with each other and how the framework can be adapted for custom monitoring tasks.

I also gained hands-on experience with:

- Writing modular Zeek scripts
- Creating custom Zeek logs
- Threshold-based monitoring
- Simulating telemetry data
- Testing different monitoring scenarios

---

## Future Improvements

Some ideas I'd like to explore in the future include:

- Connecting to real incubator sensors
- Monitoring live telemetry instead of replaying packet captures
- Building a web dashboard for visualization
- Storing monitoring history in a database
- Sending email or SMS notifications when critical conditions are detected

---

## License

This project is licensed under the Apache License 2.0.
