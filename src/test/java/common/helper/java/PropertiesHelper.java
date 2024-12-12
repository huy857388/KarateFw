package common.helper.java;

import java.io.FileInputStream;
import java.io.InputStream;
import java.util.Properties;


public class PropertiesHelper {

    private static Properties properties;

    public static Properties propsForName(String propFileName) {
        InputStream inputStream = null;
        try {
            System.out.println("Loading properties : " + propFileName);
            inputStream = new FileInputStream(propFileName);

            if (inputStream != null) {
                Properties prop = new Properties();
                prop.load(inputStream);
                return prop;
            } else {
                System.err.println(propFileName + " not found !");
                return null;
            }
        } catch (Exception e) {
            System.out.println("Exception: " + e);
        } finally {
            if (inputStream != null) {
                try {
                    inputStream.close();
                } catch (Exception e) {
                }
            }
        }
        return null;
    }

    public static void loadDataProperties(String env) {
        properties = propsForName(System.getProperty("user.dir")
                + "/src/test/java" + "/resources/environment/" + env + ".properties");
    }

    public static String getPropValue(String key) {
        return getPropValue(key, null);
    }

    public static String getPropValue(String key, String defaultValue) {
        if (System.getProperty(key) != null) {
            return System.getProperty(key);
        }
        if (properties != null && properties.containsKey(key)) {
            return properties.getProperty(key);
        }
        return defaultValue;
    }

}