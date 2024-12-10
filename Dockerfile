# �ϥΩx�� .NET SDK �M���@����¦�M���]�غc���q�^
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build-env

WORKDIR /app

# �ƻs csproj �ɮר��٭�̿ඵ
COPY *.csproj ./
RUN dotnet restore

# �ƻs�M���ɮרëظm
COPY . ./
RUN dotnet publish -c Release -o out

# �ϥ� .NET �B��ɬM���@���B��ɬM��
FROM mcr.microsoft.com/dotnet/aspnet:8.0

WORKDIR /app
COPY --from=build-env /app/out ./

# ���w�e���Ұʮɰ��檺�R�O
ENTRYPOINT ["dotnet", "HelloWorldApp.dll"]

