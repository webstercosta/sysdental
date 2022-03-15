<% module_namespacing do -%>
class <%= class_name %> < <%= parent_class_name.classify %>
  has_paper_trail
<% attributes.select(&:reference?).each do |attribute| -%>
  belongs_to :<%= attribute.name %><%= ', polymorphic: true' if attribute.polymorphic? %><%= ', required: true' if attribute.required? %>
<% end -%>

  validates_presence_of <%= attributes_names.map { |a| ":#{a}" }.join(", ") %>

end
<% end -%>
