package com.example.resources;

import javax.ws.rs.GET;
import javax.ws.rs.Path;

@Path("sample")
public class SampleResource {

    @GET
    public String getSampleMessage() {
        return "Hello, this is a sample resource!\n";
    }
}