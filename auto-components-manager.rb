module Angieimation
  module AutoComponentManager
    SIGNATURE = <<~SIGN
      © 2025 Angieimation / Angela Rossi
      AutoComponentManager for SketchUp plugin
      Created: August 2025
      Contact: angela.rossi393@gmail.com
    SIGN
    # Print signature at load time (when file is required or loaded)
    puts SIGNATURE
    def self.clean_and_export(model, output_file = "components_report.txt")
      components = model.definitions.to_a
      # 1. Remove unused components
      components.reject! { |c| c.instances.empty? }
      # 2. Detect duplicates
      grouped = components.group_by { |c| c.name }
      duplicates = grouped.select { |_, arr| arr.size > 1 }.keys
      # 3. Prepare report
      report = []
      report << "Cleaned Components Report"
      report << "========================="
      report << "Total unique components: #{grouped.keys.size}"
      report << "Duplicates found: #{duplicates.empty? ? 'None' : duplicates.join(', ')}"
      report << "\nList of Components:"
      grouped.keys.each { |name| report << "- #{name}" }
      # 4. Export to TXT
      File.open(output_file, "w") { |f| f.puts report.join("\n") }
      # 5. Print to console
      puts report.join("\n")
      puts "Report generated: #{output_file}"
    end
  end
end