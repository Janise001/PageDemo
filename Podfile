source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '9.0'
use_frameworks!
#Framework

#install! 'cocoapods', :deterministic_uuids => false

target 'PageDemo' do
    
   pod 'FlexLayout'
   pod 'RxSwift'
   pod 'RxCocoa'
   pod 'Alamofire'
   pod 'Kingfisher', :git => 'https://github.com/onevcat/Kingfisher'
   pod 'IQKeyboardManagerSwift'
   pod 'ZFPlayer'
   pod 'FDFullscreenPopGesture'
   pod 'MJRefresh'
   
    target:'PageDemo' do
        target 'PageDemoUITests' do
            inherit! :search_paths
        end
        target 'PageDemoTests' do
            inherit! :search_paths
        end
    end
end

