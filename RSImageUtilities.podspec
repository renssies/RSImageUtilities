Pod::Spec.new do |s|
  s.name     = 'RSImageUtilities'
  s.version  = '0.1.6'
  s.license  = 'BSD'
  s.summary  = 'UIImage categories based on MGImageUtilities.'
  s.homepage = 'https://github.com/renssies/RSImageUtilities'
  s.authors  = { 'Rens Verhoeven' => 'rens@rensies.nl'}
  s.source   = { :git => 'https://github.com/renssies/RSImageUtilities.git', :tag => '0.1.6' }
  s.source_files = 'RSImageUtilities/Source'
  s.requires_arc = true
  s.ios.deployment_target = '5.0'
end
