FROM    golang:1.22 as base
#we using alias as base

WORKDIR /app
# setup work dir as / app

COPY    go.mod .
# will copy go.mod to pwd which is /app and we are doing this because all the dependencies are stores in go.mod file

RUN     go mod download
# we run this command because any dependencies for application in future by developer will get downloaded , it is similar to python python requirements.txt as command in line 7 and this command as pip install requirements.txt

COPY    . .
#now we copied everything on to the docker image

RUN     go build -o main .
# we ran this locally and after building this , an artifcat or binary or image will be created in docker image

EXPOSE  8080
# we will expose it to 8080

CMD     ["./main"]
# finally we can run this and our application will get started ,



# Final Stage wit distroless image , and we can use gcr distroless image as base

FROM        gcr.io/distroless/base

COPY        --from=base /app/main .
# Now in this distroless image we are going to copy the main binary which is in /app directory , and . here means to the default directory , but we can use any directory , but it should be working

COPY        --from=base /app/static ./static
#Now along with binary we are also copying static content to a folder./static , as our app has static files which are  not bundeled in the binary

EXPOSE      8080

CMD         ["./main"]