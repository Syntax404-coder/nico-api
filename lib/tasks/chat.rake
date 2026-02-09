namespace :chat do
  desc "Clear chat history between two users"
  task :clear, [:email1, :email2] => :environment do |t, args|
    email1 = args[:email1] || "nico@matchpoint.com"
    email2 = args[:email2] || "louise@matchpoint.com"

    puts "Attempting to clear chat between #{email1} and #{email2}..."

    user1 = User.find_by(email: email1)
    user2 = User.find_by(email: email2)

    unless user1 && user2
      puts "Error: One or both users not found."
      next
    end

    # Find matches where user1 and user2 are participants
    matches = Match.where(user1: user1, user2: user2).or(Match.where(user1: user2, user2: user1))

    if matches.empty?
      puts "No match found between #{email1} and #{email2}."
      next
    end

    matches.each do |match|
      count = match.messages.count
      match.messages.destroy_all
      puts "Cleared #{count} messages from match ##{match.id}."
    end
    
    puts "Chat history cleared successfully!"
  end
end
