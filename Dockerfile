# Stage 1: Build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy the csproj and restore
COPY vaishnavidemo.csproj .
RUN dotnet restore vaishnavidemo.csproj

# Copy the rest of the source
COPY . .

# Publish to /app/publish
RUN dotnet publish vaishnavidemo.csproj -c Release -o /app/publish

# Stage 2: Runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app

# Copy published output from build stage
COPY --from=build /app/publish .

# Run the app
ENTRYPOINT ["dotnet", "vaishnavidemo.dll"]
