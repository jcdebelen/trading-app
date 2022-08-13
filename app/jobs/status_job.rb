class StatusJob < ApplicationJob
  queue_as :default

  def perform(id, quantity=0)
    # Do something later
    t = Transaction.find(id)
    t.status = 'completed'
    t.stock_quantity += quantity
    t.save
  end

end
