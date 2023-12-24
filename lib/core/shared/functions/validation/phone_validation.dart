String?  phoneValidation(String?  value){
   if (value == null || value.isEmpty) {
    return "Please enter a phone number"; // Handle null or empty input
  }
  if(value.length !=10){
    return "Please enter a valid number";
  }
  
  
    return null;
  
}