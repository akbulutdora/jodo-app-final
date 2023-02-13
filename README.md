# jodo-app-final


A simple note-taking app.

In order to build, clone the repo, configure the mobile app endpoint.
The mobile app might take some configuration for running on different devices and networks.
The `.dev.environment` file should be edited to run the mobile app. The endpoint IP address can be configured for the local network.
and build:

```
docker-compose up --build
```

After building the images, the mobile app container will not die but will not run the app either. You should attach a shell and connect a physical android device and run the app yourself.
In order to run on a physical mobile device as shown here: https://medium.com/inspireui/build-your-flutter-apps-effortlessly-with-docker-336f139a322d.

Another option is to run the phoenix server from the docker and run the app from a pc.

## Encountered problems
- Had a problem with the mobile app being ran from the docker container. I failed to configure the networking settings properly. I could only configure the server to answer to requests from a locally hosted (on my own system) mobile app.
- Initially, I developed the project on a Apple silicon chip mac. This created many problems with Flutter dockerization, as well as with the backend when I wanted to run the image on a computer with an Intel chip. Afterwards, I finished the project on a Windows pc.
