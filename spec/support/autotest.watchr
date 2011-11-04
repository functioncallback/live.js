def rake
  system('clear')
  system("rake")
end

watch('^(lib/(.*)\.coffee)') { |m| rake }
watch('^(spec/(.*)\.coffee)') { |m| rake }
watch('^(Rakefile)') { |m| rake }

rake