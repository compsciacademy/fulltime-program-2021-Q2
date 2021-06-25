namespace :db do
  desc "Updates nil comment status to 'public'"
  task :update_comment_status => :environment do
    Comment.where(status: nil).each do |comment|
      comment.update(status: 'public')
    end
  end
end
