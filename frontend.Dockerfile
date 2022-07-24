# build environment
FROM node:14-alpine as build
WORKDIR /app
ENV PATH /app/node_modules/.bin:$PATH

# Get environment variables.
ARG REACT_APP_API_HOST
ARG REACT_APP_API_DOMAIN
ARG REACT_APP_API_PROTOCOL
ARG REACT_APP_WWW_DOMAIN
ARG REACT_APP_WWW_PROTOCOL
ARG REACT_APP_IMAGE_UPLOAD_MAX_FILESIZE_IN_BYTES
ARG REACT_APP_IMAGE_UPLOAD_MAX_FILESIZE_ERROR_MESSAGE

# DEVELOPERS NOTE: Here is where we will copy from our `workery-front` submodule.
COPY ./workery-front/package.json ./
COPY ./workery-front/package-lock.json ./

RUN npm ci --silent
RUN npm install react-scripts@5.0.1 -g --silent

# DEVELOPERS NOTE: Here is where we will copy from our `workery-front` submodule.
COPY ./workery-front ./

# Apply environment variables with the build.
RUN REACT_APP_API_HOST=${REACT_APP_API_HOST} \
  REACT_APP_API_DOMAIN=${REACT_APP_API_DOMAIN} \
  REACT_APP_API_PROTOCOL=${REACT_APP_API_PROTOCOL} \
  REACT_APP_WWW_DOMAIN=${REACT_APP_WWW_DOMAIN} \
  REACT_APP_WWW_PROTOCOL=${REACT_APP_WWW_PROTOCOL} \
  REACT_APP_IMAGE_UPLOAD_MAX_FILESIZE_IN_BYTES=${REACT_APP_IMAGE_UPLOAD_MAX_FILESIZE_IN_BYTES} \
  REACT_APP_IMAGE_UPLOAD_MAX_FILESIZE_ERROR_MESSAGE=${REACT_APP_IMAGE_UPLOAD_MAX_FILESIZE_ERROR_MESSAGE} \
  npm run build

# production environment
FROM nginx:stable-alpine
COPY --from=build /app/build /usr/share/nginx/html

# DEVELOPERS NOTE: https://mherman.org/blog/dockerizing-a-react-app/
COPY workery-front/nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

## Using the production Dockerfile, build and tag the Docker image:
##   $ docker build -f frontend.Dockerfile -t workery-front:latest .
##
## Spin up the container:
##   $ docker run -it --rm -p 10001:80 workery-front:latest
##
## Navigate to http://localhost:1337/ in your browser to view the app.
##
## SPECIAL THANKS TO:
## https://mherman.org/blog/dockerizing-a-react-app/
