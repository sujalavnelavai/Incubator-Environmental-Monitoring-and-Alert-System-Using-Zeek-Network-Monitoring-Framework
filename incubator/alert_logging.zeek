module Incubator;

export {

    redef enum Log::ID += {
        ALERT_LOG
    };


    type AlertInfo: record {
        ts: time &log;
        severity: string &log;
        event_name: string &log;
        affected_sensors: string &log;
        action_required: string &log;
    };


    global write_alert:
        function(
            severity: string,
            event_name: string,
            affected_sensors: string,
            action_required: string
        );

}


event zeek_init()
{
    Log::create_stream(
        Incubator::ALERT_LOG,
        [
            $columns=AlertInfo,
            $path="alerts"
        ]
    );
}



function write_alert(
    severity: string,
    event_name: string,
    affected_sensors: string,
    action_required: string
)
{

    local alert: AlertInfo;

    alert$ts = network_time();
    alert$severity = severity;
    alert$event_name = event_name;
    alert$affected_sensors = affected_sensors;
    alert$action_required = action_required;


    Log::write(
        Incubator::ALERT_LOG,
        alert
    );

}
