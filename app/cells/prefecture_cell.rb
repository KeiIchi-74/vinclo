class PrefectureCell < Cell::ViewModel
  def search_prefectures
    @prefectures = Prefecture.where.not(id: 1)
    render
  end
end
