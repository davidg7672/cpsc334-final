FROM gcc:latest

RUN apt-get update && apt-get install -y make

WORKDIR /app

COPY /bin/ /app/
WORKDIR /app/

RUN make test

CMD ["./linkedlist_tests"]
EXPOSE 3000