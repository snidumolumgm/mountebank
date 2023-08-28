# syntax=docker/dockerfile:1

FROM node:18-alpine

WORKDIR /app

RUN npm install --production -g npm cache clean -f

# Copy imposter file
COPY imposter.ejs /tmp

# Run as a non-root user
RUN adduser -D mountebank
RUN chown -R mountebank /app
USER mountebank

EXPOSE 2525

ENTRYPOINT ["mb", "--configfile", "/tmp/imposter.ejs", "--allowInjection", "--loglevel" "debug"]
