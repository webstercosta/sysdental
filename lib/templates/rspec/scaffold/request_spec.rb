require 'rails_helper'

RSpec.describe "<%= controller_class_name %>", type: :request do
  let(:usuario) { FactoryBot.create(:usuario) }

  <% modelo_no_singular = class_name.underscore.split("/").last -%>
	<% modelo_no_plural = class_name.underscore.pluralize.split("/").last -%>

  # let(:atributos_invalidos) {
  #     { _atributo: '_valor' }
  # }

  before(:each) do
    sign_in usuario
  end

  <% unless options[:singleton] %>
  describe 'GET #index' do
    it "lista <%= modelo_no_plural %>" do
      <%= singular_table_name %> = FactoryBot.create(:<%= singular_table_name %>)
      get <%= index_helper %>_path
      expect(response).to be_successful
    end
  end
  <% end %>

  describe 'GET #imprimir_lista' do
    it "imprime lista de <%= modelo_no_plural %>" do
      <%= singular_table_name %> = FactoryBot.create(:<%= singular_table_name %>)
      get imprimir_lista_<%= plural_table_name %>_path, params: { format: :pdf }
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it "exibe <%= singular_table_name %>" do
      <%= singular_table_name %> = FactoryBot.create(:<%= singular_table_name %>)
      get <%= singular_table_name %>_path(<%= singular_table_name %>)
      expect(response).to be_successful
    end
  end

  describe 'GET #imprimir' do
    it "imprime <%= singular_table_name %>" do
      <%= singular_table_name %> = FactoryBot.create(:<%= singular_table_name %>)
      get imprimir_<%= singular_table_name %>_path(<%= singular_table_name %>), params: { format: :pdf }
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it "instancia um novo <%= singular_table_name %>" do
      get new_<%= singular_table_name %>_path
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    it "cadastra <%= singular_table_name %>" do
      <%= singular_table_name %> = attributes_for(:<%= singular_table_name %>)
      post <%= plural_table_name %>_path, params: { <%= singular_table_name %>: <%= singular_table_name %> }
      expect(response).to redirect_to <%= singular_table_name %>_path(<%= class_name %>.where("_atributo = ?", <%= singular_table_name %>[:_atributo]).last)
    end

    it "cadastra <%= singular_table_name %> com erros de validação" do
      post <%= plural_table_name %>_path, params: { <%= singular_table_name %>: atributos_invalidos }
      expect(response).to render_template(:new)
    end
  end

  describe 'GET #edit' do
    it "abre formulário para edição de um <%= singular_table_name %>" do
      <%= singular_table_name %> = FactoryBot.create(:<%= singular_table_name %>)
      get edit_<%= singular_table_name %>_path(<%= singular_table_name %>.id)
      expect(response).to be_successful
    end
  end

  describe 'PATCH #update' do
    it "atualiza <%= singular_table_name %>" do
      <%= singular_table_name %> = FactoryBot.create(:<%= singular_table_name %>)
      patch <%= singular_table_name %>_path(<%= singular_table_name %>), params: { <%= singular_table_name %>: attributes_for(:<%= singular_table_name %>) }

      expect(response).to redirect_to <%= singular_table_name %>_path(<%= singular_table_name %>)
    end

    it "atualiza <%= singular_table_name %> com erros de validação" do
      <%= singular_table_name %> = FactoryBot.create(:<%= singular_table_name %>)
      patch <%= singular_table_name %>_path(<%= singular_table_name %>), params: { <%= singular_table_name %>: atributos_invalidos }
      expect(response).to render_template(:edit)
    end
  end

  describe 'DELETE #destroy' do
    it "remove <%= singular_table_name %>" do
      <%= singular_table_name %> = FactoryBot.create(:<%= singular_table_name %>)
      post <%= singular_table_name %>_path(<%= singular_table_name %>.id), params: { _method: :delete }
      expect(response).to redirect_to <%= plural_table_name %>_path
    end
  end

end
