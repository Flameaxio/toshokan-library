require 'rake'

unless Rails.rake?
  begin
    ToshokanLibrary::Application.load_tasks
    Rake::Task['ts:start'].invoke
  rescue
    puts 'Already running!'
  end
end
