module Incubator;

export {

    redef enum Log::ID += { LOG };

    type Info: record {
        ts: time &log;
        sensor: string &log;
        value: double &log;
        units: string &log;
        status: string &log;
    };
}


event zeek_init()
{
    Log::create_stream(
        Incubator::LOG,
        [$columns=Info,
         $path="incubator"]
    );
}


function write_telemetry(
    sensor: string,
    value: double,
    units: string,
    status: string
)
{
    local entry: Info = [
        $ts=network_time(),
        $sensor=sensor,
        $value=value,
        $units=units,
        $status=status
    ];

    Log::write(Incubator::LOG, entry);
}
