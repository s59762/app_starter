require 'rails_helper'

RSpec.feature "Admin::CreateProducts", type: :feature do
  let!(:admin_1) { create(:admin) }
  let(:product_name) { '飛天小女警抱枕' }
  let(:product_description) { '好軟好舒服，毛毛不洗澡' }
  let(:blank_error_message) { '不能為空白' }

  before(:each) do
    login_as_default_admin
    visit new_admin_product_path

    find('.product-new-form')
  end

  describe '建立商品' do
    scenario '若沒填寫品名，應該不能儲存並會顯示錯誤訊息', js: true do
      click_submit_button

      expect(page).to have_content(blank_error_message)
    end

    scenario '若沒填寫商品描述，應該不能儲存並會顯示錯誤訊息', js: true do
      find('[data-behavior="product-name"]').set product_name
      click_submit_button

      expect(page).to have_content(blank_error_message)
    end

    scenario '折扣價不可以超過售價，否則會出現錯誤訊息', js: true do
      find('[data-behavior="product-name"]').set product_name
      fill_text_in_editor(product_description)
      fill_in_wrong_price_info

      click_submit_button

      expect(current_path).to eq new_admin_product_path
    end

    scenario '若所需的資訊都有填寫，可正常建立商品', js: true do
      find('[data-behavior="product-name"]').set product_name
      fill_text_in_editor(product_description)
      attach_image
      is_preorder_checkbox.click
      fill_in_correct_price_info

      click_submit_button

      expect(current_path).to eq admin_products_path
      expect(page).to have_content product_name
    end
  end

  def click_submit_button
    find('[data-behavior="submit-button"]').click
  end

  def fill_text_in_editor(text)
    page.execute_script(%(
      document.querySelector('[data-behavior="product-description"] .ql-editor').append('#{text}')
    ))
  end

  def is_preorder_checkbox
    find('[data-behavior="product-is-oreorder"]')
  end

  def fill_in_wrong_price_info
    find('[data-behavior="product-original-price"]').set 1000
    find('[data-behavior="product-sell-price"]').set 1500
    find('[data-behavior="product-sell-price"]').set 2000
  end

  def fill_in_correct_price_info
    find('[data-behavior="product-original-price"]').set 1000
    find('[data-behavior="product-sell-price"]').set 1500
    find('[data-behavior="product-sell-price"]').set 1200
  end

  def attach_image
    page.execute_script %( document.querySelector('[data-behavior="product-description"] .ql-toolbar .ql-image').click() )
    attach_file('quill-image-input', Rails.root.join('spec', 'images', 'pic.jpg'), make_visible: true)
  end
end
