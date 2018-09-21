Pod::Spec.new do |s|
  s.name         = "SKAlertView"
  s.version      = "1.0.0"
  s.summary      = "An iOS Alert View."
  s.homepage     = "https://github.com/githubze/SKAlertView"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { 'githubze' => '1424395628@qq.com' }
  s.source       = { :git => "https://github.com/githubze/SKAlertView.git", :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.source_files = "SKAlertView/**/*.{h,m}"
  s.requires_arc = true

end