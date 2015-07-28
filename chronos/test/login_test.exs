defmodule LoginTest do
  #use ExUnit.CaseTemplate
  use Chronos.ConnCase
  
  # Import Hound helpers
  use Hound.Helpers

  # Start a Hound session
  hound_session

  # Set test timeout (miliseconds)
  @tag timeout: 90000

  test "login_administrador" do
     url = "http://213.239.207.18:8180/login.jsp"
     navigate_to(url)
     input_into_field({:name, "j_rfc"}, "AAA010101AAA")
     input_into_field({:name, "j_username"}, "AAA010101AAA")
     input_into_field({:name, "j_password"}, "admin")
     click({:id, "btnSubmit"})
  end
end
