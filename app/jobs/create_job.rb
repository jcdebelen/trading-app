class CreateJob < ApplicationJob
  queue_as :default

  def perform(params)
    # Do something later
    Transaction.create(params)
  end
end
