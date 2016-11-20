require "spec_helper"

describe Html2rails do
  it "has a version number" do
    expect(Html2rails::VERSION).not_to be nil
  end

  it "should conver simple html without any changes" do
    expect(Html2rails.convert!("<html><head></head><body></body></html>"))
    .to eql(
    '<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
<html>
<head><meta http-equiv="Content-Type" content="text/html; charset=US-ASCII"></head>
<body></body>
</html>
')
  end
end
