// The JSONWrapper class is a utility class in Apex Salesforce designed to work with JSON data. 
// It provides methods to convert JSON strings into manipulable Apex objects, retrieve specific attributes and elements from 
// JSON objects, and perform basic data type conversions easily.
public class JSONWrapper {
    
    private Map<String, Object> jsonObj;

    private JSONWrapper(Object jsonRaw) {
        if(jsonRaw instanceof String) {
            this.jsonObj = (Map<String, Object>) System.JSON.deserializeUntyped(String.valueOf(jsonRaw));
        } else {
            this.jsonObj = (Map<String, Object>) jsonRaw;
        }
    }

    // Convert a JSON String into a manipulable Apex object
    public static JSONWrapper convert(String jsonData) {
        return new JSONWrapper(jsonData);
    }
    
    // Convert a list of JSON into a manipulable Apex List Object
    public static JSONWrapperList convertList(String jsonData) {
        return new JSONWrapperList(jsonData);
    }
    
    // Create an object that allows creating an Apex object, adding attributes, and returning a Map of Objects or a JSON String
    // It is designed to simplify the creation of JSON with fewer levels of nesting (not for big JSONs)
    public static JSONCreator create() {
        return new JSONCreator();
    }

    // Get a specific JSON element from the current JSON Object and return it as another JSON Object
    public JSONWrapper element(String key) {
        Object obj = jsonObj.get(key);
        return obj != null ? new JSONWrapper(obj) : null;
    }

    // Same that JSONWrapper element(String key)
    public JSONWrapper ele(String key) {
        return element(key);
    }

    // Same that JSONWrapper element(String key)
    public JSONWrapper e(String key) {
        return element(key);
    }

    // Get a specific array of JSONs from the current JSON Object and return it as list of JSON Object
    public List<JSONWrapper> array(String key) { 
        List<JSONWrapper> jsons = new List<JSONWrapper>();
        for (Object e : (List<Object>) jsonObj.get(key)) {
            jsons.add(e != null ? new JSONWrapper(e) : null);
        }
        return jsons;
    }

    // Same that List<JSONWrapper> array(String key)
    public List<JSONWrapper> arr(String key) {
        return array(key);
    }

    // Same that List<JSONWrapper> array(String key)
    public List<JSONWrapper> a(String key) {
        return array(key);
    }

    // String parses
    private String objToString(Object value) {
        if(value == null) return null;
        return String.valueOf(value);
    }

    // Get a specific attribute from the current JSON Object and return it as a String
    public String string(String key) {
        return objToString(jsonObj.get(key));
    }

    // Get a specific list of attributes from the current JSON Object and return them as a list of Strings
    public List<String> strings(String key) { 
        List<String> values = new List<String>();
        for (Object e : (List<Object>) jsonObj.get(key)) {
            values.add(objToString(e));
        }
        return values;
    }
    
    // Same that String string(String key)
    public String str(String key) {
        return string(key);
    }

    // Same that List<String> strings(String key)
    public List<String> strs(String key) {
        return strings(key);
    }

    // Integer Parses
    private Integer objToInteger(Object value) {
        if(value == null) return null;
        return Integer.valueOf(objToString(value));
    }
    
    // Get a specific attribute from the current JSON Object and return it as a Integer
    public Integer integer(String key) {
        return objToInteger(raw(key));
    }

    // Get a specific list of attributes from the current JSON Object and return them as a list of Integers
    public List<Integer> integers(String key) { 
        List<Integer> values = new List<Integer>();
        for (Object e : (List<Object>) jsonObj.get(key)) {
            values.add(objToInteger(e));
        }
        return values;
    }

    // Same that Integer integer(String key)
    public Integer int(String key) {
        return integer(key);
    }

    // Same that List<Integer> integers(String key)
    public List<Integer> ints(String key) { 
        return integers(key);
    }

    // Double Parses
    private Double objToDouble(Object value) {
        if(value == null) return null;
        return Double.valueOf(objToString(value));
    }

    // Get a specific attribute from the current JSON Object and return it as a Double
    public Double double(String key) {
        return objToDouble(raw(key));
    }
    
    // Get a specific list of attributes from the current JSON Object and return them as a list of Doubles
    public List<Double> doubles(String key) {
        List<Double> values = new List<Double>();
        for (Object e : (List<Object>) jsonObj.get(key)) {
            values.add(objToDouble(e));
        }
        return values;
    }

    // Same that Double double(String key)
    public Double db(String key) {
        return double(key);
    }

    // Same that List<Double> doubles(String key)
    public List<Double> dbs(String key) {
        return doubles(key);
    }
    
    // Double Parses
    private Boolean objToBoolean(Object value) {
        if(value == null) return null;
        return Boolean.valueOf(objToString(value));
    }

    // Get a specific attribute from the current JSON Object and return it as a Boolean
    public Boolean boolean(String key) {
        return objToBoolean(raw(key));
    }

    // Get a specific list of attributes from the current JSON Object and return them as a list of Booleans
    public List<Boolean> booleans(String key) {
        List<Boolean> values = new List<Boolean>();
        for (Object e : (List<Object>) jsonObj.get(key)) {
            values.add(objToBoolean(e));
        }
        return values;
    }
    
    // Same that Boolean boolean(String key)
    public Boolean bool(String key) {
        return Boolean.valueOf(string(key));
    }
    
    // Same that List<Boolean> booleans(String key)
    public List<Boolean> bools(String key) {
        return booleans(key);
    }

    // Get a specific attribute from the current JSON Object and return it as a Object (without any conversion) 
    public Object raw(String key) {
        return jsonObj.get(key);
    }

    // Get actual object 
    public Map<String, Object> get() {
        return jsonObj;
    }

    // The JSONWrapperList class is a utility class in Apex Salesforce that represents a list of JSON objects. 
    // It allows for easy conversion of a JSON array into a list of JSON objects using JSONWrapper class and provides 
    // a method to retrieve a specific JSONWrapper object from the list based on the index.
    public class JSONWrapperList {
        private List<JSONWrapper> jsonList;

        public JSONWrapperList(String jsonData) {
            this.jsonList = new List<JSONWrapper>();
            for (Object value : (List<Object>) System.JSON.deserializeUntyped(jsonData)) {
                jsonList.add(new JSONWrapper(value));
            }
        }

        public JSONWrapper get(Integer index) {
            return jsonList.get(index);
        }
    }

    // The JSONCreator class is a utility class in Apex Salesforce used for creating JSON objects.
    // This class is representations of a Map<String, Object> object. It provides methods to add, 
    // remove, and build basic JSON objects.
    public class JSONCreator {
        private Map<String, Object> jsonObj;

        public JSONCreator() {
            this.jsonObj = new Map<String, Object>();
        }

        // Adds a key-value pair to the JSON object being constructed
        public JSONCreator put(String key, Object value) {
            jsonObj.put(key, value);
            return this;
        }
        
        // Conditionally adds a key-value pair to the JSON object based on the provided boolean condition
        public JSONCreator ifPut(Boolean condition, String key, Object value) {
            if(condition) jsonObj.put(key, value);
            return this;
        }

        // Removes a key-value pair from the JSON object being constructed
        public JSONCreator remove(String key) {
            jsonObj.remove(key);
            return this;
        }

        // Conditionally removes a key-value pair from the JSON object based on the provided boolean condition
        public JSONCreator ifRemove(Boolean condition, String key) {
            if(condition) jsonObj.remove(key);
            return this;
        }

        // Returns the built JSON object as a Map<String, Object> (that Apex will convert into a JSON)
        public Map<String, Object> build() {
            return jsonObj;
        }

        // Returns the built JSON object as a serialized JSON string
        public String JSONString() {
            return System.JSON.serialize(jsonObj);
        }
    }
}