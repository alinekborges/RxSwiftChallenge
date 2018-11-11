# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

def rx_libs
    workspace 'RxLogin.xcworkspace'
	use_frameworks!
	pod 'RxSwift',    '~> 4.0'
	pod 'RxCocoa',    '~> 4.0'
    pod 'RxSwiftUtilities'
end

target 'RxLogin' do
    project 'RxLogin/RxLogin.xcodeproj'
	rx_libs
end

target 'RxAutocomplete' do
    project 'RxAutocomplete/RxAutocomplete.xcodeproj'
    rx_libs
end

target 'RxPagination' do
    project 'RxPagination/RxPagination.xcodeproj'
    rx_libs
end
