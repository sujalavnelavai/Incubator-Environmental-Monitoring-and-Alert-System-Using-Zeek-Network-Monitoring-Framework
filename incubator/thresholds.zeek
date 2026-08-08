module Incubator;

export {

    global check_temperature: function(value: double): string;

    global check_co2: function(value: double): string;

    global check_humidity: function(value: double): string;

    global check_oxygen: function(value: double): string;

}



function check_temperature(value: double): string
{
    if ( value < 36.5 )
        return "CRITICAL";

    if ( value > 37.5 )
        return "CRITICAL";


    if ( value < 36.8 )
        return "WARNING";

    if ( value > 37.2 )
        return "WARNING";


    return "NORMAL";
}



function check_co2(value: double): string
{
    if ( value < 3.5 )
        return "CRITICAL";

    if ( value > 6.5 )
        return "CRITICAL";


    if ( value < 4.0 )
        return "WARNING";

    if ( value > 6.0 )
        return "WARNING";


    return "NORMAL";
}



function check_humidity(value: double): string
{
    if ( value < 85.0 )
        return "CRITICAL";

    if ( value > 99.0 )
        return "CRITICAL";


    if ( value < 90.0 )
        return "WARNING";

    if ( value > 98.0 )
        return "WARNING";


    return "NORMAL";
}



function check_oxygen(value: double): string
{
    if ( value < 15.0 )
        return "CRITICAL";

    if ( value > 22.0 )
        return "CRITICAL";


    if ( value < 18.0 )
        return "WARNING";

    if ( value > 20.0 )
        return "WARNING";


    return "NORMAL";
}
