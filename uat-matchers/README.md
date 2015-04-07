# UAT::Matchers

A gem providing matchers to aid in testing

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'uat-matchers'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install uat-matchers

## Usage

# uat

User Acceptance Test tooling

    ```
    UAT::Matchers::RPCHelper
       UAT::Matchers::RPCHelper#setup!(url)
         sets the url used by instances that include this module
       #make_rpc(rpc_class, method, request, response_class, &optional_block)
         when the request is successful
           performs an rspec expectation that the class of the response matches "response_class"
           behaves like an rpc call
             creates an instance of rpc_class using the "client" class method, passing a hash with the url parts
             calls the "method" on the resulting rpc_client, passing in the request
             registers a callback for success
             registers a callback for failure
           and if the rspec expectation fails
             raises an exception
           and if the rspec expectation passes
             and a block is passed
               calls the block, passing in the response
         when the request is a failure
           raises an exception
           which is the result of calling inspect on the parameter in the on_error handler block (PENDING: Temporarily skipped with xit)
           behaves like an rpc call
             creates an instance of rpc_class using the "client" class method, passing a hash with the url parts
             calls the "method" on the resulting rpc_client, passing in the request
             registers a callback for success
             registers a callback for failure
    ```