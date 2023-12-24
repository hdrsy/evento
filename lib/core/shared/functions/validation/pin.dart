String?  pinValidation(String?  value){
   if (value == null || value.isEmpty) {
    return "Please enter a pin"; // Handle null or empty input
  }
  if(value.length != 4){
    return "Please Type 4 digites";
  }
  
  
    return null;
  
}