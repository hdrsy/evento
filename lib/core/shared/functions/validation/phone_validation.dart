String?  phoneValidation(String?  value){
   if (value == null || value.isEmpty) {
    return "Please enter a phone number"; // Handle null or empty input
  }
  if(value.length !=10 ||value.length !=9){
    return "Please enter a valid number";
  }if(value.length ==9 && value[0]!= "9"){
    return "Please enter a valid number";

  }
  
  
    return null;
  
}