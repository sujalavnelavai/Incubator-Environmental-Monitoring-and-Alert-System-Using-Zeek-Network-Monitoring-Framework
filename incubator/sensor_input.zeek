module Incubator;

export {

    global temperature_value: double;
    global co2_value: double;
    global humidity_value: double;
    global oxygen_value: double;

}


event zeek_init()
{

    # Normal incubator values

    temperature_value = 37.0;
    co2_value = 5.0;
    humidity_value = 95.0;
    oxygen_value = 20.0;

}
