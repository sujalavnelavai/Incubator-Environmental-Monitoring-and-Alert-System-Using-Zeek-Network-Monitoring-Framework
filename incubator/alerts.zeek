module Incubator;

export {

    global check_alerts:
        function(
            temperature_status: string,
            co2_status: string,
            humidity_status: string,
            oxygen_status: string
        );

}


function check_alerts(
    temperature_status: string,
    co2_status: string,
    humidity_status: string,
    oxygen_status: string
)
{

    local critical_count: count = 0;

    local failed_sensors: string = "";


    if ( temperature_status == "CRITICAL" )
    {
        critical_count += 1;
        failed_sensors += "Temperature ";
    }


    if ( co2_status == "CRITICAL" )
    {
        critical_count += 1;
        failed_sensors += "CO2 ";
    }


    if ( humidity_status == "CRITICAL" )
    {
        critical_count += 1;
        failed_sensors += "Humidity ";
    }


    if ( oxygen_status == "CRITICAL" )
    {
        critical_count += 1;
        failed_sensors += "Oxygen ";
    }



    if ( critical_count >= 2 )
    {
        print "ALERT: MULTIPLE INCUBATOR PARAMETERS FAILED";

        write_alert(
            "HIGH",
            "Multiple sensor failure",
            failed_sensors,
            "Immediate inspection required"
        );
    }



    else if ( critical_count == 1 )
    {
        print "ALERT: SINGLE INCUBATOR PARAMETER CRITICAL";

        write_alert(
            "MEDIUM",
            "Single sensor critical",
            failed_sensors,
            "Check affected sensor"
        );
    }



    else
    {
        print "Incubator environment stable";
    }

}
