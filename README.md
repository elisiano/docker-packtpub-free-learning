#  Packtpub Free Learning book of the day
Packtpub has an amazing initiative: every day it publishes a [free technology ebook](https://www.packtpub.com/packt/offers/free-learning/).
The downside is that you have to remember to login and add it to your library.
Not anymore (if you put this in crontab).

#  How to use this image

This image has 2 mandatory environment variables for PacktPub login:
- `PP_EMAIL`
- `PP_PASSWORD`

Additionally, if you want to receive a notification on pushbullet (how to get an access token is outside the scope of this document), you can set:
- `PB_EMAIL`
- `PB_TOKEN`

Basic Example (just get the ebook)
```bash
docker run --rm -e PP_EMAIL=my@email.com -e PP_PASSWORD=myP455 elisiano/packtpub-free-learning
```
Example with pushbullet
```bash
docker run --rm -e PP_EMAIL=my@email.com -e PP_PASSWORD=myP455 -e PB_EMAIL=my@email.com PB_TOKEN=myT0k3n elisiano/packtpub-free-learning
```

## Disclaimer

I am not the original author of the script, I just parametrized it and dockerized it.

## Contribute

Want to improve this? Pull requests are very welcome! http://github.com/elisiano/docker-packtpub-free-learning

