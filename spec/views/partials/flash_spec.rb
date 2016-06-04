RSpec.describe 'partials/flash.erb', type: :view do
  context 'with flash message' do
    let(:with_flash_body) do
      app.get("/test_with_flash") do
        erb("partials/flash".to_sym, locals: {flash: {success_flash: "SUCCESS FLASH", error_flash: "ERROR FLASH"}})
      end
      get("/test_with_flash").body
    end

    it 'should show success flash' do
      expect(with_flash_body).to have_selector('[class="flash success_flash"]')
    end

    it 'should show error flash' do
      expect(with_flash_body).to have_selector('[class="flash error_flash"]')
    end
  end

  context 'without flash messages' do
    let(:without_flash_body) do
      app.get("/test_without_flash") do
        erb("partials/flash".to_sym, locals: {flash: {}})
      end
      get("/test_without_flash").body
    end

    it 'should not show success flash' do
      expect(without_flash_body).not_to have_selector('[class="flash success_flash"]')
    end

    it 'should not show error flash' do
      expect(without_flash_body).not_to have_selector('[class="flash error_flash"]')
    end
  end
end
