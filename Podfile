source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '9.0'
use_frameworks!
#Framework

install! 'cocoapods', :deterministic_uuids => false

abstract_target 'PageDemo' do
    
    pod 'FlexLayout'
   
   pod 'Alamofire'
    
    target:'PageDemo' do
        target 'PageDemoUITests' do
            inherit! :search_paths
        end
        target 'PageDemoTests' do
            inherit! :search_paths
        end
    end
end

