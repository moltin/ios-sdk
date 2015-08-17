Pod::Spec.new do |s|
  s.name         = 'Moltin'
  s.version      = '1.0.1'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.homepage     = 'http://github.com/moltin/ios-sdk.git'
  s.authors      = { 'Moltin' => 'support@moltin.com', 'Dylan McKee' => 'dylan@djmckee.co.uk', 'Gasper Rebernak' => 'rebernak.gasper@gmail.com' }
  s.platform     = :ios, '7.0'
  s.description  = <<-DESC
		iOS SDK for the Moltin eCommerce API.
	DESC
  s.summary      = 'iOS SDK for the Moltin eCommerce API'
  s.source       = { :git => "https://github.com/moltin/ios-sdk.git", :tag => 'v1.0.1'  }
  s.source_files = 'Moltin', 'Moltin/**/*.{h,m}'
  s.requires_arc = true
  s.dependency 'AFNetworking'

end
