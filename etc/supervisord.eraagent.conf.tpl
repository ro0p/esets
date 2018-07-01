[program:eraagent]
process_name = eraagent
command = /opt/eset/RemoteAdministrator/Agent/ERAAgent --pidfile=/var/run/eraagent.pid
priority = 10
autostart = true
autorestart = false
