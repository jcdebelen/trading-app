class DeleteJob < ApplicationJob
  queue_as :default

  def perform(id)
    # Do something later
    @p = Pending.find(id)
    @p.destroy
  end
end
