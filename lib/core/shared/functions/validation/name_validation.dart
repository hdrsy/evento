String?  nameValidation(String?  value){
   if (value == null || value.isEmpty) {
    return "Please enter a name"; // Handle null or empty input
  }
  if(value.length <=2){
    return "Please Type Longer name";
  }
  else if(value.length>20 ){
    return "Please type shorter name";
  }
  
    return null;
  
}