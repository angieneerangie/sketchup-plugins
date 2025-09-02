module Angieimation
  module AutoMaterialManager

    SIGNATURE = <<~SIGN
      © 2025 Angieimation / Angela Rossi
      AutoMaterialManager for SketchUp plugin
      Created: August 2025
      Contact: angela.rossi393@gmail.com
    SIGN

    # Print signature at load time (when file is required or loaded)
    puts SIGNATURE

    def self.clean_and_export(model, output_file = "materials_report.txt")
      materials = model.materials.to_a

      # 1. Remove unnamed materials
      materials.reject! { |m| m.name.strip.empty? }

      # 2. Detect duplicates
      grouped = materials.group_by { |m| m.name }
      duplicates = grouped.select { |_, arr| arr.size > 1 }.keys

      # 3. Prepare report
      report = []
      report << "Cleaned Materials Report"
      report << "========================="
      report << "Total unique materials: #{grouped.keys.size}"
      report << "Duplicates found: #{duplicates.empty? ? 'None' : duplicates.join(', ')}"
      report << "\nList of Materials:"
      grouped.keys.each { |name| report << "- #{name}" }

      # 4. Export to TXT
      File.open(output_file, "w") { |f| f.puts report.join("\n") }

      # 5. Print to console
      puts report.join("\n")

      puts "Report generated: #{output_file}"
    end

  end
end
