[supervisord]
nodaemon = true
logfile = /var/log/supervisord.log
logfile_backups = 0

[program:rsyslogd]
process_name = syslogd
command = /usr/sbin/rsyslogd -n
priority = 5
autostart = true
autorestart = false

${{ERA_AGENT_SERVICE}}

[program:esets]
process_name = esets
command = /opt/eset/esets/sbin/esets_daemon
priority = 15
autostart = true
autorestart = false


