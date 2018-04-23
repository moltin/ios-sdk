Pod::Spec.new do |s|
    s.name         = "Moltin"
    s.version      = "3.0.6"
    s.summary      = "eCommerce made simple"

    s.description  = <<-DESC
        moltin makes eCommerce simple with a wide range of SDKs and integrations.
    DESC

    s.homepage     = "https://moltin.com"
    s.license      = { :type => 'MIT', :file => 'LICENSE' }
    s.authors      = { "Craig Tweedy" => "craig.tweedy@moltin.com" }

    s.platforms    = { :ios => "10.0", :osx => "10.10", :watchos => "3.0", :tvos => "10.0" }

    s.source       = { :git => "https://github.com/moltin/ios-sdk.git", :tag => s.version }

    s.source_files = "Sources/**/*"
    s.requires_arc = true

    s.ios.deployment_target = "10.0"
    s.osx.deployment_target = "10.10"
    s.tvos.deployment_target = "10.0"
    s.watchos.deployment_target = "3.0"
end
