# fluent-plugin-filter-split-message

A [fluentd](https://www.fluentd.org/) filter plugin for splitting messages by a customizable delimiter.

## Sample

```ruby
  {"message": "abc,def,ghi"}
```

.. is turned into ..

```ruby
  {"message": "abc"}
  {"message": "def"}
  {"message": "ghi"}
```

## Usage

Install the plugin:

```sh
# See https://github.com/BitPatty/fluent-plugin-filter-split-message/releases for a list of valid versions
gem install fluent-plugin-filter-split-message --version "<desired version>"
```

Create a logdrain and update your fluent configuration:

```conf
<filter>
  @type split_message

  # (Optional) The delimiter to use, defaults to ","
  delimiter ,

  # (Optional) The target field, defaults to "message"
  field_key message
</source>
```


## Credit

- [fluent-plugin-split-event](https://github.com/uken/fluent-plugin-split-event) used as plugin reference
