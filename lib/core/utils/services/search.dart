// import 'dart:mirrors';

// List<T> generalSearch<T>(List<T> items, String searchKey, String query) {
//   if (query.isEmpty) {
//     return items;
//   }

//   var results = <T>[];

//   for (var item in items) {
//     // Use reflection to get the value of 'searchKey' from 'item'
//     var instanceMirror = reflect(item);
//     var classMirror = instanceMirror.type;
//     if (classMirror.declarations.containsKey(Symbol(searchKey))) {
//       var field = classMirror.declarations[Symbol(searchKey)] as VariableMirror;
//       if (field.type.reflectedType == String) {
//         var value = instanceMirror.getField(Symbol(searchKey)).reflectee;
//         if (value.toString().toLowerCase().contains(query.toLowerCase())) {
//           results.add(item);
//         }
//       }
//     }
//   }

//   return results;
// }
