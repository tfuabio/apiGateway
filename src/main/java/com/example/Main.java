package com.example;

import java.io.IOException;
import java.net.URI;

import org.glassfish.grizzly.http.server.HttpServer;
import org.glassfish.jersey.grizzly2.httpserver.GrizzlyHttpServerFactory;
import org.glassfish.jersey.server.ResourceConfig;

public class Main {
    public static final String BASE_URI = "http://localhost:8080/";

    public static void main(String[] args) throws IOException {
        // サーバー起動
        final ResourceConfig rc = new ResourceConfig().packages("com.example.resources");
        final HttpServer server = GrizzlyHttpServerFactory.createHttpServer(URI.create(BASE_URI), rc);
        System.out.printf("Http Server started at %s\nPress enter to stop it...\n", BASE_URI);

        // サーバー停止を待機
        System.in.read();

        // サーバー停止
        server.shutdownNow();
    }
}
