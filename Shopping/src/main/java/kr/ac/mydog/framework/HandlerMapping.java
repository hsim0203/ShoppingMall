package kr.ac.mydog.framework;

import java.io.FileInputStream;
import java.io.InputStream;
import java.lang.reflect.Constructor;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import java.util.Set;

public class HandlerMapping {

    private Map<String, Controller> mappings;

    public HandlerMapping(String propLoc) {

        mappings = new HashMap<>();

        Properties prop = new Properties();
        try (InputStream is = new FileInputStream(propLoc);) {
            System.out.println("Loading properties file from: " + propLoc); // 디버깅 메시지
            prop.load(is);

            Set<Object> keys = prop.keySet();

            for (Object key : keys) {
                String className = prop.getProperty(key.toString());
                System.out.println("Loading controller: " + key + " -> " + className); // 디버깅 메시지

                Class<?> clz = Class.forName(className);
                Constructor<?> constructor = clz.getConstructor();
                Controller control = (Controller) constructor.newInstance();

                mappings.put(key.toString(), control);
            }
            System.out.println("HandlerMapping initialized successfully with " + mappings.size() + " mappings."); // 디버깅 메시지
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }

    public Controller getController(String uri) {
        return mappings.get(uri);
    }
}
