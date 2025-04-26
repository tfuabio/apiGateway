package com.example;

import java.io.IOException;
import java.net.URI;

import org.glassfish.grizzly.http.server.HttpServer;
import org.glassfish.jersey.grizzly2.httpserver.GrizzlyHttpServerFactory;
import org.glassfish.jersey.server.ResourceConfig;

public class Main {
    public static final String BASE_URI = "http://0.0.0.0:8080/";

    public static void main(String[] args) throws IOException {
        HttpServer server = startSevrver();
        stopServer(server);
    }

    private static HttpServer startSevrver() {
        final ResourceConfig rc = new ResourceConfig().packages("com.example.resources");
        final HttpServer server = GrizzlyHttpServerFactory.createHttpServer(URI.create(BASE_URI), rc);
        System.out.printf("Http Server started at %s\nPress Ctrl+C to stop it...\n", BASE_URI);
        return server;
    }

    private static void stopServer(HttpServer server) {
        // シャットダウンフックを追加
        Runtime.getRuntime().addShutdownHook(new Thread(() -> {
            System.out.println("Shutting down server...");
            server.shutdownNow();
        }));
    }
}
