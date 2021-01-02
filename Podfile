# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'

# Pods for marvel
def common_pods
    pod 'SwiftLint'
    pod 'Moya'
    pod 'PromiseKit'
    pod 'Kingfisher'
    pod 'SkeletonView'
end

# Pods for marvel Testing
def test_pods
    pod "Quick"
    pod "Nimble"
    pod "Nimble-Snapshots"
end

target 'marvel' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  common_pods

  # Pods for marvel

  target 'marvelTests' do
    inherit! :search_paths
    # Pods for testing
    test_pods
  end

end

target 'marvelUITests' do
  # Pods for testing
  end

