require 'rails/generators/erb/scaffold/scaffold_generator'

module Slim
  module Generators
    class ScaffoldGenerator < Erb::Generators::ScaffoldGenerator
      source_root File.expand_path(File.join('..', 'templates'), __FILE__)

      def copy_view_files
        available_views.each do |view|
          filename = filename_with_extensions view
          template filename, File.join('app', 'views', controller_file_path, filename)
        end
      end

      hook_for :form_builder, as: :scaffold

      protected
      def available_views
        ['index.html', 'edit.html', 'show.html', 'new.html', '_form.html', 'imprimir_lista.pdf', 'imprimir.pdf']
      end

      def handler
        :slim
      end

      def filename_with_extensions(name)
        [name, handler].compact.join(".")
      end
    end
  end
end
