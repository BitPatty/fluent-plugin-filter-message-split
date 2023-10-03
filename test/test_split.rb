require "test/unit"
require "fluent/test"
require "fluent/test/driver/filter"
require "fluent/plugin/filter_split_message.rb"

class SplitMessageTest < Test::Unit::TestCase
  def setup
    Fluent::Test.setup # this is required to setup router and others
  end

  def create_driver(conf = "")
    Fluent::Test::Driver::Filter.new(Fluent::Plugin::SplitMessage).configure(conf)
  end

  def filter(config, messages)
    d = create_driver(config)
    d.run(default_tag: "test") do
      messages.each do |message|
        d.feed(message)
      end
    end
    d.filtered_records
  end

  test "empty message" do
    messages = [
      { "message" => "" },
    ]
    expected = [
      { "message" => "" },
    ]
    filtered_records = filter("", messages)
    assert_equal(expected, filtered_records)
  end

  test "simple split" do
    messages = [
      { "message" => "foobar,abc" },
    ]
    expected = [
      { "message" => "foobar" },
      { "message" => "abc" },
    ]
    filtered_records = filter("", messages)
    assert_equal(expected, filtered_records)
  end

  test "multi char split" do
    messages = [
      { "message" => "foobar,,,,abc,,,," },
    ]
    expected = [
      { "message" => "foobar" },
      { "message" => "abc" },
    ]
    filtered_records = filter(%[
      delimiter ',,,,'
    ], messages)
    assert_equal(expected, filtered_records)
  end

  test "multi split" do
    messages = [
      { "message" => "foobar,hugo,abc" },
    ]
    expected = [
      { "message" => "foobar" },
      { "message" => "hugo" },
      { "message" => "abc" },
    ]
    filtered_records = filter(%[], messages)
    assert_equal(expected, filtered_records)
  end

  test "trim" do
    messages = [
      { "message" => "    foobar    ,   hugo  ,  abc   def   " },
    ]
    expected = [
      { "message" => "foobar" },
      { "message" => "hugo" },
      { "message" => "abc   def" },
    ]
    filtered_records = filter(%[], messages)
    assert_equal(expected, filtered_records)
  end
end
