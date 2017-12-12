# Can't suppress output of `Puma` in Rails 5.2.0.beta2

I want to suppress the message `Puma starting in single mode...`

```
$ bundle exec rspec
Puma starting in single mode...
* Version 3.11.0 (ruby 2.4.2-p198), codename: Love Song
* Min threads: 0, max threads: 4
* Environment: test
* Listening on tcp://127.0.0.1:52268
Use Ctrl-C to stop
..
```

Timing of `ActionDispatch::SystemTesting::Server.silence_puma = true`

```
$ bundle exec rspec

[9, 18] in ~/sample_rspec_silent_puma/vendor/bundle/gems/actionpack-5.2.0.beta2/lib/action_dispatch/system_testing/server.rb
    9:
   10:       self.silence_puma = false
   11:
   12:       def run
   13:         byebug
=> 14:         setup
   15:       end
   16:
   17:       private
   18:         def setup
(byebug) c

[68, 77] in ~/sample_rspec_silent_puma/vendor/bundle/gems/rspec-rails-3.7.2/lib/rspec/rails/example/system_example_group.rb
   68:
   69:         attr_reader :driver
   70:
   71:         if ActionDispatch::SystemTesting::Server.respond_to?(:silence_puma=)
   72:           byebug
=> 73:           ActionDispatch::SystemTesting::Server.silence_puma = true
   74:         end
   75:
   76:         def initialize(*args, &blk)
   77:           super(*args, &blk)
```

## To solve the problem

```
config.before(:each) do |example|
  if example.metadata[:type] == :system
    if example.metadata[:js]
      Capybara.server = :puma, { Silent: true }
      driven_by :selenium, using: :headless_chrome
    else
      driven_by :rack_test
    end
  end
end
```
