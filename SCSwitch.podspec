Pod::Spec.new do |s|
    s.name = 'SCSwitch'
    s.version = '1.0.1'
    s.license = 'MIT'
    s.summary = 'An SCSwitch control like UISwitch, but created custom UI like toggle button.'
    s.homepage = 'https://github.com/sagar4893'
    s.authors = { 'Sagar Chauhan' => 'sagar.ios11@gmail.com' }
    s.source = { :git => 'https://github.com/sagar4893/SCSwitch.git', :tag => s.version }

    s.platform = :ios, "11.0"
    s.ios.deployment_target = '11.0'

    s.swift_versions = ['4.0', '5.0', '5.1']

    s.source_files = 'SCSwitch/*.swift'
end
