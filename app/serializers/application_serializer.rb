class ApplicationSerializer < ActiveModel::Serializer
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

  # Money 的欄位會是 Currency Object，在這邊可以把回傳內容變更為 Object 中的 fractional
  #
  # @param fields [Symble] 要轉換的欄位名稱
  def self.money_to_integer(*fields)
    fields.each do |field|
      # 動態產生 methods，僅回傳 fractional attribute
      #
      # @return [Integer]
      define_method field do
        object.send(field).fractional
      end
    end
  end
end
