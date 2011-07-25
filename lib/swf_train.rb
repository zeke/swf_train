module SwfTrain
      
  # Outputs javscript to embed your SWF.
  # The only required argument is the swf_file path, relative to the public directory.
  # swf_file can also of course be a full URL.
  # 
  #  swf 'foo.swf'
  #  swf 'foo.swf', :height => 50, :flashvars => {:a => 1, :b => 'two'}
  #  swf 'foo.swf', :use_headjs => true # If you're using head.js (http://headjs.com)
  #
  # By default, a DOM container is generated, but if you don't want that just pass in your 
  # custom `dom_id` and set `create_dom_container` to false
  #  swf 'swf/foo.swf', :dom_id => 'dombo', :create_dom_container => false)
  def swf(swf_file, options={})
    options = {
      :swf => swf_file,
      :dom_id => filename_to_dom_id(swf_file),
      :name => filename_to_dom_id(swf_file),
      :width => "100%",
      :height => "100%",
      :wmode => "opaque",
      :allowScriptAccess => "sameDomain",
      :create_dom_container => true,
    }.merge!(options)
  
    out = []
    
    # Yank use_headjs boolean out of the options hash
    # See http://headjs.com/
    use_headjs = options.delete(:use_headjs)
    ready_wrapper = use_headjs ? "head" : "$(document)"
    
    # Yank dom_id out of the options hash
    dom_id = options.delete(:dom_id)
  
    # Yank create_dom_container option out of the hash, if it exists
    # Create DOM container if option is set to something other than false or nil
    if options.delete(:create_dom_container)
      # Set the div's dimensions right away so the page doesn't jolt into
      # the proper dimensions when the swf loads.
      w = options[:width].to_s
      h = options[:height].to_s
      w += "px" unless w.include? "%"
      h += "px" unless h.include? "%"
      style = "width:#{w};height:#{h}"
      out << content_tag(:div, "", :id => dom_id, :style => style)
    end
  
    # Turn flashvars hash into a flashvars-style formatted string
    options[:flashvars] = "{" + hash_to_key_value_string(options[:flashvars]) + "}" if options[:flashvars]
  
    # Format options hash (excluding flashvars) into a key:value string..
    embed = hash_to_key_value_string(options)
  
    # Spit it out!
    out << content_tag(:script, "#{ready_wrapper}.ready(function(){$('##{dom_id}').flash({#{embed}});});", :type => "text/javascript", :charset => "utf-8")
    
    out = out.reverse.join("\n")
    out.respond_to?(:html_safe) ? out.html_safe : out
  end

  # Convert a string to dom-friendly format.
  # Adapted from permalink_fu
  def filename_to_dom_id(str)
    result = str.split("/").last.gsub(".", "_") # e.g. 'foo.swf' -> 'foo_swf'
    result.gsub!(/[^\x00-\x7F]+/, '') # Remove anything non-ASCII entirely (e.g. diacritics).
    result.gsub!(/[^\w \-]+/i, '') # Remove unwanted chars.
    result.gsub!(/[ \-]+/i, '-') # No more than one of the separator in a row.
    result.gsub!(/^\-|\-$/i, '') # Remove leading/trailing separator.
    result.downcase
  end

  # Convert a hash to a string of key:value pairs, delimited by commas
  # Wrap in quotes unless numeric or flashvars hash
  def hash_to_key_value_string(hash)
    pairs = []
    hash.each_pair do |k,v|
      v = "\"#{v}\"" unless k.to_s=='flashvars' || !v.to_s.match(/^[0-9]*\.[0-9]+|[0-9]+$/).nil?
      pairs << "#{k}:#{v}"
    end
    pairs.sort.join(", ")
  end
  
end

ActionView::Base.send(:include, SwfTrain) if defined? Rails