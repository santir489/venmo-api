task code_analysis: :environment do
  sh 'bundle exec rubocop app config lib test'
  sh 'bundle exec reek app config lib'
  sh 'bundle exec rails_best_practices .'
end
