INPUT = "./input.txt"

# allow for cid
REQUIRED_FIELDS = %w(byr iyr eyr hgt hcl ecl pid)

def valid_passports(validate: false)
  valid_count = 0
  IO.foreach(INPUT, "\n\n") do |record|
    record = record.gsub("\n", " ").strip
    items = record.split(" ")
    fields_hash = Hash[items.map {|el| el.split ':'}]
    puts fields_hash.inspect
    if (REQUIRED_FIELDS - fields_hash.keys).empty?
      if validate
        valid = true
        REQUIRED_FIELDS.each do |field|
          value = fields_hash[field]
          case field
          when "byr"
            valid = false unless value.size == 4 && value.to_i >= 1920 && value.to_i <=2002
          when "iyr"
            valid = false unless value.size == 4 && value.to_i >= 2010 && value.to_i <=2020
          when "eyr"
            valid = false unless value.size == 4 && value.to_i >= 2020 && value.to_i <=2030
          when "hgt"
            height, unit = value.scan(/\d+|[a-zA-Z]+/)
            valid = false unless ["in", "cm"].include?(unit)
            if unit == "cm"
              valid = false unless height.to_i >=150 && height.to_i <= 193
            else
              valid = false unless height.to_i >=59 && height.to_i <= 76
            end
          when "hcl"
            valid = false if (value =~ /^#(?:[0-9a-fA-F]{3}){1,2}$/).nil?
          when "ecl"
            valid = false unless %w(amb blu brn gry grn hzl oth).include?(value) 
          when "pid"
            valid = false if (value =~ /\A\d{9}\z/).nil?
          end
        end
        valid_count += 1 if valid
      else
        valid_count += 1
      end
    end
  end
  valid_count
end

puts "part 1 #{valid_passports}"
puts "part 2 #{valid_passports(validate: true)}"
