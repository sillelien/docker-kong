FROM sillelien/base-alpine
RUN apk add curl
CMD sleep 60 && curl http://${KONG_PORT_8000_TCP_ADDR}:${KONG_PORT_8000_TCP_PORT}/ | grep "API not found with these values"