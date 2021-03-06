SWF Train (swiff train)
=======================

SWF Train is a simple and flexible Rails helper for embedding SWFs in your views. 
It requires [jQuery](http://jquery.com/) and [jQuery SWFObject](http://jquery.thewikies.com/swfobject/).

Installation
------------

  gem install swf_train

Usage
-----


``` ruby
# <head>
javascript_include_tag %w(jquery-1.3.2.min jquery.swfobject.1-1-1.min)

# <body>
swf 'my_swf.swf'
swf 'subdirectory/of/public/another.swf', :width => 500, :height => 300
swf 'http://example.com/yet_another.swf', :wmode => 'opaque'
```

Passing in FlashVars is easy:

``` ruby
swf 'swf/foo.swf', :flashvars => {:foo => 'chacha', :bar => 250}
```
      
By default, a DOM element is automatically created based on a variation of the swf filename, 
but you can override it like so:

``` ruby
swf 'swf/foo.swf', :dom_id => 'custom_dom_dom_doobie', :create_dom_container => false
```

SWF Train provides built-in support for the awesome non-blocking [head.js](http://headjs.com/) library, 
so you can use jQuery on the body of the page even though it is not included yet:

``` ruby
swf 'swf/foo.swf', :use_headjs => true
```

See full auto-generated documentation at [rdoc.info/projects/zeke/swf_train](http://rdoc.info/projects/zeke/swf_train)

Compatibility
-------------

- v1.0+ requires Rails 3
- v0.0.2 is compatible with Rails 2

Tests
-----

    bundle exec rake spec

Copyright
---------

Copyright (c) 2010-2011 Zeke Sikelianos. See LICENSE for details.