class PrefectureCell < Cell::ViewModel
  include JpPrefecture
  def search_prefectures
    @prefectures = JpPrefecture::Prefecture.all
    render
  end
end
