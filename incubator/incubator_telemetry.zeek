module Incubator;

export {

    redef enum Log::ID += { TELEMETRY_LOG };

    type Telemetry_Info: record {
        ts: time &log;
        device: string &log;
        temperature: double &log;
        co2: double &log;
        humidity: double &log;
        oxygen: double &log;
    };

}

event zeek_init()
{
    Log::create_stream(Incubator::TELEMETRY_LOG,
        [$columns=Telemetry_Info,
         $path="incubator_telemetry"]);
}

event tcp_contents(c: connection, is_orig: bool, seq: count, contents: string)
{
    if ( ! is_orig )
        return;

    if ( /device/ in contents )
    {
        print "INCUBATOR JSON TELEMETRY RECEIVED";
        print contents;
    }
}
