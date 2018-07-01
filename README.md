# ESET Server Security

ESET Server Security container with ESET Remote Administrator Agent support.

## Build

**Valid ESET license is required to download latest ESET Server Security installer!**

Use the build.sh script to build the container. If license credentials are not set in environment variables the script will ask for them.

The image name will be 'esets', change it if you want to use a registry or tags.

## Run

Example compose file:
```yaml
esets:
  image: 'esets'
  container_name: 'esets'
  hostname: 'esets'
  restart: always
  environment:
    - ERA_AGENT=/opt/era/EraAgentInstaller.sh
    - LOGGER_DEBUG=1
  volumes:
    - /etc/localtime:/etc/localtime:ro
    - /srv/esets/etc:/etc/opt/eset/esets
    - /srv/esets/log:/var/log
    - /srv/esets/era:/opt/era
```

**If you install ERA Agent, static IP address (or using host networking) is required to prevent multiple instances appearing in Remote Administrator.**

Additional changes are needed based on your requirements and comfiguration such as port forward for module 'wwwi' or DNS settings etc.

## Variables

**Build-time**

| Variable      | Description                                                             |
| ------------- | ----------------------------------------------------------------------- |
| AV_USERNAME   | License username                                                        |
| AV_PASSWORD   | License password                                                        |

**Runtime**

| Variable      | Description                                                             |
| ------------- | ----------------------------------------------------------------------- |
| ERA_AGENT     | Full path of the ERA Agent installer script. It must be a shell script. |
| LOGGER_DEBUG  | Enable debug logging. (default: 0)                                      |
| LOGGER_OUTPUT | Set logging destination. (default: /dev/stderr)                         |
