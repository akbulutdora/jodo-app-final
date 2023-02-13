FROM cirrusci/flutter


RUN mkdir /mobile_app
COPY ./ /mobile_app

WORKDIR /mobile_app

RUN flutter config --enable-web
RUN flutter doctor -v

CMD sleep infinity