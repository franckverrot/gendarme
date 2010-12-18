# Gendarme

## Introduction

Gendarme will bring order to chaos (well... that's the role of Gendarme ma bonne Dame...).
Gendarme checks for preconditions and postrelations on the methods you want it to monitor.

It does not replace a regular test framework (Rspec, Test::Unit,
you-name-it), it all started when I have been asked how to replicate an
annotation system with Ruby. This is more or less how I would implement
it in real life (but I highly doubt I would ever want to do that).

## Usage

Put this in your Gemfile:

    gem install gendarme

Once Gendarme is installed, add it to your classes:

    # Eventually configure where you want the messages to be displayed
    Gendarme::Configuration.logger = $stderr # Standard error

    class Foo
      include Gendarme::Gendarme # Add Gendarme's method to your class

      precondition(0,"Argument 0 is a String") { |bar| bar.respond_to?(:to_str) }
      precondition(1,"Argument 1 is 10")       { |baz| baz == 10 }
      postrelation(0,"Result is an Integer")   { |res| res.is_a?(Integer)}
      def foo(bar,baz)
        ...
        "not an integer"
      end
    end

    # Now let's try it, neither the inputs nor the output are valid
    Foo.new.foo(42, "hello")
    => "not an integer"

   # You should see this in the standard error output
     This precondition is false: Argument 0 is a String
     This precondition is false: Argument 1 is 10
     This postrelation is false: Result is an Integer

##Note on Patches/Pull Requests

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.


Contributors
------------
* Franck Verrot

Copyright
---------

Copyright (c) 2010 Franck Verrot. MIT LICENSE. See LICENSE for details.
