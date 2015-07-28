defmodule Chronos.ClientControllerCreateTest do
  use Chronos.ConnCase

  test "Create" do

    # Aprovisiona un Perfil a un Cliente
    conn = conn()
      |> put_req_header("content-type", "application/json; charset=utf-8")
      |> post("/api/v1/clients/1/profiles/1", "{\"is_prepaid\": false}")
    json_response(conn, 201)

  end

  test "Validate data: client_id" do

    # Aprovisiona un Perfil a un Cliente
    conn = conn()
      |> put_req_header("content-type", "application/json; charset=utf-8")
      |> post("/api/v1/clients/a/profiles/1", "{\"is_prepaid\": false}")
    body = json_response(conn, 400)

    assert "data_validation" = body["stage"]
    assert %{"client_id" => "is invalid"} = body["error_details"]
    assert 1401 = body["code"]

  end

  test "Validate data: profile_id" do

    # Aprovisiona un Perfil a un Cliente
    conn = conn()
      |> put_req_header("content-type", "application/json; charset=utf-8")
      |> post("/api/v1/clients/1/profiles/a", "{\"is_prepaid\": false}")
    body = json_response(conn, 400)

    assert "data_validation" = body["stage"]
    assert %{"profile_id" => "is invalid"} = body["error_details"]
    assert 1401 = body["code"]

  end

  test "Validate data: is_prepaid" do

    # Aprovisiona un Perfil a un Cliente
    conn = conn()
      |> put_req_header("content-type", "application/json; charset=utf-8")
      |> post("/api/v1/clients/1/profiles/1", "{\"is_prepaid\": 1}")
    body = json_response(conn, 400)

    assert "data_validation" = body["stage"]
    assert %{"is_prepaid" => "is invalid"} = body["error_details"]
    assert 1401 = body["code"]

  end

  test "Validate data: client_id, is_prepaid, profile_id" do

    # Aprovisiona un Perfil a un Cliente
    conn = conn()
      |> put_req_header("content-type", "application/json; charset=utf-8")
      |> post("/api/v1/clients/a/profiles/a", "{\"is_prepaid\": 1}")
    body = json_response(conn, 400)

    assert "data_validation" = body["stage"]
    assert  %{"client_id" => "is invalid", "is_prepaid" => "is invalid", "profile_id" => "is invalid"} = body["error_details"]
    assert 1401 = body["code"]

  end

  test "Validate integrity: El Cliente ya tiene asociado el Perfil" do

    # Aprovisiona un Perfil a un Cliente
    conn = conn()
      |> put_req_header("content-type", "application/json; charset=utf-8")
      |> post("/api/v1/clients/1/profiles/1", "{\"is_prepaid\": false}")
    json_response(conn, 201)

    # Aprovisiona un Perfil a un Cliente
    conn = conn()
      |> put_req_header("content-type", "application/json; charset=utf-8")
      |> post("/api/v1/clients/1/profiles/1", "{\"is_prepaid\": false}")
    body = json_response(conn, 400)

    assert "integrity_validation" = body["stage"]
    assert %{"client_profile" => "El Cliente ya tiene asociado el Perfil"} = body["error_details"]
    assert 1451 = body["code"]

  end

  test "Validate integrity: El Perfil no existe" do

    # Aprovisiona un Perfil a un Cliente
    conn = conn()
      |> put_req_header("content-type", "application/json; charset=utf-8")
      |> post("/api/v1/clients/1/profiles/999", "{\"is_prepaid\": false}")
    body = json_response(conn, 400)

    assert "integrity_validation" = body["stage"]
    assert %{"profile" => "El Perfil no existe"} = body["error_details"]
    assert 1451 = body["code"]

  end

end
