class Admin::ProductCategoryForm < ApplicationForm
  model ProductCategory

  properties :name,
             :description,
             :parent_id

  validates :name, presence: true
  validate :too_many_parent_level?

  # 限制 ProductCategory 僅能建立最多 2 層子類別（包含自己共 3 層關係）
  def too_many_parent_level?
    return unless ProductCategory.where(id: parent_id).exists?

    current_parent = ProductCategory.find(parent_id)

    if parent_existence_for(current_parent)
      errors.add(:parent_id, :too_many_level) if parent_existence_for(current_parent.parent)
    end
  end

  private

  def parent_existence_for(category)
    category.parent.present?
  end
end
