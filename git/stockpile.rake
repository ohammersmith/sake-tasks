require 'uri'

namespace 'git' do
  desc "Clones a git repository into a common central location for reference, especially handy "
  task :stockpile do
    repo_url = ENV['REPO']
    unless repo_url
      puts "Pass remote repostiroy as REPO=<url>"
    end
    "Stockpiling repository #{repo_url}."
    stockpile = File.join(ENV['HOME'], "git-stockpile")
    remote = ENV['REPO'] # hopefully this kinda of shit goes away when I try thor
    uri = URI(remote)
    local = File.join(stockpile, uri.host, uri.path)
    puts File.dirname(local)
    FileUtils.mkdir_p(File.dirname(local))
    cmd = "git clone --bare #{remote} #{local}"  # does --bare, if I want a copy to browse I'll clone the bare as a peer
    system(cmd)
  end
end
