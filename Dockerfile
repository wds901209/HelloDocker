# 使用官方 .NET SDK 映像作為基礎映像（建構階段）
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build-env

WORKDIR /app

# 複製 csproj 檔案並還原依賴項
COPY *.csproj ./
RUN dotnet restore

# 複製專案檔案並建置
COPY . ./
RUN dotnet publish -c Release -o out

# 使用 .NET 運行時映像作為運行時映像
FROM mcr.microsoft.com/dotnet/aspnet:8.0

WORKDIR /app
COPY --from=build-env /app/out ./

# 指定容器啟動時執行的命令
ENTRYPOINT ["dotnet", "HelloWorldApp.dll"]

