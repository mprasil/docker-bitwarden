# Discontinued!
**TL/DR: Migrate to [mprasil/bitwarden](https://hub.docker.com/r/mprasil/bitwarden/) which is probably better choice anyways**

This image is no longer updated! I'm no longer using this image and I don't have time to keep it updated. I'm honestly surprised that people are using it as I really meant it as a way to try the additions branch that I didn't expect to stick around for _that_ long.. :-O So what's next?

I'd strongly advise you to consider migrating to [mprasil/bitwarden](https://hub.docker.com/r/mprasil/bitwarden/) that I'm using as well. (for a while actually!) This is based on Rust implementation of Bitwarden and has much more complete implementation of the API (**including organizations support**) and it's also provided in the form of automated build, so there's a build log you can inspect, the builds are more transparent and the whole image is hopefully more trustworthy.

If you decide to do that, run the current image first and export your passwords via the Vault interface. Then run the new image, create your account and then import the data using Bitwarden CSV format. It should be pretty straightforward and the only minor issue is that attachments won't survive this. (which you quite likely didn't have anyways as this image didn't support them)

---------------
This is a [Drone](http://docs.drone.io/) configuration to build Docker image containing both Bitwarden Web interface and Bitwarden-compatible API implementation in ruby.

The build is using upstream code for the [Vault](https://github.com/bitwarden/web) (web interface) and [universal's fork of bitwarden-ruby](https://github.com/universal/bitwarden-ruby).

## Usage

You can run your own instance by running:

```
docker run -d -v /bitwarden_data/db/:/bitwarden/api/db/ -v /bitwarden_data/attachments/:/bitwarden/api/data/attachments/ -p 8080:8080 mprasil/bitwarden-ruby
```

The important part is the volume mapping. The above example will preserve your passwords DB in `/bitwarden_data` directory on the host machine - adapt this path to your preference. 

After you run above command, bitwarden will be available on port 8080. Note that the service is exposed over http, which might be fine to use over local network if you can trust it, but if you want to expose and use the service over the internet using https is strongly encouraged. You can use [Caddy](https://caddyserver.com/) or other https capable proxy server for that purpose.

## Building your own image

You don't have to build your own image to use Bitwarden, you can just use `mprasil/bitwarden-ruby` for that, however if you need some extra modifications, the process is fairly simple.

This configuration is written for Drone, however it shouldn't be har to write similar configuration for CI tool of your choice. Essentially Drone will run two build scripts in dedicated node/ruby docker images and will then compile the output of these into final image. The `.drone.yml` file is pretty self-explanatory. Submit an issue if you have troubles building your own image.
