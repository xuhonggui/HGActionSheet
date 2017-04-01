Pod::Spec.new do |s|
  s.name         = "HGActionSheet"
  s.version      = "1.0.0"
  s.summary      = "a custom pop view from bottom"
  s.homepage     = "https://github.com/xuhonggui/HGActionSheet"
  s.license      = "MIT"
  s.author       = { "xuhonggui" => "593692553@qq.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/xuhonggui/HGActionSheet.git", :tag => s.version }
  s.source_files  = "*.{h,m}"
  s.resources = "*.bundle"
  s.requires_arc = true
end
