# The base go-image
FROM golang:1.18-alpine

# Create a directory for the app
RUN mkdir /app

# Copy all files from the current directory to the app directory
COPY ./workery-backend /app

# Set working directory
WORKDIR /app

# Run command as described:
# go build will build an executable file named server in the current directory
RUN go build -o workery-backend .

EXPOSE 8000

# Run the server executable
CMD [ "/app/workery-backend", "serve" ]

## BUILD
## docker build --rm -t workery-backend .

## EXECUTE
## docker run -d -p 8000:8000 workery-backend
