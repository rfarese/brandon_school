class TourCacheManager
  attr_reader :tour_manager, :tour, :qrcode_identifier

  def initialize(tour, qrcode_identifier)
    @tour = tour
    @qrcode_identifier = qrcode_identifier
  end

  def execute
    if exists?
      fetch_tour_manager_cache
      delete_and_update_cache
    else
      new_tour_manager
      create_tour_manager_cache
    end
  end

  def exists?
    Rails.cache.exist?("tour_#{tour.id}_manager_cache")
  end

  def fetch_tour_manager_cache
    @tour_manager = Rails.cache.fetch("tour_#{tour.id}_manager_cache")
    set_qrcode_identifier
  end

  def set_qrcode_identifier
    tour_manager.qrcode_identifier = qrcode_identifier
    organize_tour_manager
  end

  def organize_tour_manager
    tour_manager.organize
  end

  def delete_tour_manager
    Rails.cache.delete("tour_#{tour.id}_manager_cache")
  end

  def delete_and_update_cache
    delete_tour_manager
    create_tour_manager_cache
  end

  def create_tour_manager_cache
    Rails.cache.fetch("tour_#{tour.id}_manager_cache", expires_in: 1.hour) do
      tour_manager
    end
  end

  def new_tour_manager
    @tour_manager = TourManager.new(tour, qrcode_identifier)
    tour_manager.organize
  end
end
