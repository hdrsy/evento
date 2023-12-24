String?  passwordValidation(String?  value){
   if (value == null || value.isEmpty) {
    return "Please enter a password"; // Handle null or empty input
  }
  if(value.length <=4){
    return "Please Type Longer password";
  }
  
  
    return null;
  
}