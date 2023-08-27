# 1 Creating and running the front end image
FROM node:19 as client
WORKDIR /nordic/client as img1
COPY client/package.json .
RUN npm install
COPY /client .
RUN npm run build
CMD ["npm","run","dev"]
EXPOSE 5000

# Server code build 
FROM mcr.microsoft.com/dotnet/sdk:7.0 as serverbuild-env
WORKDIR /nordic/server
# Copy everything
COPY . ./
# Restore as distinct layers
RUN dotnet restore
# Build and publish a release
RUN dotnet publish -c Release -o out

# Running the server side image
FROM mcr.microsoft.com/dotnet/aspnet:7.0 as img2
WORKDIR /nordic/server/src
EXPOSE 8000
COPY --from=serverbuild-env /nordic/server/src/out .
ENTRYPOINT [ "dotnet","DotNet.Docker.dll"]