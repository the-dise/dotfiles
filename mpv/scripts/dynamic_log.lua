-- This script sets a dynamic log file name for each playback session in mpv.
-- It generates a log file name based on the current date and time and sets 
-- the log file path accordingly.
--
-- To enable or disable logging, adjust the `enable_logs` variable to `true` or `false`.
--
-- USAGE:
-- Modify the `enable_logs` variable to control logging.
--
-- -- Enable logging:
-- local enable_logs = true
--
-- -- Disable logging:
-- local enable_logs = false
--
-- When logging is enabled, a log file will be created in the 'logs' directory within
-- the mpv configuration directory. The log file name format is 'log_MMddyyyy-HHmmss.log'.
--
-- The script listens for the 'start-file' event to set the log file name at the start of each playback.
--
-- OPTIONS:
-- To specify a custom logs directory, ensure it exists within the mpv configuration directory.
--
-- This script does not support automatic log rotation or deletion.

local utils = require 'mp.utils'

-- Setting to enable or disable logging
local enable_logs = false

function set_dynamic_logfile()
    if enable_logs then
        local t = os.date('*t')
        local log_filename = string.format("log_%02d%02d%04d-%02d%02d%02d.log",
            t.month, t.day, t.year, t.hour, t.min, t.sec)
        local log_filepath = utils.join_path(mp.find_config_file('logs'), log_filename)

        mp.set_property('log-file', log_filepath)
        mp.msg.info('Log file set to: ' .. log_filepath)
    else
        mp.msg.info('Logging is disabled')
    end
end

mp.register_event('start-file', set_dynamic_logfile)
