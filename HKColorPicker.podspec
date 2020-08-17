
Pod::Spec.new do |spec|

  spec.name         = "HKColorPicker"
  
  spec.version      = "1.0.1"
  
  spec.summary      = "Color picker from few predefined colors."

  spec.description  = <<-DESC
  HKColorPicker is  simple control for selecting a color from a small set of predefined colors.
                   DESC

  spec.homepage     = "https://github.com/HasanKassem/HKColorPicker"
  
  spec.social_media_url = 'https://twitter.com/hasankassem_'

  spec.license      = { :type => "MIT", :file => "LICENSE" }

  spec.author             = "Hasan Kassem"

  spec.platform     = :ios, "12.0"

  spec.source       = { :git => "https://github.com/HasanKassem/HKColorPicker.git", :tag => "1.0.1" }

  spec.source_files     =   'HKColorPicker/Sources/**/*.swift'

  spec.swift_version = "5"
  
end
