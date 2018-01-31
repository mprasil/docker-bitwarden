This is a [Drone](http://docs.drone.io/) configuration to build Docker image containing both Bitwarden Web interface and Bitwarden-compatible API implementation in ruby.

The build is using upstream code for the [Vault](https://github.com/bitwarden/web) (web interface) and [universal's fork of bitwarden-ruby](https://github.com/universal/bitwarden-ruby).

## Usage

You can run your own instance by running:

```
docker run -d -v /bitwarden_data/:/bitwarden/api/db/ -p 8080:8080 mprasil/bitwarden-ruby
```

The important part is the volume mapping. The above example will preserve your passwords DB in `/bitwarden_data` directory on the host machine - adapt this path to your preference. 

After you run above command, bitwarden will be available on port 8080. Note that the service is exposed over http, which might be fine to use over local network if you can trust it, but if you want to expose and use the service over the internet using https is strongly encouraged. You can use [Caddy](https://caddyserver.com/) or other https capable proxy server for that purpose.

## Building your own image

You don't have to build your own image to use Bitwarden, you can just use `mprasil/bitwarden-ruby` for that, however if you need some extra modifications, the process is fairly simple.

This configuration is written for Drone, however it shouldn't be har to write similar configuration for CI tool of your choice. Essentially Drone will run two build scripts in dedicated node/ruby docker images and will then compile the output of these into final image. The `.drone.yml` file is pretty self-explanatory. Submit an issue if you have troubles building your own image.