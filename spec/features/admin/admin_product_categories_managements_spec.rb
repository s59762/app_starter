require 'rails_helper'

RSpec.feature 'Admin::ProductCategoriesManagements', type: :feature do
  let!(:category_1) { create(:product_category, name: '生活用品') }
  let!(:sub_category_1_of_category_1) { create(:product_category, name: '肥皂', parent_id: category_1.id) }
  let!(:category_2) { create(:product_category, name: '電玩遊戲') }
  let!(:sub_category_1_of_category_2) { create(:product_category, name: 'Nintendo Switch', parent_id: category_2.id) }

  before(:each) do
    login_as_default_admin
    visit admin_product_categories_path

    find('[data-behavior="product-category-list"] tbody tr', match: :first)
  end

  describe '商品分類列表' do
    scenario '要顯示所有主分類', js: true do
      expect(page).to have_selector('[data-behavior="product-category-list"] tbody tr', count: 2)
      expect(page).to have_content(category_1.name)
      expect(page).to have_content(category_2.name)
    end

    scenario '要能顯示子分類', js: true do
      open_all_detail_view_for_table_rows

      expect(page).to have_content(sub_category_1_of_category_1.name)
      expect(page).to have_content(sub_category_1_of_category_2.name)
    end
  end

  describe '建立商品分類' do
    let(:category_name) { '生活情趣' }
    let(:sub_category_name) { 'Playstation' }

    context '若沒有填寫名稱' do
      scenario '會出現錯誤訊息', js: true do
        open_new_product_category_form
        form = find('.product-category-new-form')

        find('[data-behavior="submit-button"]').click

        expect(page).to have_content(I18n.t('messages.failure.validation_failure'))
        expect(form).to have_css('.is-danger')
        expect(page).to have_content(I18n.t('errors.messages.blank'))
      end
    end

    context '若填寫了完整資料' do
      scenario '要能成功新增一個商品分類', js: true do
        open_new_product_category_form

        find('[data-behavior="product-category-name-field"]').set category_name
        find('[data-behavior="submit-button"]').click

        expect(page).to have_content('已成功新增')
        expect(page).to have_content(category_name)
      end

      scenario '要能在已存在的商品分類下新增子分類', js: true do
        open_new_sub_category_form

        find('[data-behavior="product-category-name-field"]').set sub_category_name
        find('[data-behavior="submit-button"]').click

        open_all_detail_view_for_table_rows

        expect(page).to have_content('已成功新增')
        expect(page).to have_content(sub_category_name)
      end
    end
  end

  describe '編輯商品分類' do
    let(:new_name) { 'Do You Know The Way?' }

    context '若名稱空白' do
      scenario '會出現錯誤訊息', js: true do
        open_edit_product_category_form

        form = find('.product-category-edit-form')
        name_field = find('[data-behavior="product-category-name-field"]')

        find('[data-behavior="product-category-name-field"]').set '', clear: :backspace
        find('[data-behavior="submit-button"]').click

        expect(page).to have_content(I18n.t('messages.failure.validation_failure'))
        expect(form).to have_css('.is-danger')
        expect(page).to have_content(I18n.t('errors.messages.blank'))
      end
    end

    context '若填寫了完整資料' do
      scenario '要能成功變更個商品資料', js: true do
        open_edit_product_category_form

        find('[data-behavior="product-category-name-field"]').set new_name, clear: :backspace
        find('[data-behavior="submit-button"]').click

        expect(page).to have_content('已成功更新')
        expect(page).to have_content(new_name)
      end
    end
  end

  def open_all_detail_view_for_table_rows
    all('[data-behavior="product-category-list"] tbody tr').each do |row|
      row.find('a[role="button"]').click
    end
  end

  def open_new_product_category_form
    find('[data-behavior="new-product-category-button"]').click
  end

  def open_new_sub_category_form
    all('[data-behavior="product-category-list"] tbody tr')[1].find('[data-behavior="new-sub-category-button"').click
  end

  def open_edit_product_category_form
    all('[data-behavior="product-category-list"] tbody tr')[1].find('[data-behavior="edit-product-category-button"').click
  end
end
