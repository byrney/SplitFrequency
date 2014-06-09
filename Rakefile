INSTALL_DIR = ENV["HOME"] + "/Applications/"
APP_NAME = "SplitFrequency.app"
SCRIPT_DIR = "#{APP_NAME}/Contents/Resources/Scripts"

rule ".app" => ".applescript"  do |task|
    puts "compiling #{task.source} to #{task.name}"
    system("osacompile -o '#{task.name}' '#{task.source}'") || raise("compile of #{task.name} failed")
    touch task.name
end

rule "#{SCRIPT_DIR}/photo-splitfreq.sh" => "photo-splitfreq.sh" do |task|
    cp task.source, task.name
end

task :app => APP_NAME

task :resources => "#{SCRIPT_DIR}/photo-splitfreq.sh"

task :default => [:app, :resources]

task :install => :default do
    cp_r APP_NAME, INSTALL_DIR
end

