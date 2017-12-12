class ApplicationSerializer < ActiveModel::Serializer
  private

  # 轉換為 unix time
  #
  # @param fields [Symble] 要轉換的欄位名稱
  def self.to_unix_time(*fields)
    fields.each do |field|
      # 動態產生 methods，並把回傳結果變更為 unix time
      #
      # @return [Integer]
      define_method field do
        object.send(field).to_i
      end

      # 動態產生 methods prefix with `raw_`，回傳原始資料
      #
      # @return [String]
      define_method "raw_#{field}" do
        object.send(field).to_i
      end
    end
  end
end
