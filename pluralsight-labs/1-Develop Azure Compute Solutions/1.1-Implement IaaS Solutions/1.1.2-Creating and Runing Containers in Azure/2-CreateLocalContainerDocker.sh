# Requirements for this demo
# 1. Install docker          - https://docs.docker.com/desktop/#download-and-install 
# 2. Install dotnet core sdk - https://dotnet.microsoft.com/download/dotnet-core

#Step 1: Build web app first ant test it prior to putting it in a container
dotnet build ./webapp
dotnet run --project ./webapp 
#Open new terminal to test
curl http://localhost:5000

#Step 2: Publish a local build (this is that will be copied into container)
dotnet publish -c Release ./webapp

#Step 3 - Build the container and tag it...the build is defined in the Dockerfile
docker build -t webappimage:v1 .

#Step 4 - Run the container locally and test it out
docker run --name webapp --publish 8080:80 --detach webappimage:v1
curl http://localhost:8080

#Delete the running webapp container
docker stop webapp
docker rm webapp

#The image is still here...let's hold onto this for the next demo.
docker image ls webappimage:v1