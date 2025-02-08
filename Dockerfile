# Usando a imagem base do .NET SDK para build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copia os arquivos do projeto e restaura as dependências
COPY . .
RUN dotnet restore
RUN dotnet publish -c Release -o out

# Usando a imagem runtime para rodar a aplicação
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/out .

# Comando para rodar a aplicação
ENTRYPOINT ["dotnet", "ContosoPizza.dll"]
