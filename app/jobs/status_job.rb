class StatusJob < ApplicationJob
  queue_as :default

  def perform(id)
    # Do something later
    user = Transaction.find(id)
    user.status = 'completed'
    user.save
  end
end
