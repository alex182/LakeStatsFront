#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

#Build/Push to registry
 #docker build -t lake_stats_front .
 #docker image tag lake_stats_front 192.168.1.136:9005/lake_stats_front:latest
 #docker image push 192.168.1.136:9005/lake_stats_front:latest

FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base
WORKDIR /app
ARG LAKE_STATS_API_URL
ENV LAKESTATSAPIURL=$LAKE_STATS_API_URL 
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src
COPY ["LakeStatsFront.csproj", "LakeStatsFront/"]
RUN dotnet restore "LakeStatsFront/LakeStatsFront.csproj"
WORKDIR "/src/LakeStatsFront"
COPY . .
RUN dotnet build "LakeStatsFront.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "LakeStatsFront.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "LakeStatsFront.dll"]