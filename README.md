# docker-cryptodog

This is the Docker Compose application that powers Cryptodog in development and production. It consists of the following services:

* `caddy`: a [Caddy](https://caddyserver.com/) instance that serves static files for the website and Cryptodog web application. It also provides a WebSocket endpoint that reverse-proxies requests to `updog`, which then reverse-proxies them to the ejabberd server.
* `debian-ejabberd`: an [ejabberd](https://www.ejabberd.im/index.html) server. This is the backend for Cryptodog. It supports only XMPP anonymous authentication (no user registration) and makes no direct C2S/S2S XMPP connections; the only public access is through the WebSocket endpoint in the `caddy` service. We also patch ejabberd to disable the default behavior of granting room admin privileges to the first member of a room.
* `onion-service`: a Tor daemon for Cryptodog's [onion service](https://community.torproject.org/onion-services/).
* `updater`: a [simple Go program](https://github.com/Cryptodog/updater) that automatically updates the website and web application from their signed releases on GitHub.
* `updog`: a [simple rate-limiting proxy](https://github.com/Cryptodog/updog), written in Go, that sits between Caddy and ejabberd. This was deemed necessary after malicious actors discovered they could crash ejabberd and freeze the web application by flooding the server with messages.
