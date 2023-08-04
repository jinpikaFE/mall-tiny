# 使用官方Maven基础镜像，包含了Maven和JDK
FROM maven:3.6.3-jdk-8 AS build

# 设置工作目录
WORKDIR /app

# 将项目的POM文件复制到工作目录
COPY pom.xml .

# 配置阿里云镜像仓库
RUN echo '<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0" \
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" \
    xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0 \
                        https://maven.apache.org/xsd/settings-1.0.0.xsd"> \
    <mirrors> \
        <mirror> \
          <id>aliyunmaven</id> \
          <mirrorOf>*</mirrorOf> \
          <url>https://maven.aliyun.com/repository/public</url> \
        </mirror> \
    </mirrors> \
</settings>' > /usr/share/maven/conf/settings.xml

# 下载项目依赖项，这样可以利用Docker的缓存机制加快构建速度
RUN mvn dependency:go-offline

# 将项目源代码复制到工作目录
COPY src ./src

# 使用Maven打包项目
RUN mvn package

# 使用官方OpenJDK基础镜像
FROM openjdk:8-jre

# 设置工作目录
WORKDIR /app

# 从构建阶段复制生成的jar文件到当前工作目录
COPY --from=build /app/target/mall-tiny-0.0.1-SNAPSHOT.jar .

# 暴露端口，这里需要根据实际的应用端口进行修改
EXPOSE 3066

# 启动应用
CMD ["java", "-jar", "mall-tiny-0.0.1-SNAPSHOT.jar"]