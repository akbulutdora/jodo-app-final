FROM cirrusci/flutter

RUN echo "here"

RUN mkdir /mobile_app
COPY ./ /mobile_app

RUN echo "here2"

WORKDIR /mobile_app

RUN flutter config --enable-web
RUN flutter doctor -v

CMD flutter run -d chrome