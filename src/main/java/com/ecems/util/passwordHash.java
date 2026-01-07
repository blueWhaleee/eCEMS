/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ecems.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 *
 * @author SYAFIQ
 */
public class passwordHash {
    public static String doHashing(String password) {
        try {
            MessageDigest messageDigest = MessageDigest.getInstance("MD5");
            messageDigest.update(password.getBytes());
            
            byte[] resultByteArray = messageDigest.digest();
            StringBuilder sb = new StringBuilder();
            
            for(byte b : resultByteArray) {
                sb.append(String.format("%02x", b));
            }
            
            return sb.toString();
            
        } catch(NoSuchAlgorithmException ex) {
            ex.printStackTrace();
        }
        return "";
    }

    public static String picturePath(String stud_number) {
        String id = stud_number + "UiTMUCMS";
        String path = "https://cdn.uitm.link/gambar_warga/" + doHashing(id) + ".png";
        return path;
    }
}
