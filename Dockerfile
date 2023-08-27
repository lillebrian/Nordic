# 1 Server code build 
FROM mcr.microsoft.com/dotnet/sdk:7.0 as serverbuild-env
WORKDIR /nordic/server
# Copy everything
COPY /server/web .
# Restore as distinct layers
RUN dotnet restore
# Build and publish a release
RUN dotnet publish -c Release -o out

# Running the server side image
FROM mcr.microsoft.com/dotnet/aspnet:7.0 as serverimg
WORKDIR /nordic/server
EXPOSE 8000
COPY --from=serverbuild-env /nordic/server/out .
ENTRYPOINT [ "dotnet","DotNet.Docker.dll"]

# 2 Creating and running the front end image
FROM node:19 as clientimg
WORKDIR /nordic/client
COPY /client/package.json .
RUN npm install
COPY /client .
RUN npm run build
CMD ["npm","run","dev"]
EXPOSE 5000