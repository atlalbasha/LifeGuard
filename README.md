# LifeGuard

start 
1. sudo gem install cocoapods
2. pod init
3. open pod file 
4. copy/past:
 
platform :ios, '15.0'

target 'LifeGuard' do
  
 # use_frameworks!

  # Pods for LifeGuard

# pod 'SwipeCellKit'

use_frameworks!
pod 'RealmSwift'

pod 'MTSlideToOpen'
end

5. pod install 
6. open LifeGuard.xcwork.space file on xcode
