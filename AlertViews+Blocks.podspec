Pod::Spec.new do |s|
  s.name         	= "AlertViews+Blocks"
  s.version      	= "1.0.0"
  s.platform            = :ios, "7.0"
  s.summary      	= "Extensions for UIAlertView and UIActionSheet using blocks"
  s.description		= "Makes really easy to use Alertviews and Action Sheets without having to keep track of them as instance variables."
  s.homepage     	= "https://github.com/wmalloc/AlertViews-Blocks.git"
  s.license      	= 'BSD'
  s.author       	= { "Waqar Malik" => "wmalloc@gmail.com" }
  s.source       	= { :git => "https://github.com/wmalloc/AlertViews-Blocks.git", :tag => "#{s.version}" }
  s.source_files 	= 'AlertViews+Blocks/*.{h,m}'
  s.public_header_files = 'AlertViews+Blocks/*.h'
  s.requires_arc 	= true
end
