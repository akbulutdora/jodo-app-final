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
