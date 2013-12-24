defmodule ElementTest do
  use ExUnit.Case
  use Hound.Helpers

  hound_session

  test "should get visible text of an element" do
    navigate_to "http://localhost:9090/page1.html"
    element_id = find_element(:class, "example")
    assert visible_text(element_id) == "Paragraph"
  end


  test "should set value of a field" do
    navigate_to "http://localhost:9090/page1.html"
    element_id = find_element(:name, "username")
    set_value(element_id, "johndoe")
    assert attribute_value(element_id, "value") == "johndoe"
  end


  test "should get tag name of element" do
    navigate_to "http://localhost:9090/page1.html"
    element_id = find_element(:name, "username")
    assert tag_name(element_id) == "input"
  end


  test "should clear field" do
    navigate_to "http://localhost:9090/page1.html"
    element_id = find_element(:name, "username")
    set_value(element_id, "johndoe")
    assert attribute_value(element_id, "value") == "johndoe"

    clear_field(element_id)
    assert attribute_value(element_id, "value") == ""
  end


  test "should return true if item is selected in a checkbox or radio" do
    navigate_to "http://localhost:9090/page1.html"
    element_id = find_element :id, "speed-superpower"
    click element_id
    assert selected?(element_id)
  end


  test "should return false if item is *not* selected" do
    navigate_to "http://localhost:9090/page1.html"
    element_id = find_element :id, "speed-flying"
    assert selected?(element_id) == false
  end


  test "Should return true if element is enabled" do
    navigate_to "http://localhost:9090/page1.html"
    element_id = find_element(:name, "username")
    assert enabled?(element_id) == true
  end


  test "Should return false if element is *not* enabled" do
    navigate_to "http://localhost:9090/page1.html"
    element_id = find_element(:name, "promocode")
    assert enabled?(element_id) == false
  end


  test "should get attribute value of an element" do
    navigate_to "http://localhost:9090/page1.html"
    element_id = find_element(:class, "example")
    assert attribute_value(element_id, "data-greeting") == "hello"
  end


  test "should return true if an element is displayed" do
    navigate_to "http://localhost:9090/page1.html"
    element_id = find_element(:class, "example")
    assert displayed?(element_id)
  end


  test "should return false if an element is *not* displayed" do
    navigate_to "http://localhost:9090/page1.html"
    element_id = find_element(:class, "hidden-element")
    assert displayed?(element_id) == false
  end


  test "should get an element's location on screen" do
    navigate_to "http://localhost:9090/page1.html"
    element_id = find_element :class, "example"
    location = element_location element_id
    assert is_integer(location["x"]) || is_float(location["x"])
    assert is_integer(location["y"]) || is_float(location["y"])
  end


  test "should get an element's size" do
    navigate_to "http://localhost:9090/page1.html"
    element_id = find_element(:class, "example")
    size = element_size(element_id)
    assert size["height"] == 100
    assert size["width"]  == 400
  end


  test "should get css property of an element" do
    navigate_to "http://localhost:9090/page1.html"
    element_id = find_element(:class, "container")
    assert css_property(element_id, "display") == "block"
  end


  test "should click on an element" do
    navigate_to "http://localhost:9090/page1.html"
    element_id = find_element(:class, "submit-form")
    click element_id
    assert current_url == "http://localhost:9090/page2.html"
  end


  test "should submit a form element" do
    navigate_to "http://localhost:9090/page1.html"
    element_id = find_element(:name, "username")
    submit(element_id)
    assert current_url == "http://localhost:9090/page2.html"
  end
end
