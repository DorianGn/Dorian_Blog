# ========================================
# Dockerfile for Render Deployment
# 这个文件放在项目根目录，用于 Render 部署
# ========================================

# 第一阶段：构建
FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /src

# 复制项目文件
COPY ["Server.sln", "./"]
COPY ["src/Coldairarrow.Api/Coldairarrow.Api.csproj", "src/Coldairarrow.Api/"]
COPY ["src/Coldairarrow.Business/Coldairarrow.Business.csproj", "src/Coldairarrow.Business/"]
COPY ["src/Coldairarrow.IBusiness/Coldairarrow.IBusiness.csproj", "src/Coldairarrow.IBusiness/"]
COPY ["src/Coldairarrow.Entity/Coldairarrow.Entity.csproj", "src/Coldairarrow.Entity/"]
COPY ["src/Coldairarrow.Util/Coldairarrow.Util.csproj", "src/Coldairarrow.Util/"]

# 还原依赖
RUN dotnet restore "src/Coldairarrow.Api/Coldairarrow.Api.csproj"

# 复制源代码并编译
COPY . .
WORKDIR /src/src/Coldairarrow.Api
RUN dotnet publish "Coldairarrow.Api.csproj" -c Release -o /app/publish

# 第二阶段：运行
FROM mcr.microsoft.com/dotnet/aspnet:5.0
WORKDIR /app
ENV TZ=Asia/Shanghai
COPY --from=build /app/publish .
EXPOSE 5000
ENV ASPNETCORE_URLS=http://+:5000
ENTRYPOINT ["dotnet", "Coldairarrow.Api.dll"]
