module Incubator;


event zeek_init()
{

    local temperature: double = temperature_value;
    local co2: double = co2_value;
    local humidity: double = humidity_value;
    local oxygen: double = oxygen_value;


    local temperature_status = check_temperature(temperature);
    local co2_status = check_co2(co2);
    local humidity_status = check_humidity(humidity);
    local oxygen_status = check_oxygen(oxygen);


    check_alerts(
        temperature_status,
        co2_status,
        humidity_status,
        oxygen_status
    );


    write_telemetry(
        "temperature",
        temperature,
        "C",
        temperature_status
    );


    write_telemetry(
        "co2",
        co2,
        "%",
        co2_status
    );


    write_telemetry(
        "humidity",
        humidity,
        "%",
        humidity_status
    );


    write_telemetry(
        "oxygen",
        oxygen,
        "%",
        oxygen_status
    );




    print fmt(
        "Temperature %.1f C Status %s",
        temperature,
        temperature_status
    );


    print fmt(
        "CO2 %.1f %% Status %s",
        co2,
        co2_status
    );


    print fmt(
        "Humidity %.1f %% Status %s",
        humidity,
        humidity_status
    );


    print fmt(
        "Oxygen %.1f %% Status %s",
        oxygen,
        oxygen_status
    );

}
