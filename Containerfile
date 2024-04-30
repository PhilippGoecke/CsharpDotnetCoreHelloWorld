FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build-env
WORKDIR /App

RUN dotnet --info \
  && dotnet new console -o . -n DotNet.Docker \
  && ls -lisah \
  && cat Program.cs

RUN dotnet publish -c Release \
  && ls -lisah bin/Release/net8.0/publish

# Restore as distinct layers
RUN dotnet restore
# Build and publish a release
RUN dotnet publish -c Release -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /App
COPY --from=build-env /App/out .
ENTRYPOINT ["dotnet", "DotNet.Docker.dll"]
