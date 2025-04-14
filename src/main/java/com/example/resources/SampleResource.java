package com.example.resources;

import javax.ws.rs.GET;
import javax.ws.rs.Path;

/**
 * サンプルのリソースクラス
 */
@Path("sample")
public class SampleResource {
    /**
     * サンプルメッセージを返すGETメソッド
     * @return サンプルメッセージ
     * @apiNote 次のコマンドでAPIをテストできます。
     * <p><code>
     * $ curl -i http://localhost:8080/sample
     * </code></p>
     */
    @GET
    public String getSampleMessage() {
        return "Hello, this is a sample resource!\n";
    }
}