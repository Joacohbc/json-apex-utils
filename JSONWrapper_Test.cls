@IsTest
public with sharing class JSONWrapper_Test {

    // {
    //     "name": "John Doe",
    //     "age": 30,
    //     "salary": 35123.32354,
    //     "email": "johndoe@example.com",
    //     "has_children": false,
    //     "work_days": [ false, true, true, true, true, true, false ],
    //     "address": {
    //       "street": "123 Main Street",
    //       "city": "New York",
    //       "country": "USA"
    //     },
    //     "hobbies": [ "reading", "gaming", "traveling" ],
    //     "favorite_numbers": [ 14, 5, 2022, 4, 6 ],
    //     "favorite_math_numbers": [ 3.1416, 2.7182, 1.414 ],
    //     "friends": [
    //       {
    //         "name": "Jane Smith",
    //         "age": 28
    //       },
    //       {
    //         "name": "Mark Johnson",
    //         "age": 32
    //       }
    //     ]
    //   }
    private static final String data = '{  "name": "John Doe", "age": 30, "salary": 35123.32354, "email": "johndoe@example.com", "has_children": false, "work_days": [ false, true, true, true, true, true, false ], "address": {    "street": "123 Main Street",    "city": "New York",    "country": "USA"  },  "hobbies": ["reading", "gaming", "traveling"],  "favorite_numbers": [14, 5, 2022, 4, 6], "favorite_math_numbers": [ 3.1416, 2.7182, 1.414 ],  "friends": [    {      "name": "Jane Smith",      "age": 28    },    {      "name": "Mark Johnson",      "age": 32    }  ]}';
    
    @IsTest
    static void getPrimitiveData() {
        Test.startTest();
        JSONWrapper jsonData = JSONWrapper.convert(data);
        Test.stopTest();

        Assert.areEqual('John Doe', jsonData.str('name'));
        Assert.areEqual(30, jsonData.int('age'));
        Assert.areEqual(35123.32354, jsonData.db('salary'));
        Assert.areEqual(false, jsonData.bool('has_children'));
    }

    @IsTest
    static void getListPrimitiveData() {
        Test.startTest();
        JSONWrapper jsonData = JSONWrapper.convert(data);
        Test.stopTest();

        List<String> valuesExpected = new List<String> {'reading', 'gaming', 'traveling'};
        Assert.areEqual(valuesExpected, jsonData.strs('hobbies'));

        List<Integer> valuesExpected2 = new List<Integer> {14, 5, 2022, 4, 6};
        Assert.areEqual(valuesExpected2, jsonData.ints('favorite_numbers'));

        List<Double> valuesExpected3 = new List<Double> {3.1416, 2.7182, 1.414};
        Assert.areEqual(valuesExpected3, jsonData.dbs('favorite_math_numbers'));

        List<Boolean> valuesExpected4 = new List<Boolean> {false, true, true, true, true, true, false};
        Assert.areEqual(valuesExpected4, jsonData.bools('work_days'));
    }

    @IsTest
    static void getJSONData(){
        Test.startTest();
        JSONWrapper jsonData = JSONWrapper.convert(data);
        Test.stopTest();
        
        Map<String, Object> valueExpected = new Map<String, Object>();
        valueExpected.put('street', '123 Main Street');
        valueExpected.put('city', 'New York');
        valueExpected.put('country', 'USA');
        
        Assert.areEqual(valueExpected, jsonData.e('address').get());
        Assert.areEqual('123 Main Street', jsonData.e('address').str('street'));
        Assert.areEqual('New York', jsonData.e('address').str('city'));
        Assert.areEqual('USA', jsonData.e('address').str('country'));
    }

    @IsTest
    static void getListJSONData(){
        Test.startTest();
        JSONWrapper jsonData = JSONWrapper.convert(data);
        Test.stopTest();

        Map<String, Object> valueExpected1 = new Map<String, Object>();
        valueExpected1.put('name', 'Jane Smith');
        valueExpected1.put('age', 28);
        
        Map<String, Object> valueExpected2 = new Map<String, Object>();
        valueExpected2.put('name', 'Mark Johnson');
        valueExpected2.put('age', 32);
        
        List<JSONWrapper> valuesResulted = jsonData.arr('friends');
        Assert.areEqual(valueExpected1, valuesResulted.get(0).get());
        Assert.areEqual(valueExpected2, valuesResulted.get(1).get());
    }

    @IsTest
    static void getListRootJSONData(){
        // [
        //     {
        //       "name": "Jane Smith",
        //       "age": 28
        //     },
        //     {
        //       "name": "Mark Johnson",
        //       "age": 32
        //     }
        // ]
        String data = '[{"name":"Jane Smith","age":28},{"name":"Mark Johnson","age":32}]';
        Test.startTest();
        JSONWrapper.JSONWrapperList jsonData = JSONWrapper.convertList(data);
        Test.stopTest();
        
        Map<String, Object> valueExpected1 = new Map<String, Object>();
        valueExpected1.put('name', 'Jane Smith');
        valueExpected1.put('age', 28);
        
        Map<String, Object> valueExpected2 = new Map<String, Object>();
        valueExpected2.put('name', 'Mark Johnson');
        valueExpected2.put('age', 32);

        Assert.areEqual(valueExpected1, jsonData.get(0).get());
        Assert.areEqual(valueExpected2, jsonData.get(1).get());
    }

    @IsTest
    static void createJSON() {
        
        // {
        //     "name": "John Doe",
        //     "age": 30,
        //     "email": "johndoe@example.com",
        //     "address": {
        //       "street": "123 Main Street",
        //       "city": "New York",
        //       "country": "USA"
        //     },
        //     "hobbies": ["reading", "gaming", "traveling"]
        // }
        String jsonExpected = '{"name":"John Doe","age":30,"email":"johndoe@example.com","address":{"street":"123 Main Street","city":"New York","country":"USA"},"hobbies":["reading","gaming","traveling"]}';
        Test.startTest();

        String jsonResult = JSONWrapper.create()
                                .put('hobbies',  new List<String> {'reading', 'gaming', 'traveling'})
                                .put('address',  JSONWrapper.create()
                                                    .put('country', 'USA')
                                                    .put('city', 'New York')
                                                    .put('street', '123 Main Street')
                                                    .build())
                                .put('email', 'johndoe@example.com')
                                .put('age', 30)
                                .put('name', 'John Doe')
                                .JSONString();
        Test.stopTest();
        Assert.areEqual(jsonExpected, jsonResult);
    }
}