$(document).ready(function() {
  if($(".form-errors").length || $("#user_type_user").val() == 2){
    $(".user_teams").show();
    $(".user_birthday").show();
  }else{
    $(".user_teams").hide();
    $(".user_birthday").hide();
  }

  $("#user_type_user").change(function(){
    if($(this).val() == 2){
      $(".user_teams").show();
      $(".user_birthday").show();
      $("#user_password").val("12345678")
      $("#user_password_confirmation").val("12345678")
    }else{
      $(".user_teams").hide();
      $(".user_birthday").hide();
    }
  });
});