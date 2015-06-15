Pod::Spec.new do |s|
  s.name         = 'Moltin'
  s.version      = '0.0.1'
  #s.license      = { :type => 'TODO' }
  s.homepage     = 'https://github.com/moltin/ios-sdk.git'
  s.authors      = { 'Gasper Rebernak' => 'rebernak.gasper@gmail.com' }
  s.platform     = :ios, '7.0'
  s.summary      = 'Inventory, cart, checkout, payments & more through a simple API, moltin was built from the ground up to power any website or mobile application in minutes.'
  s.source       = { :git => "https://github.com/moltin/ios-sdk.git" }
  s.source_files = 'Moltin/*.{h,m}
  s.requires_arc = true
  s.dependency "AFNetworking"
 
end
