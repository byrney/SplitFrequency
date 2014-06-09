INSTALL_DIR=ENV["HOME"]+"/Applications/"

rule ".app" => ".applescript"  do |task|
    puts "compiling #{task.source} to #{task.name}"
    system("osacompile -o '#{task.name}' '#{task.source}'") || raise("compile of #{task.name} failed")
end

rule "SplitFrequency.app/Contents/Resources/Scripts/photo-splitfreq.sh" => "photo-splitfreq.sh" do |task|
    cp task.source, task.name
end

task :app => "SplitFrequency.app"
task :resources => "SplitFrequency.app/Contents/Resources/Scripts/photo-splitfreq.sh"

task :default => [:app, :resources] do

end

task :install => :default do
    cp_r "SplitFrequency.app", INSTALL_DIR
end
