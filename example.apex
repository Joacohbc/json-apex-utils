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
final String data = '{  "name": "John Doe", "age": 30, "salary": 35123.32354, "email": "johndoe@example.com", "has_children": false, "work_days": [ false, true, true, true, true, true, false ], "address": {    "street": "123 Main Street",    "city": "New York",    "country": "USA"  },  "hobbies": ["reading", "gaming", "traveling"],  "favorite_numbers": [14, 5, 2022, 4, 6], "favorite_math_numbers": [ 3.1416, 2.7182, 1.414 ],  "friends": [    {      "name": "Jane Smith",      "age": 28    },    {      "name": "Mark Johnson",      "age": 32    }  ]}';

JSONWrapper json = JSONWrapper.convert(data);

// Convert three basic types: String, Integer, Boolean and Double
System.debug(json.str('name')); // John Doe
// str(key) and string(key) are the same

System.debug(json.int('age')); // 30
// int(key) and integer(key) are the same

System.debug(json.double('salary')); // 35123.32354
// db(key) and double(key) are the same

System.debug(json.bool('has_children')); // false
// bool(key) and boolean(key) are the same

// If you need the raw value can use:
Object rawValue = json.raw('salary');
// ... Any kinde of parse

// If have a array of value can use:
System.debug(json.strings('hobbies')); // ('reading', 'gaming', 'traveling')

// If need to access a JSON Object inside in the root JSON, use:
System.debug(json.e('address').str('street')); // 123 Main Street
// e(key), ele(key) and element(key) are the same

System.debug(json.e('address').str('country')); // USA
System.debug(json.e('address').str('city')); // New York


// If need to access an array JSON Object inside in the root JSON, use:
System.debug(json.arr('friends').get(0).str('name')); // Jane Smith
System.debug(json.arr('friends').get(1).str('name')); // Mark Johnson

// But if you root element it a array JSON, like this: 
// [
//       {
//         "name": "Jane Smith",
//         "age": 28
//       },
//       {
//         "name": "Mark Johnson",
//         "age": 32
//       }
//  ]
// You need to use:
String dataList = '[{"name": "Jane Smith","age": 28},{"name": "Mark Johnson","age": 32}]';
JSONWrapper.JSONWrapperList jsonList = JSONWrapper.convertList(dataList);

// And you can get JSONWrapper using get(index) method
JSONWrapper item = jsonList.get(1);
System.debug(item.int('age')); // 32