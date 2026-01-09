/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ecems.util;

import software.amazon.awssdk.auth.credentials.AwsBasicCredentials;
import software.amazon.awssdk.auth.credentials.StaticCredentialsProvider;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.s3.S3Client;
import java.net.URI;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.http.apache.ApacheHttpClient;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;

/**
 *
 * @author NAFIS
 */
public class S3Connection {
    private static final String S3_ENDPOINT = "https://oiuusqzyuhorissjgjez.storage.supabase.co/storage/v1/s3";  // For client operations (upload/download)
    private static final String PUBLIC_BASE_URL = "https://oiuusqzyuhorissjgjez.storage.supabase.co/storage/v1/object/public/";  // For serving public files

    private static final String ACCESS_KEY = "4a39a9d46fff702d332b0057a67ee190";
    private static final String SECRET_KEY = "28f6c884faa231ac9c24e68012effd6422ec97379e479f757847baa292c7e7a9";

    private static final Region REGION = Region.AP_NORTHEAST_1; 
    private static S3Client client;

    public static S3Client getClient() {
        if (client == null) {
            AwsBasicCredentials credentials = AwsBasicCredentials.create(ACCESS_KEY, SECRET_KEY);

            client = S3Client.builder()
            .endpointOverride(URI.create(S3_ENDPOINT))
            .region(REGION)
            .credentialsProvider(
                StaticCredentialsProvider.create(credentials))
            .forcePathStyle(true)
            .httpClient(
                ApacheHttpClient.builder()
                    .tlsTrustManagersProvider(
                        () -> SupabaseSSL.createTrustManagers()
                    )
                    .build()
                )
            .build();
        }
        return client;
    }

    public static String getPublicObjectUrl(String bucketName, String key) {
        return PUBLIC_BASE_URL + bucketName + "/" + key;
    }
    
    public static boolean testUpload() {
        S3Client s3 = getClient();
        String bucketName = "ecems";
        String key = "banner/test-upload-success.txt";
        String content = "Supabase S3 upload test successful! Time: " + System.currentTimeMillis();

        try {
            PutObjectRequest putRequest = PutObjectRequest.builder()
                    .bucket(bucketName)
                    .key(key)
                    .contentType("text/plain")
                    .build();

            s3.putObject(putRequest, RequestBody.fromString(content));

            System.out.println("TEST UPLOAD SUCCESSFUL! Check your bucket: " + getPublicObjectUrl(bucketName, key));
            return true;

        } catch (Exception e) {
            System.err.println("TEST UPLOAD FAILED!");
            e.printStackTrace();
            return false;
        }
    }
}
