Pod::Spec.new do |s|
  s.name         = 'Moltin'
  s.version      = '0.0.1'
  s.license      = { :type => 'TODO', :file => 'LICENSE' }
  s.homepage     = 'http://github.com/moltin/ios-sdk.git'
  s.authors      = { 'Gasper Rebernak' => 'rebernak.gasper@gmail.com' }
  s.platform     = :ios, '7.0'
  s.description  = <<-DESC
		Moltin description
	DESC
  s.summary      = 'Moltin summary'
  s.source       = { :git => "https://github.com/moltin/ios-sdk.git", :commit => 'fee4042846d821cf7c44d43ecb88956569b69c6e'  }
  s.source_files = 'Moltin', 'Moltin/**/*.{h,m}'
  s.requires_arc = true
  s.dependency 'AFNetworking'
 
end
