<% if namespaced? -%>
require_dependency "<%= namespaced_path %>/application_controller"

<% end -%>
<% module_namespacing do -%>
class <%= controller_class_name %>Controller < ApplicationController
  before_action :authenticate_usuario!
  before_action :autoriza_usuario!
  before_action :set_<%= singular_table_name %>, only: [:show, :edit, :update, :destroy, :imprimir]
  before_action only: [:destroy] do
    destroy_by_autorization(@<%= singular_table_name %>)
  end

  def index
    @<%= plural_table_name %> = <%= orm_class.all(class_name) %>
  end

  def imprimir_lista
    @<%= plural_table_name %> = <%= orm_class.all(class_name) %>

    respond_to do |format|
      format.pdf do
        render pdf: "<%= plural_table_name %>", title: "Lista de <%= plural_table_name %>", orientation: "Landscape", header: { html: {template: "layouts/_cabecalho.pdf.slim", locals: {titulo: "Lista de <%= class_name.demodulize.underscore.capitalize.pluralize %>"} }, spacing: 5 }, footer: { right: "[page]", font_size: 7, html: { template: "layouts/_rodape.pdf.slim" }, spacing: 0 }
      end
      format.xlsx
    end
  end

  def show
  end

  def imprimir
    respond_to do |format|
      format.pdf do
        render pdf: "cadastro_de_<%= singular_table_name %>", title: "Cadastro de <%= class_name.demodulize.underscore.capitalize %>", header: { html: {template: "layouts/_cabecalho.pdf.slim", locals: {titulo: "Cadastro de <%= class_name.demodulize.underscore.capitalize.pluralize %>"} }, spacing: 5 }, footer: { right: "[page]", font_size: 7, html: { template: "layouts/_rodape.pdf.slim" }, spacing: 0 }
      end
    end
  end

  def new
    @<%= singular_table_name %> = <%= orm_class.build(class_name) %>
  end

  def edit
  end

  def create
    @<%= singular_table_name %> = <%= orm_class.build(class_name, "#{singular_table_name}_params") %>

    if @<%= orm_instance.save %>
      redirect_to <%= redirect_resource_name %>, notice: <%= "'Cadastro realizado com sucesso.'" %>
    else
      render :new
    end
  end

  def update
    if @<%= orm_instance.update("#{singular_table_name}_params") %>
      redirect_to <%= redirect_resource_name %>, notice: <%= "'Alteração realizada com sucesso.'" %>
    else
      render :edit
    end
  end

  def destroy
    if @<%= orm_instance.destroy %>
      redirect_to <%= index_helper %>_path, notice: <%= "'Cadastro removido com sucesso.'" %>
    else
      redirect_to  <%= index_helper %>_path, danger: "#{@<%= singular_table_name %>.errors[:base].join(", ")}"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_<%= singular_table_name %>
      @<%= singular_table_name %> = <%= orm_class.find(class_name, "params[:id]") %>
    end

    # Only allow a trusted parameter "white list" through.
    def <%= "#{singular_table_name}_params" %>
      <%- if attributes_names.empty? -%>
      params.fetch(:<%= singular_table_name %>, {})
      <%- else -%>
      params.require(:<%= singular_table_name %>).permit(<%= permitted_params %>)
      <%- end -%>
    end
end
<% end -%>
