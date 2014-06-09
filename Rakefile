rule ".app" => ".applescript"  do |task|
    puts task.source
    puts task.name
    system("osacompile -o '#{task.name}' '#{task.source}'") || raise("compile of #{task.name} failed")
end

task :default => "SplitFrequency.app" do

end
