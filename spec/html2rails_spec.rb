require "spec_helper"

describe Html2rails do
  it "has a version number" do
    expect(Html2rails::VERSION).not_to be nil
  end

  it "should convert simple html without any changes" do
    expect(Html2rails.convert!("<html><head></head><body></body></html>"))
    .to eql(
    '<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
   <head>
      <meta http-equiv="Content-Type" content="text/html; charset=US-ASCII" />
</head>
   <body></body>
</html>')
  end

  it "should convert image tag" do
    expect(Html2rails.convert!('<html><head></head><body><img src="/asdad.pic" /></body></html>'))
        .to eql(
                '<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
   <head>
      <meta http-equiv="Content-Type" content="text/html; charset=US-ASCII" />
</head>
   <body>
<%= image_tag("/asdad.pic") %>
   </body>
</html>')
  end


  it "should convert image tag with additional attribute" do
    expect(Html2rails.convert!('<html><head></head><body><img class="test-calsss" src="/asdad.pic" /></body></html>'))
        .to eql(
                '<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
   <head>
      <meta http-equiv="Content-Type" content="text/html; charset=US-ASCII" />
</head>
   <body>
<%= image_tag("/asdad.pic", :class => "test-calsss") %>
   </body>
</html>')
  end

  it "should convert image tag with multiple additional attributes" do
    expect(Html2rails.convert!('<html><head></head><body><img class="test-calsss" src="/asdad.pic" size="46"/></body></html>'))
        .to eql(
                '<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
   <head>
      <meta http-equiv="Content-Type" content="text/html; charset=US-ASCII" />
</head>
   <body>
<%= image_tag("/asdad.pic", :class => "test-calsss", :size => "46") %>
   </body>
</html>')
  end

  it "should convert image tag with multiple additional attributes" do
    expect(Html2rails.convert!('<html><head><link rel="stylesheet" href="styles.css"></head><body></body></html>'))
        .to eql(
                '<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
   <head>
      <meta http-equiv="Content-Type" content="text/html; charset=US-ASCII" />
<%= stylesheet_link_tag("styles.css") %>
   </head>
   <body></body>
</html>')
  end


  it "should convert to slim as well" do
    require 'html2slim'
    expect(HTML2Slim.convert!(Html2rails.convert!('<html><head><link rel="stylesheet" href="styles.css"></head><body></body></html>'),:erb).to_s)
        .to eql(
'doctype html
html[xmlns="http://www.w3.org/1999/xhtml"]
  head
    meta[http-equiv="Content-Type" content="text/html; charset=US-ASCII"]
    = stylesheet_link_tag("styles.css")
  body')
  end
end
